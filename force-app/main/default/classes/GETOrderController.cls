public with sharing class GETOrderController {
    public GETOrderController() {

    }

    public static string orderGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETOrdersWrapper ordWraper = new InforGETOrdersWrapper();
        InforSytelineCalloutsConfigs__c OrdCsRec = InforSytelineCalloutsConfigs__c.getInstance('GET Orders');
        string modDateFilter = '';
        if(OrdCsRec!= null && OrdCsRec.Last_Sync_Date__c != null)
        {
            modDateFilter = 'RecordDate >= '+Date.valueOf(OrdCsRec.Last_Sync_Date__c);
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
                    System.enqueueJob(new ProcessGETRecordsQueueable(respBody,'SLCos'));
                }
                else{

                    ordWraper = parsedResponse(res);
                    msgtoReturn = processParsedResponse(ordWraper);
                    HTTPHandler.updateSyncDateInCS('GET Orders', datetime.now());
                }
            }
        }
        return msgtoReturn;
    }


    public static InforGETOrdersWrapper parsedResponse(HttpResponse resp){
        XMLSerializer serializer = new XMLSerializer();
        //replacing item tag as it is a keyword in json convert class
        string respBody = InforStylineCalloutsUtil.removeItemKeyword(resp.getBody());
        string jsonConv = serializer.XMLToJson(respBody);
        InforGETOrdersWrapper r = (InforGETOrdersWrapper) JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);

        return r;
    }

    public static string processParsedResponse(InforGETOrdersWrapper wrap){
        string messageToRet = '';
        list<Order> listOfOrders = new list<Order>();

        InforGETOrdersWrapper.Envelope env = wrap.Envelope;
        InforGETOrdersWrapper.Body b = env.Body;
        InforGETOrdersWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETOrdersWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETOrdersWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETOrdersWrapper.SLCos slCos = difgr.SLCos;
        list<InforGETOrdersWrapper.IDO> listOfIDO = slCos.IDO;
        if(listOfIDO.size() > 0){
            for(InforGETOrdersWrapper.IDO idoCos : listOfIDO){
                string accExternalID = idoCos.CustNum+idoCos.CustSeq;
                Order ord = new Order();
                ord.Infor_Order_Id__c = idoCos.CoNum;
                ord.EffectiveDate = date.valueOf(idoCos.OrderDate);
                ord.Status = idoCos.DerStatFormatted;

                Account accountReference = new Account(Infor_Customer_External_Id__c = accExternalID);
                ord.Account = accountReference;
                System.debug('accExternalID= '+accExternalID);
                if(!accExternalID.contains('null')){
                    listOfOrders.add(ord);
                }
                
                //String uniq = idoCust.CustNum + idoCust.CustSeq;
                //System.debug('uniq=='+uniq);

            }

            upsert listOfOrders Infor_Order_Id__c;

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }
}