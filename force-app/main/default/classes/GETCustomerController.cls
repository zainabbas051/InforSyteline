public without sharing class GETCustomerController {
    public GETCustomerController() {

    }

    public static string customerGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETCustomersWrapper custWraper = new InforGETCustomersWrapper();
        InforSytelineCalloutsConfigs__c AccCsRec = InforSytelineCalloutsConfigs__c.getInstance('GET Accounts');
        string modDateFilter = '';
        if(AccCsRec!= null && AccCsRec.Last_Sync_Date__c != null)
        {
            modDateFilter = 'RecordDate >= '+Date.valueOf(AccCsRec.Last_Sync_Date__c);
        }
        if(!String.isBlank(qryFilter) && !String.isBlank(modDateFilter)){
            qryFilter += ' AND ' + modDateFilter;
        }
        else if(String.isBlank(qryFilter) && !String.isBlank(modDateFilter))
        {
            qryFilter = modDateFilter;
        }
        if(!String.isBlank(accToken)){
            httpResponse res = InforStylineCalloutsUtil.loadDataCall(accToken, IDOName, qryFlds, qryFilter, qryOrderBy, qryLimit);
            if(res.getStatusCode() == 200)
            {
                if(qryLimit == null || qryLimit == 0 || qryLimit > 100){
                    String respBody = res.getBody();
                    System.enqueueJob(new ProcessGETRecordsQueueable(respBody,'SLCustomers'));
                }
                else{

                    custWraper = parsedResponse(res);
                    msgtoReturn = processParsedResponse(custWraper);
                    HTTPHandler.updateSyncDateInCS('GET Accounts', datetime.now());
                }
            }
        }
        return msgtoReturn;
    }

    public static InforGETCustomersWrapper parsedResponse(HttpResponse resp){
        XMLSerializer serializer = new XMLSerializer();
        string jsonConv = serializer.XMLToJson(resp.getBody());
        System.debug('#jsonConv='+jsonConv);
        InforGETCustomersWrapper r = (InforGETCustomersWrapper) JSON.deserialize(jsonConv, InforGETCustomersWrapper.class);

        return r;
    }

    public static string processParsedResponse(InforGETCustomersWrapper wrap){
        string messageToRet = '';
        list<Account> listOfAccount = new list<Account>();

        InforGETCustomersWrapper.Envelope env = wrap.Envelope;
        InforGETCustomersWrapper.Body b = env.Body;
        InforGETCustomersWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETCustomersWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETCustomersWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETCustomersWrapper.SLCustomers slCus = difgr.SLCustomers;
        list<InforGETCustomersWrapper.IDO> listOfIDO = slCus.IDO;
        if(listOfIDO.size() > 0){
            for(InforGETCustomersWrapper.IDO idoCust : listOfIDO){
                string streetAdd = '';
                if(!String.isBlank(idoCust.Addr_1)){
                    streetAdd += idoCust.Addr_1;
                }
                if(!String.isBlank(idoCust.Addr_2)){
                    streetAdd += idoCust.Addr_2;
                }
                if(!String.isBlank(idoCust.Addr_3)){
                    streetAdd += idoCust.Addr_3;
                }
                if(!String.isBlank(idoCust.Addr_4)){
                    streetAdd += idoCust.Addr_4;
                }
                Account acc = new Account();
                acc.Name =  !string.isBlank(idoCust.Name) ? idoCust.Name : '-';
                acc.InforCustomerNumber__c = idoCust.CustNum;
                acc.Infor_Customer_Sequence__c = idoCust.CustSeq;
                acc.Infor_Customer_External_Id__c = idoCust.CustNum + idoCust.CustSeq;
                acc.Phone = idoCust.Phone_1;
                acc.BillingStreet = streetAdd;
                acc.BillingCity = idoCust.City;
                acc.BillingState = idoCust.State;
                acc.BillingPostalCode = idoCust.Zip;
                acc.BillingCountry = idoCust.Country;
                listOfAccount.add(acc);
                //String uniq = idoCust.CustNum + idoCust.CustSeq;
                //System.debug('uniq=='+uniq);

            }

            upsert listOfAccount Infor_Customer_External_Id__c;

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }

}