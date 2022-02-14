public without sharing class HTTPHandler {
    
    public HTTPHandler() {

    }


    public static HttpResponse sendRequest(string body)
    {
        string CSRecName = label.InforStyline_TestToyoConfig;
        InforSytelineConfiguration__c inforCS = InforSytelineConfiguration__c.getValues(CSRecName);
        string endPt = inforCS.Endpoint__c;
        string method = 'POST';

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setEndpoint(endPt);
        request.setTimeout(120000);
        request.setHeader('Content-Type', 'text/xml');
        request.setHeader('Content-Length', '0');
           
        request.setBody(body);
         
        System.debug('reqBody='+request.getBody());
        system.debug('request=='+request);
       
        HttpResponse response = http.send(request);
        return response;
        
    }

    public static void updateSyncDateInCS(string CallOutName, datetime syncDate){
        InforSytelineCalloutsConfigs__c csRec = InforSytelineCalloutsConfigs__c.getInstance(CallOutName);
        if(csRec != null){
            csRec.Last_Sync_Date__c = syncDate;
            update csRec;
        }
    }
}