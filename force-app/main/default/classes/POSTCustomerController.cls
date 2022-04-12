public without sharing class POSTCustomerController {
    public POSTCustomerController() {

    }

    @AuraEnabled
    public static string PostCustomer(string AccSFId){
        string resultmsg = ''; 
        Set<String> setOfAccIds = new Set<String>();
        setOfAccIds.add(AccSFId);
        try {
            resultmsg = createCustomerInInfor(setOfAccIds);
        } 
        catch (Exception e) {
            resultmsg = 'Exception Occured : '+ e.getMessage();
        }

        return resultmsg;        

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

        string queryFields = String.join(mapOfMappings.values(), ',');
        string query = 'select '+ queryFields + ' from Account where id IN : setAccIds';
        
        map<string, Account> mapOfAccounts = new map<string, Account>();
        list<Account> listAccounts = database.query(query);
        
        /*for(Account a: [select id, name, InforCustomerNumber__c,Infor_Customer_Sequence__c from Account where id IN : setAccIds ]){
            mapOfAccounts.put(a.id, a);
        }*/

        for(Account a: listAccounts){
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
            msg = resp.getBody(); 
            msg = msg.replaceAll('(\\r|\\n)+','');
            system.debug('msg=='+msg);
            XMLSerializer serializer = new XMLSerializer();
            string jsonConv = serializer.XMLToJson(msg);
            system.debug('jsonConv=='+jsonConv);

            POSTCustomerController r =  (POSTCustomerController)JSON.deserialize(jsonConv, POSTCustomerController.class);
            msg = returnFaultMsg(r);

        }
        System.debug('msg= '+ msg);
        HTTPHandler.updateSyncDateInCS('POST Accounts', datetime.now());
        return msg;
    }

    public static String returnFaultMsg(POSTCustomerController r){
        string errorMsg = 'Error : ';

        POSTCustomerController.Envelope env = r.Envelope;
        POSTCustomerController.Body b = env.Body;
        POSTCustomerController.Fault fault = b.Fault;

        if(fault != null && fault.faultstring != null)
        {
            errorMsg += fault.faultstring;
        }

        return errorMsg;
    }


    public Envelope Envelope;

    public class Fault {
        public String detail;
        public String faultstring;
        public String faultcode;
    }

    public class Envelope {
        public Body Body;
    }

    public class Body {
        public Fault Fault;
    }
}