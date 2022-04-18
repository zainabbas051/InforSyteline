public with sharing class ProcessGETRecordsQueueable implements Queueable{
    
    public string respBody;
    public string IDOName;
    
    public ProcessGETRecordsQueueable() {

    }

    public ProcessGETRecordsQueueable(String lrespBody, string lIDOName) {
        this.respBody = lrespBody;
        this.IDOName = lIDOName;
    }

    public void execute(QueueableContext context) {
        XMLSerializer serializer = new XMLSerializer();
        
        //replacing item tag as it is a keyword in json convert class
        string validStr = InforStylineCalloutsUtil.removeItemKeyword(respBody);
        
        // string jsonConv = serializer.XMLToJson(validStr);
        String jsonConv = serializer.xmlToJSON(validStr, new set<String>{'IDO'});
        string IDONameLower = IDOName.toLowerCase();
        System.debug('#jsonConv='+jsonConv);
        
        if(IDONameLower.contains('customer')){
            InforGETCustomersWrapper r = GETCustomerController.checkEmptyResponse(jsonConv);
            //InforGETCustomersWrapper r = (InforGETCustomersWrapper) JSON.deserialize(jsonConv, InforGETCustomersWrapper.class);
            GETCustomerController.processParsedResponse(r);
            System.debug('#parsed='+r);
            HTTPHandler.updateSyncDateInCS('GET Accounts', datetime.now());
        }
        if(IDONameLower.contains('slcos')){
            InforGETOrdersWrapper r = GETOrderController.checkEmptyResponse(jsonConv);
            //InforGETOrdersWrapper r = (InforGETOrdersWrapper) JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);
            GETOrderController.processParsedResponse(r);
            HTTPHandler.updateSyncDateInCS('GET Orders', datetime.now());
        }
        if(IDONameLower.contains('slitems')){
            InforGETIemsWrapper r = GETItemController.checkEmptyResponse(jsonConv);
            //InforGETIemsWrapper r = (InforGETIemsWrapper) JSON.deserialize(jsonConv, InforGETIemsWrapper.class);
            GETItemController.processParsedResponse(r);
            System.debug('#parsed='+r);
            HTTPHandler.updateSyncDateInCS('GET Products', datetime.now());
        }
        if(IDONameLower.contains('prices')){
            InforGETItemPricesWrapper r =  GETItemPricesController.checkEmptyResponse(jsonConv);
            //InforGETItemPricesWrapper r = (InforGETItemPricesWrapper) JSON.deserialize(jsonConv, InforGETItemPricesWrapper.class);
            GETItemPricesController.processParsedResponse(r);
            HTTPHandler.updateSyncDateInCS('GET PBEs', datetime.now());
        }
        if(IDONameLower.contains('slcoitems')){
            InforGETOrderItemsWrapper r = GETOrderItemsController.checkEmptyResponse(jsonConv);
            //InforGETOrderItemsWrapper r = (InforGETOrderItemsWrapper) JSON.deserialize(jsonConv, InforGETOrderItemsWrapper.class);
            GETOrderItemsController.processParsedResponse(r);
            HTTPHandler.updateSyncDateInCS('GET Order Items', datetime.now());
        }

             
    }
}