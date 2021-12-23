public with sharing class GETItemController {
    public GETItemController() {

    }


    public static string itemGETCallout(string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string msgtoReturn = '';
        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        InforGETIemsWrapper itemWraper = new InforGETIemsWrapper();
        if(!String.isBlank(accToken)){
            httpResponse res = InforStylineCalloutsUtil.loadDataCall(accToken, IDOName, qryFlds, qryFilter, qryOrderBy, qryLimit);
            if(qryLimit == null || qryLimit == 0 || qryLimit > 100){
                String respBody = res.getBody();
                System.enqueueJob(new ProcessGETRecordsQueueable(respBody,'SLItems'));
            }
            else{

                itemWraper = parsedResponse(res);
                msgtoReturn = processParsedResponse(itemWraper);
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
        InforGETIemsWrapper r = (InforGETIemsWrapper) JSON.deserialize(jsonConv, InforGETIemsWrapper.class);
        System.debug('r='+r);


        return r;
    }

    public static string processParsedResponse(InforGETIemsWrapper wrap){
        string messageToRet = '';
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
}