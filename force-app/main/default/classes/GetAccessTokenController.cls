public without sharing class GetAccessTokenController {
    public GetAccessTokenController() {

    }


    public static string makeAccessTokenCallout(string csRec){
        
        string accToken = '';
        string CSRecName = label.InforStyline_TestToyoConfig;
        if(!String.isBlank(csRec)){
            CSRecName = csRec;
            InforSytelineConfiguration__c inforCS = InforSytelineConfiguration__c.getValues(CSRecName);
            if(!string.isblank(inforCS.AccessTokenStart__c) && !string.isblank(inforCS.AccessTokenEnd__c)){
                accToken = inforCS.AccessTokenStart__c + inforCS.AccessTokenEnd__c;
                return accToken;
            }
        }
    
        
        HttpResponse repsonse = InforStylineCalloutsUtil.getAccessToken(CSRecName);
        accToken = processAccTokenResponse(repsonse);
        return accToken;

    }

    public static string processAccTokenResponse(HttpResponse repsonse){

        string xmlResp = '';
        string accToken = '';
        if(repsonse.getStatusCode() == 200){
            xmlResp = repsonse.getBody();
        }
        else{
            accToken = 'error: Some error has occured';
            return accToken;
        }
        if(!String.isBlank(xmlResp)){
            Dom.Document doc = new Dom.Document();  
            doc.load(xmlResp);  
            Dom.XMLNode rootElement = doc.getRootElement();
            for(Dom.XMLNode fchild : rootElement.getChildElements()){
                for(Dom.XMLNode schild : fchild.getChildElements()){
                    for(Dom.XMLNode tokenchild : schild.getChildElements()){
                        if(tokenchild.getName() == 'CreateSessionTokenResult'){
                            accToken = tokenchild.getText();
                        }
                    }
                }
            }
        }
        return accToken;
    }

    public static void saveTokenInCS(string accToken, string CSRecName){
        //either get acess token and expiry date here from map or from calling function
        InforSytelineConfiguration__c inforCS = InforSytelineConfiguration__c.getValues(CSRecName);
        inforCS.AccessTokenStart__c = accToken.substring(0,253);
        inforCS.AccessTokenEnd__c = accToken.substring(253);
       // HttpRequest_Handler.tokenVal = response.get('token');
        
        system.debug('this is token value'+accToken);
        update inforCS;
    }
}