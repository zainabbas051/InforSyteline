public with sharing class GETItemPricesController {
    public GETItemPricesController() {

    }


    public static string itemPricesGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforSytelineCalloutsConfigs__c PBECsRec = InforSytelineCalloutsConfigs__c.getInstance('GET PBEs');
        string modDateFilter = '';
        if(PBECsRec!= null && PBECsRec.Last_Sync_Date__c != null)
        {
            date recDate =  Date.newInstance(PBECsRec.Last_Sync_Date__c.year(), PBECsRec.Last_Sync_Date__c.month(), PBECsRec.Last_Sync_Date__c.day());
            modDateFilter = 'RecordDate >= '+'\''+recDate+'\'';
            //modDateFilter = 'RecordDate >= '+Date.valueOf(PBECsRec.Last_Sync_Date__c);
        }
        if(!String.isBlank(qryFilter) && !String.isBlank(modDateFilter)){
            qryFilter += ' AND ' + modDateFilter;
        }
        else if(String.isBlank(qryFilter) && !String.isBlank(modDateFilter))
        {
            qryFilter = modDateFilter;
        }
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
                    HTTPHandler.updateSyncDateInCS('GET PBEs', datetime.now());
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
        
        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETItemPricesWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETItemPricesWrapper r1 =  (InforGETItemPricesWrapper)JSON.deserialize(jsonConv, InforGETItemPricesWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }

        //InforGETItemPricesWrapper r = (InforGETItemPricesWrapper) JSON.deserialize(jsonConv, InforGETItemPricesWrapper.class);

        return r;
    }


    public static string processParsedResponse(InforGETItemPricesWrapper wrap){
        string messageToRet = '';

        if(wrap == null){
            messageToRet = 'No Records Found';
            return messageToRet;
        }

        string PbId = [select id from Pricebook2 where IsStandard = true].id;
        Set<String> setOfUniqueIds = new set<string>();
        list<PricebookEntry> listOfPBEs = new list<PricebookEntry>();

        InforGETItemPricesWrapper.Envelope env = wrap.Envelope;
        InforGETItemPricesWrapper.Body b = env.Body;
        InforGETItemPricesWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETItemPricesWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETItemPricesWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETItemPricesWrapper.SLItemPrices SLItmPrc = difgr.SLItemPrices;
        list<InforGETItemPricesWrapper.IDO> listOfIDO = SLItmPrc.IDO;
        map<string,PricebookEntry> mapOfDistinctPrices = new map<string,PricebookEntry>();
        if(listOfIDO.size() > 0){
            for(InforGETItemPricesWrapper.IDO itmpr : listOfIDO){

                string uniqueKey = itmpr.ItemUniqueNum+'|'+itmpr.CurrCode; //+'|'+itmpr.EffectDate;
                PricebookEntry pbe = new PricebookEntry();
                pbe.EffectDate__c = itmpr.EffectDate;
                pbe.UnitPrice = itmpr.UnitPrice1;
                pbe.Infor_Unique_Key__c = uniqueKey;
                pbe.Pricebook2Id = PbId;
                pbe.currencyIsocode = itmpr.CurrCode;
                pbe.IsActive = true;
                
                Product2 prodRef = new Product2(InforItemNumber__c = itmpr.ItemUniqueNum);
                pbe.Product2 = prodRef;

                if(!uniqueKey.contains('null')){
                    mapOfDistinctPrices.put(uniqueKey,pbe);
                }
                System.debug('uniqueKey=='+uniqueKey);
                setOfUniqueIds.add(uniqueKey);
                
                //String uniq = idoCust.CustNum + idoCust.CustSeq;
                

            }
            System.debug('setOfUniqueIds=='+setOfUniqueIds.size());
            System.debug('mapOfDistinctPrices=='+mapOfDistinctPrices.values().size());
            Schema.SObjectField extId = PricebookEntry.getSobjectType().getDescribe().fields.getMap().get('Infor_Unique_Key__c');
            //List<Database.UpsertResult> results = Database.upsert(listOfPBEs,extId , false);
            List<Database.UpsertResult> results = Database.upsert(mapOfDistinctPrices.values(),extId , false);
            for(Database.UpsertResult theResult:results) {
                if(theResult.isSuccess())
                  continue; // next item
                List<Database.Error> errors = theResult.getErrors();
                for(Database.Error theError:Errors) {
                    System.debug('PBI Upsert error='+theError.getMessage() + ':' + theError.getFields());
                }
            }

        }
        system.debug('listOfIDO.size()=='+listOfIDO.size());


        return messageToRet;
    }
}