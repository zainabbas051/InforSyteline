public with sharing class GETItemPricesController {
    public GETItemPricesController() {

    }


    public static string itemPricesGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETItemPricesWrapper ItmPrWrap = new InforGETItemPricesWrapper();
        if(!String.isBlank(accToken)){
            httpResponse res = InforStylineCalloutsUtil.loadDataCall(accToken, IDOName, qryFlds, qryFilter, qryOrderBy, qryLimit);
            if(res.getStatusCode() == 200)
            {
                if(qryLimit == null || qryLimit == 0 || qryLimit > 100){
                    String respBody = res.getBody();
                    System.enqueueJob(new ProcessGETRecordsQueueable(respBody,'SLItemPrices'));
                }
                else{

                    ItmPrWrap = parsedResponse(res);
                    msgtoReturn = processParsedResponse(ItmPrWrap);
                }
            }
        }
        return msgtoReturn;
    }

    public static InforGETItemPricesWrapper parsedResponse(HttpResponse resp){
        XMLSerializer serializer = new XMLSerializer();
        //replacing item tag as it is a keyword in json convert class
        string respBody = InforStylineCalloutsUtil.removeItemKeyword(resp.getBody());
        string jsonConv = serializer.XMLToJson(respBody);
        InforGETItemPricesWrapper r = (InforGETItemPricesWrapper) JSON.deserialize(jsonConv, InforGETItemPricesWrapper.class);

        return r;
    }


    public static string processParsedResponse(InforGETItemPricesWrapper wrap){
        string messageToRet = '';

        string PbId = [select id from Pricebook2 where IsStandard = true].id;

        list<PricebookEntry> listOfPBEs = new list<PricebookEntry>();

        InforGETItemPricesWrapper.Envelope env = wrap.Envelope;
        InforGETItemPricesWrapper.Body b = env.Body;
        InforGETItemPricesWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETItemPricesWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETItemPricesWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETItemPricesWrapper.SLItemPrices SLItmPrc = difgr.SLItemPrices;
        list<InforGETItemPricesWrapper.IDO> listOfIDO = SLItmPrc.IDO;
        if(listOfIDO.size() > 0){
            for(InforGETItemPricesWrapper.IDO itmpr : listOfIDO){
                string uniqueKey = itmpr.CurrCode+'|'+itmpr.EffectDate;
                PricebookEntry pbe = new PricebookEntry();
                pbe.EffectDate__c = itmpr.EffectDate;
                pbe.UnitPrice = itmpr.UnitPrice1;
                pbe.Infor_Unique_Key__c = uniqueKey;
                pbe.Pricebook2Id = PbId;
                
                Product2 prodRef = new Product2(InforItemNumber__c = itmpr.ItemUniqueNum);
                pbe.Product2 = prodRef;
                if(!uniqueKey.contains('null')){
                    listOfPBEs.add(pbe);
                }

                
                //String uniq = idoCust.CustNum + idoCust.CustSeq;
                //System.debug('uniq=='+uniq);

            }
            Schema.SObjectField extId = PricebookEntry.getSobjectType().getDescribe().fields.getMap().get('Infor_Unique_Key__c');
            Database.upsert(listOfPBEs,extId , false);
            //upsert listOfPBEs Infor_Unique_Key__c;

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }
}
