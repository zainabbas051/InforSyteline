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
            date recDate =  Date.newInstance(OrdCsRec.Last_Sync_Date__c.year(), OrdCsRec.Last_Sync_Date__c.month(), OrdCsRec.Last_Sync_Date__c.day());
            modDateFilter = 'RecordDate >= '+'\''+recDate+'\'';
            //modDateFilter = 'RecordDate >= '+Date.valueOf(OrdCsRec.Last_Sync_Date__c);
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
        // string jsonConv = serializer.XMLToJson(respBody);
        String jsonConv = serializer.xmlToJSON(resp.getBody(), new set<String>{'IDO'});

        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETOrdersWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETOrdersWrapper r1 =  (InforGETOrdersWrapper)JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }

        //InforGETOrdersWrapper r = (InforGETOrdersWrapper) JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);

        return r;
    }

    public static string processParsedResponse(InforGETOrdersWrapper wrap){
        string messageToRet = '';

        if(wrap == null){
            messageToRet = 'No Records Found';
            string body = 'No Records to Sync from Infor Syteline';
            GenerateNotification(0, 0, body);
            return messageToRet;
        }

        list<Order> listOfOrders = new list<Order>();

        InforGETOrdersWrapper.Envelope env = wrap.Envelope;
        InforGETOrdersWrapper.Body b = env.Body;
        InforGETOrdersWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETOrdersWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETOrdersWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETOrdersWrapper.SLCos slCos = difgr.SLCos;
        list<InforGETOrdersWrapper.IDO> listOfIDO = slCos.IDO;
        if(listOfIDO.size() > 0){
            string PbId = [select id from Pricebook2 where IsStandard = true and isactive = true limit 1].id;
            for(InforGETOrdersWrapper.IDO idoCos : listOfIDO){
                string accExternalID = idoCos.CustNum+'-'+idoCos.CustSeq;
                Order ord = new Order();
                ord.Infor_Order_Id__c = idoCos.CoNum;
                ord.EffectiveDate = date.valueOf(idoCos.OrderDate);
                ord.Status = idoCos.DerStatFormatted;
                ord.Pricebook2Id = PbId;
                ord.CurrencyISOCode = idoCos.CurrCode;
                
                string streetAdd = '';
                if(!String.isBlank(idoCos.BillToAddr_1)){
                    streetAdd += idoCos.BillToAddr_1 + ' ';
                }
                if(!String.isBlank(idoCos.BillToAddr_2)){
                    streetAdd += idoCos.BillToAddr_2 + ' ';
                }
                if(!String.isBlank(idoCos.BillToAddr_3)){
                    streetAdd += idoCos.BillToAddr_3 + ' ';
                }
                if(!String.isBlank(idoCos.BillToAddr_4)){
                    streetAdd += idoCos.BillToAddr_4;
                }
                ord.BillingStreet = streetAdd;
                ord.BillingCity = idoCos.BillToCity;
                ord.BillingState = idoCos.BillToState;
                ord.BillingPostalCode = idoCos.BillToZip;
                ord.BillingCountry = idoCos.BillToCountry;

                Account accountReference = new Account(Infor_Customer_External_Id__c = accExternalID);
                ord.Account = accountReference;
                System.debug('accExternalID= '+accExternalID);
                if(!accExternalID.contains('null')){
                    listOfOrders.add(ord);
                }
                
                //String uniq = idoCust.CustNum + idoCust.CustSeq;
                //System.debug('uniq=='+uniq);

            }
            Integer totalRecs = listOfOrders.size();
            Integer successRecs = 0;
            Integer errorRecs = 0;
            Schema.SObjectField extId = Order.getSobjectType().getDescribe().fields.getMap().get('Infor_Order_Id__c');
            list<Database.UpsertResult> results = Database.upsert(listOfOrders,extId , false);
            //upsert listOfOrders Infor_Order_Id__c;
            for(Database.UpsertResult rs : results)
            {
                if(rs.isSuccess()){
                    successRecs++;
                }
                else if(rs.getErrors().size() > 0)
                {
                    for(Database.Error er : rs.getErrors())
                    {
                        system.debug('Error : '+ er.getMessage() + ':' + er.getFields());

                    }
                }
            }
            errorRecs = totalRecs - successRecs;
            string body = 'Orders Retrieval from Infor Syteline has been completed! \r\n Succes Records : '+ successRecs + '\r\n Error Records : '+ errorRecs;
            GenerateNotification(successRecs, errorRecs, body);

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }

    public static InforGETOrdersWrapper checkEmptyResponse(string jsonConv){
        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETOrdersWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETOrdersWrapper r1 =  (InforGETOrdersWrapper)JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }

        //InforGETOrdersWrapper r = (InforGETOrdersWrapper) JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);

        return r;
    }

    public static void GenerateNotification(integer succCount, integer errCount, string body){
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setBody(body);
        notification.setTitle('Orders Retrieval Completed!');
        notification.setSenderId(Userinfo.getUserId());
        CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Infor_Processing_Complete_Notification'];
        notification.setNotificationTypeId(type.id);
        notification.setTargetId('000000000000000AAA'); // target object id
        notification.send(new Set<String> { Userinfo.getUserId() });
    }
}