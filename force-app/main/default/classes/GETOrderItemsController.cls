public with sharing class GETOrderItemsController {
    public GETOrderItemsController() {

    }

    public static string itemPricesGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETOrderItemsWrapper ItmPrWrap = new InforGETOrderItemsWrapper();
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
        string jsonConv = serializer.XMLToJson(respBody);
        InforGETOrderItemsWrapper r = (InforGETOrderItemsWrapper) JSON.deserialize(jsonConv, InforGETOrderItemsWrapper.class);

        return r;
    }


    public static string processParsedResponse(InforGETOrderItemsWrapper wrap){
        string messageToRet = '';
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
                oli.listprice = itmpr.Price;
                oli.Infor_OrderItem_Id__c = string.valueOf(itmpr.CoLine)+string.valueOf(itmpr.CoRelease);
                Order ord = new Order(Infor_Order_Id__c = itmpr.CoNum);
                oli.Order = ord;
                PricebookEntry pbe = new PricebookEntry(Infor_Unique_Key__c = itmpr.ItemUniqueNum+'|'+itmpr.DerCurrCode);
                oli.PricebookEntry = pbe;

                listOfOLIs.add(oli);

            }
            System.debug('listOfOLIs=='+listOfOLIs.size());
            Schema.SObjectField extId = OrderItem.getSobjectType().getDescribe().fields.getMap().get('Infor_OrderItem_Id__c');
            //List<Database.UpsertResult> results = Database.upsert(listOfPBEs,extId , false);
            List<Database.UpsertResult> results = Database.upsert(listOfOLIs,extId , false);
            for(Database.UpsertResult theResult:results) {
                if(theResult.isSuccess())
                  continue; // next item
                List<Database.Error> errors = theResult.getErrors();
                for(Database.Error theError:Errors) {
                    System.debug('OLI Upsert error='+theError.getMessage() + ':' + theError.getFields());
                }
            }

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }
}
