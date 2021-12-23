public without sharing class POSTCustomerController {
    public POSTCustomerController() {

    }


    public static string createCustomerInInfor(set<string> setAccIds){

        string csRec = label.InforStyline_TestToyoConfig;
        string accToken = GetAccessTokenController.makeAccessTokenCallout(csRec);
        string msg = '';
        
        map<string, string> mapOfInfoFields = new Map<String,String>();
        mapOfInfoFields.put('Name', 'string');
        mapOfInfoFields.put('CustNum', 'string');
        mapOfInfoFields.put('CustSeq', 'decimal');

        map<string, string> mapOfMappings = new Map<String,String>();
        mapOfMappings.put('Name','Name');
        mapOfMappings.put('CustNum', 'InforCustomerNumber__c');
        mapOfMappings.put('CustSeq', 'Infor_Customer_Sequence__c');

        map<string, Account> mapOfAccounts = new map<string, Account>();
        for(Account a: [select id, name, InforCustomerNumber__c from Account where id IN : setAccIds ]){
            mapOfAccounts.put(a.id, a);
        }

        string IDOName = 'SLCustomers';
        string schemaTag = CreateRecordXMLUtility.returnXMLSchemaTag(IDOName, mapOfInfoFields);
        string diffGrmTag = CreateRecordXMLUtility.returnXMLDiffGramTag(IDOName, mapOfInfoFields, mapOfMappings, mapOfAccounts);
        string updDSBody = schemaTag+diffGrmTag;

        HttpResponse resp = InforStylineCalloutsUtil.saveDataCall(accToken, updDSBody);
        if(resp.getStatusCode() == 200){
            msg = 'Success';
        }
        else{
            msg = string.valueOf(resp.getStatusCode()) + '-' + resp.getBody(); 
        }
        System.debug('msg= '+ msg);
        return msg;
    }
}