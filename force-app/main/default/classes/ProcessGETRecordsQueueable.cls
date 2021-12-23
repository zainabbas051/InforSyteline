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
        
        string jsonConv = serializer.XMLToJson(validStr);
        string IDONameLower = IDOName.toLowerCase();
        System.debug('#jsonConv='+jsonConv);
        
        if(IDONameLower.contains('customer')){
            InforGETCustomersWrapper r = (InforGETCustomersWrapper) JSON.deserialize(jsonConv, InforGETCustomersWrapper.class);
            GETCustomerController.processParsedResponse(r);
            System.debug('#parsed='+r);
        }
        if(IDONameLower.contains('slcos')){
            InforGETOrdersWrapper r = (InforGETOrdersWrapper) JSON.deserialize(jsonConv, InforGETOrdersWrapper.class);
            GETOrderController.processParsedResponse(r);
        }
        if(IDONameLower.contains('slitems')){
            InforGETIemsWrapper r = (InforGETIemsWrapper) JSON.deserialize(jsonConv, InforGETIemsWrapper.class);
            GETItemController.processParsedResponse(r);
            System.debug('#parsed='+r);
        }
        if(IDONameLower.contains('prices')){
            InforGETItemPricesWrapper r = (InforGETItemPricesWrapper) JSON.deserialize(jsonConv, InforGETItemPricesWrapper.class);
            GETItemPricesController.processParsedResponse(r);
        }

             
    }
}
