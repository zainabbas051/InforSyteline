public with sharing class GETItemController {
    public GETItemController() {

    }


    public static string itemGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETIemsWrapper itemWraper = new InforGETIemsWrapper();
        InforSytelineCalloutsConfigs__c ProdCsRec = InforSytelineCalloutsConfigs__c.getInstance('GET Products');
        string modDateFilter = '';
        if(ProdCsRec!= null && ProdCsRec.Last_Sync_Date__c != null)
        {
            date recDate =  Date.newInstance(ProdCsRec.Last_Sync_Date__c.year(), ProdCsRec.Last_Sync_Date__c.month(), ProdCsRec.Last_Sync_Date__c.day());
            modDateFilter = 'RecordDate >= '+'\''+recDate+'\'';
            //modDateFilter = 'RecordDate >= '+Date.valueOf(ProdCsRec.Last_Sync_Date__c);
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
            if(qryLimit == null || qryLimit == 0 || qryLimit > 100){
                String respBody = res.getBody();
                System.enqueueJob(new ProcessGETRecordsQueueable(respBody,'SLItems'));
            }
            else{

                itemWraper = parsedResponse(res);
                msgtoReturn = processParsedResponse(itemWraper);
                HTTPHandler.updateSyncDateInCS('GET Products', datetime.now());
            }
        }
        return msgtoReturn;
    }

    public static InforGETIemsWrapper parsedResponse(HttpResponse resp){
        XMLSerializer serializer = new XMLSerializer();
        
        //replacing item tag as it is a keyword in json convert class
        string respBody = InforStylineCalloutsUtil.removeItemKeyword(resp.getBody());
        string jsonConv = serializer.XMLToJson(respBody);
        System.debug('#jsonConv='+jsonConv);

        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETIemsWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETIemsWrapper r1 =  (InforGETIemsWrapper)JSON.deserialize(jsonConv, InforGETIemsWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }

        /*InforGETIemsWrapper r = (InforGETIemsWrapper) JSON.deserialize(jsonConv, InforGETIemsWrapper.class);
        System.debug('r='+r);
        */

        return r;
    }

    public static string processParsedResponse(InforGETIemsWrapper wrap){
        string messageToRet = '';
        
        if(wrap == null){
            messageToRet = 'No Records Found';
            return messageToRet;
        }
        list<Product2> listOfProds = new list<Product2>();

        InforGETIemsWrapper.Envelope env = wrap.Envelope;
        InforGETIemsWrapper.Body b = env.Body;
        InforGETIemsWrapper.LoadDataSetResponse ldr = b.LoadDataSetResponse;
        InforGETIemsWrapper.LoadDataSetResult ldRes = ldr.LoadDataSetResult;
        InforGETIemsWrapper.Diffgram difgr = ldRes.diffgram;
        InforGETIemsWrapper.SLItems SLItms = difgr.SLItems;
        list<InforGETIemsWrapper.IDO> listOfIDO = SLItms.IDO;
        if(listOfIDO.size() > 0){
            system.debug('listOfIDO.size()=='+listOfIDO.size());
            for(InforGETIemsWrapper.IDO idoItem : listOfIDO){
                system.debug('idoItem=='+idoItem);
                Product2 prod = new Product2();
                prod.Name = idoItem.ItemUniqueNum;
                prod.InforItemNumber__c = idoItem.ItemUniqueNum;
                prod.Stock_Quantity__c = idoItem.DerQtyOnHand;
                prod.ProductCode = idoItem.ProductCode;
                prod.Description = idoItem.Description;

                if(!String.isBlank(idoItem.ItemUniqueNum) || !idoItem.ItemUniqueNum.contains('null')){
                    listOfProds.add(prod);
                }
                
            }
            Schema.SObjectField extId = Product2.getSobjectType().getDescribe().fields.getMap().get('InforItemNumber__c');
            Database.upsert(listOfProds,extId , false);
            
        }
 
        return messageToRet;
    }

    public static InforGETIemsWrapper checkEmptyResponse(string jsonConv){
        Map<String, Object> JsonDeserialMap = (Map<String, Object>) JSON.deserializeUntyped(jsonConv);
        Map<String, Object> envMap = (Map<String, Object>)JsonDeserialMap.get('Envelope');
        Map<String, Object> bodyMap = (Map<String, Object>)envMap.get('Body');
        Map<String, Object> responseMap = (Map<String, Object>)bodyMap.get('LoadDataSetResponse');
        Map<String, Object> resultMap = (Map<String, Object>)responseMap.get('LoadDataSetResult');
        
        System.debug('resultMap== '+resultMap);

        InforGETIemsWrapper r;
        if(resultMap.containsKey('diffgram')){
            if(resultMap.get('diffgram') == null || resultMap.get('diffgram') == ''){
                r = null;
            }
            else{
                InforGETIemsWrapper r1 =  (InforGETIemsWrapper)JSON.deserialize(jsonConv, InforGETIemsWrapper.class);
                r = r1;
                System.debug('#r = '+ r);
            }
        }
        return r;
    }
}