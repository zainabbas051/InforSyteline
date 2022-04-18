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
            date recDate =  Date.newInstance(AccCsRec.Last_Sync_Date__c.year(), AccCsRec.Last_Sync_Date__c.month(), AccCsRec.Last_Sync_Date__c.day());
            modDateFilter = 'RecordDate >= '+'\''+recDate+'\'';
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
        //string jsonConv = serializer.XMLToJson(resp.getBody());
        String jsonConv = serializer.xmlToJSON(resp.getBody(), new set<String>{'IDO'});
        System.debug('#jsonConv='+jsonConv);
        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETCustomersWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                
                InforGETCustomersWrapper r1 =  (InforGETCustomersWrapper)JSON.deserialize(jsonConv, InforGETCustomersWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }

        //InforGETCustomersWrapper r = (InforGETCustomersWrapper) JSON.deserialize(jsonConv, InforGETCustomersWrapper.class);
        

        return r;
    }

    public static string processParsedResponse(InforGETCustomersWrapper wrap){
        InforSytelineCalloutsConfigs__c AdditionalFeatureCS = InforSytelineCalloutsConfigs__c.getInstance('GET Accounts - No Overwrite');
        
        string messageToRet = '';
        if(wrap == null){
            messageToRet = 'No Records Found';
            string body = 'No Records to Sync from Infor Syteline';
            GenerateNotification(0, 0, body);
            return messageToRet;
        }

        InforGETCustomersWrapper.Envelope env = wrap.Envelope;
        InforGETCustomersWrapper.Body b = env.Body;
        InforGETCustomersWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETCustomersWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETCustomersWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETCustomersWrapper.SLCustomers slCus = difgr.SLCustomers;
        list<InforGETCustomersWrapper.IDO> listOfIDO = slCus.IDO;

        if(AdditionalFeatureCS != null){
            if(AdditionalFeatureCS.Feature_Enabled__c){
                messageToRet = doUpdateAccounts(listOfIDO);
            }
            else {
                messageToRet = doUpsertAccounts(listOfIDO);
            }
        }

        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }

    public static string doUpsertAccounts(list<InforGETCustomersWrapper.IDO> listOfIDO){
        string messageToRet = '';
        list<Account> listOfAccount = new list<Account>();

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
                acc.Infor_Customer_External_Id__c = idoCust.CustNum +'-'+ idoCust.CustSeq;
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
            Integer totalRecs = listOfAccount.size();
            Integer successRecs = 0;
            Integer errorRecs = 0;
            try{
                Schema.SObjectField extId = Account.getSobjectType().getDescribe().fields.getMap().get('Infor_Customer_External_Id__c');
                list<Database.UpsertResult> results = Database.upsert(listOfAccount, extId, false);
                for(Database.UpsertResult rs : results)
                {
                    if(rs.isSuccess()){
                        successRecs++;
                    }
                }
                //upsert listOfAccount Infor_Customer_External_Id__c;
                messageToRet = 'Imported Successfully';
            }
            catch(Exception e){
                messageToRet = 'An exception has occurred : ' + e.getMessage();
            }
            errorRecs = totalRecs - successRecs;
            string body = 'Customers Retrieval from Infor Syteline has been completed! \r\n Succes Records : '+ successRecs + '\r\n Error Records : '+ errorRecs;
            GenerateNotification(successRecs, errorRecs, body);

        }
        return messageToRet;
    }

    public static string doUpdateAccounts(list<InforGETCustomersWrapper.IDO> listOfIDO){
        string messageToRet = 'Imported Successfully';
        list<Account> listOfAccounttoUpdate = new list<Account>();
        list<Account> listOfAccounttoInsert = new list<Account>();
        set<String> setOfExtIds = new set<String>();
        map<String, String> mapOfExistingCustomers = new map<String, String>();
        set<String> setOfExistingExtIDs = new Set<String>();
        if(listOfIDO.size() > 0){
            for(InforGETCustomersWrapper.IDO idoCust : listOfIDO){
                string extID = idoCust.CustNum +'-'+ idoCust.CustSeq;
                setOfExtIds.add(extID);
            }

            if(setOfExtIds.size() > 0){
                for(Account acc : [select id, Infor_Customer_External_Id__c from Account where Infor_Customer_External_Id__c IN : setOfExtIds]){
                    mapOfExistingCustomers.put(acc.Infor_Customer_External_Id__c, acc.id);
                }
            }
    
            for(InforGETCustomersWrapper.IDO idoCust : listOfIDO) {
                string extID = idoCust.CustNum +'-'+ idoCust.CustSeq;
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
                acc.InforCustomerNumber__c = idoCust.CustNum;
                acc.Infor_Customer_Sequence__c = idoCust.CustSeq;
                acc.Infor_Customer_External_Id__c = idoCust.CustNum +'-'+ idoCust.CustSeq;
                acc.Phone = idoCust.Phone_1;
                acc.BillingStreet = streetAdd;
                acc.BillingCity = idoCust.City;
                acc.BillingState = idoCust.State;
                acc.BillingPostalCode = idoCust.Zip;
                acc.BillingCountry = idoCust.Country;
                if(!mapOfExistingCustomers.containskey(extID)){
                    acc.Name =  !string.isBlank(idoCust.Name) ? idoCust.Name : '-';
                    listOfAccounttoInsert.add(acc);
                }
                else{
                    acc.id = mapOfExistingCustomers.get(extID);
                    listOfAccounttoUpdate.add(acc);
                }

            }
            Integer totalRecs = listOfAccounttoInsert.size() + listOfAccounttoUpdate.size();
            Integer successRecs = 0;
            Integer errorRecs = 0;
            if (listOfAccounttoInsert.size() > 0) {
                System.debug('Insert List Size() == '+ listOfAccounttoInsert.size());
                try {
                    //insert listOfAccounttoInsert;
                    Database.SaveResult[] resultList = Database.insert(listOfAccounttoInsert, false);
                    for(Database.SaveResult rs : resultList)
                    {
                        if(rs.isSuccess()){
                            successRecs++;
                        }
                    }
                }
                catch (Exception e) {
                    messageToRet = 'An exception has occurred : ' + e.getMessage();
                }
            }
            if(listOfAccounttoUpdate.size() > 0){
                System.debug('Update List Size() == '+ listOfAccounttoUpdate.size());
                try {
                    //update listOfAccounttoUpdate;
                    Database.SaveResult[] resultList = Database.update(listOfAccounttoUpdate, false);
                    for(Database.SaveResult rs : resultList)
                    {
                        if(rs.isSuccess()){
                            successRecs++;
                        }
                    }
                }
                catch (Exception e) {
                    messageToRet = 'An exception has occurred : ' + e.getMessage();
                }
            }

            errorRecs = totalRecs - successRecs;
            string body = 'Customers Retrieval from Infor Syteline has been completed! \r\n Succes Records : '+ successRecs + '\r\n Error Records : '+ errorRecs;
            GenerateNotification(successRecs, errorRecs, body);
        }
        
        return messageToRet;

    }


    public static InforGETCustomersWrapper checkEmptyResponse(string jsonConv){
        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETCustomersWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETCustomersWrapper r1 =  (InforGETCustomersWrapper)JSON.deserialize(jsonConv, InforGETCustomersWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }
        

        return r;
    }

    public static void GenerateNotification(integer succCount, integer errCount, string body){
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setBody(body);
        notification.setTitle('Customers Retrieval Completed!');
        notification.setSenderId(Userinfo.getUserId());
        CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Infor_Processing_Complete_Notification'];
        notification.setNotificationTypeId(type.id);
        notification.setTargetId('000000000000000AAA'); // target object id
        notification.send(new Set<String> { Userinfo.getUserId() });
    }

}