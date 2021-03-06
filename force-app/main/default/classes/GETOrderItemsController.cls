public with sharing class GETOrderItemsController {
    public GETOrderItemsController() {

    }

    public static string itemPricesGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETOrderItemsWrapper ItmPrWrap = new InforGETOrderItemsWrapper();
        InforSytelineCalloutsConfigs__c OrdItemCsRec = InforSytelineCalloutsConfigs__c.getInstance('GET Orders');
        string modDateFilter = '';
        if(OrdItemCsRec!= null && OrdItemCsRec.Last_Sync_Date__c != null)
        {
            date recDate =  Date.newInstance(OrdItemCsRec.Last_Sync_Date__c.year(), OrdItemCsRec.Last_Sync_Date__c.month(), OrdItemCsRec.Last_Sync_Date__c.day());
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
                    System.enqueueJob(new ProcessGETRecordsQueueable(respBody,'SLCoItems'));
                }
                else{

                    ItmPrWrap = parsedResponse(res);
                    msgtoReturn = processParsedResponse(ItmPrWrap);
                    HTTPHandler.updateSyncDateInCS('GET Order Items', datetime.now());
                }
            }
        }
        return msgtoReturn;
    }


    public static InforGETOrderItemsWrapper parsedResponse(HttpResponse resp){
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

        InforGETOrderItemsWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETOrderItemsWrapper r1 =  (InforGETOrderItemsWrapper)JSON.deserialize(jsonConv, InforGETOrderItemsWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }

        //InforGETOrderItemsWrapper r = (InforGETOrderItemsWrapper) JSON.deserialize(jsonConv, InforGETOrderItemsWrapper.class);

        return r;
    }


    public static string processParsedResponse(InforGETOrderItemsWrapper wrap){
        string messageToRet = '';

        if(wrap == null){
            messageToRet = 'No Records Found';
            string body = 'No Records to retrieve from Infor Syteline';
            GenerateNotification(0, 0, body);
            return messageToRet;
        }

        list<OrderItem> listOfOLIs = new list<OrderItem>();

        InforGETOrderItemsWrapper.Envelope env = wrap.Envelope;
        InforGETOrderItemsWrapper.Body b = env.Body;
        InforGETOrderItemsWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETOrderItemsWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETOrderItemsWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETOrderItemsWrapper.SLCoItems SLCoItems = difgr.SLCoItems;
        list<InforGETOrderItemsWrapper.IDO> listOfIDO = SLCoItems.IDO;
        map<string,PricebookEntry> mapOfDistinctPrices = new map<string,PricebookEntry>();
        if(listOfIDO.size() > 0){
            for(InforGETOrderItemsWrapper.IDO itmpr : listOfIDO){

                OrderItem oli = new OrderItem();
                oli.Quantity = itmpr.QtyOrdered;
                oli.UnitPrice = itmpr.Price;
                oli.Infor_OrderItem_Id__c = string.valueOf(itmpr.CoLine)+string.valueOf(itmpr.CoRelease) + '|'+itmpr.CoNum;
                Order ord = new Order(Infor_Order_Id__c = itmpr.CoNum);
                oli.Order = ord;
                PricebookEntry pbe = new PricebookEntry(Infor_Unique_Key__c = itmpr.ItemUniqueNum+'|'+itmpr.DerCurrCode);
                oli.PricebookEntry = pbe;

                listOfOLIs.add(oli);

            }
            System.debug('listOfOLIs=='+listOfOLIs.size());

            Integer totalRecs = listOfOLIs.size();
            Integer successRecs = 0;
            Integer errorRecs = 0;

            Schema.SObjectField extId = OrderItem.getSobjectType().getDescribe().fields.getMap().get('Infor_OrderItem_Id__c');
            //List<Database.UpsertResult> results = Database.upsert(listOfPBEs,extId , false);
            List<Database.UpsertResult> results = Database.upsert(listOfOLIs,extId , false);
            for(Database.UpsertResult theResult:results) {
                if(theResult.isSuccess()){
                    successRecs++;
                    continue; // next item
                }
                List<Database.Error> errors = theResult.getErrors();
                for(Database.Error theError:Errors) {
                    System.debug('OLI Upsert error='+theError.getMessage() + ':' + theError.getFields());
                }
            }
            errorRecs = totalRecs - successRecs;
            string body = 'Order Line Items Retrieval from Infor Syteline has been completed! \r\n Succes Records : '+ successRecs + '\r\n Error Records : '+ errorRecs;
            GenerateNotification(successRecs, errorRecs, body);

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }

    public static InforGETOrderItemsWrapper checkEmptyResponse(string jsonConv){
        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETOrderItemsWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETOrderItemsWrapper r1 =  (InforGETOrderItemsWrapper)JSON.deserialize(jsonConv, InforGETOrderItemsWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }
        return r;
    }

    public static void GenerateNotification(integer succCount, integer errCount, string body){
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setBody(body);
        notification.setTitle('Order Line Items Retrieval Completed!');
        notification.setSenderId(Userinfo.getUserId());
        CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Infor_Processing_Complete_Notification'];
        notification.setNotificationTypeId(type.id);
        notification.setTargetId('000000000000000AAA'); // target object id
        notification.send(new Set<String> { Userinfo.getUserId() });
    }
}