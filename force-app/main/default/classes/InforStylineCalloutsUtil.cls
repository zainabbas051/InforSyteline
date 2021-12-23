public without sharing class InforStylineCalloutsUtil {
    
    public InforStylineCalloutsUtil() {

    }

    public static HttpResponse getAccessToken(string csRec)
    {   
        string CSRecName = label.InforStyline_TestToyoConfig;
        if(!String.isBlank(csRec)){
            CSRecName = csRec;
        }
        string body = generateTokenBody(CSRecName);
        system.debug('body=='+body);

        HttpResponse response = HTTPHandler.sendRequest(body);
        system.debug('Response: '+response.getBody());
        return response;
    }

    public static HttpResponse loadDataCall(string accToken, string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        string body = generateLoadDataBody(accToken, IDOName, qryFlds, qryFilter, qryOrderBy, qryLimit);
        HttpResponse response = HTTPHandler.sendRequest(body);
        system.debug('Response: '+response.getBody());
        return response;
    }

    public static HttpResponse saveDataCall(string accToken, string UpdDateSetBody){
        string body = generateSaveDataSetBody(accToken, UpdDateSetBody);
        HttpResponse response = HTTPHandler.sendRequest(body);
        system.debug('Response: '+response.getBody());
        return response;
    }

    public static string generateLoadDataBody(string accTok, string IDOName, list<string> qryFlds, string qryFilter, list<string> qryOrderBy, integer qryLimit){
        
        string aToken = !String.isBlank(accTok) ? accTok : '';
        string qFields = qryFlds.size() > 0 ? string.join(qryFlds, ',') : '';
        string tblName = !String.isBlank(IDOName) ? IDOName : 'SLCustomers';
        string qFilter = !string.isBlank(qryFilter) ? qryFilter : '';
        string qOrdBy = qryOrderBy.size() > 0 ? string.join(qryOrderBy, ',') : '';
        integer qLimit = qryLimit != null ? qryLimit : 0;

        string xmlBody = '<?xml version="1.0" encoding="utf-8"?>';
        xmlBody += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
        xmlBody += '<soap:Body>';
        xmlBody += '<LoadDataSet xmlns="http://frontstep.com/IDOWebService">';
        xmlBody += '<strSessionToken>'+aToken+'</strSessionToken>';
        xmlBody += '<strIDOName>'+tblName+'</strIDOName>';
        xmlBody += '<strPropertyList>'+qFields+'</strPropertyList>';
        xmlBody += '<strFilter>'+qFilter+'</strFilter>';
        xmlBody += '<strOrderBy>'+qOrdBy+'</strOrderBy>';
        xmlBody += '<strPostQueryMethod></strPostQueryMethod>';
        xmlBody += '<iRecordCap>'+qLimit+'</iRecordCap>';
        xmlBody += '</LoadDataSet>';
        xmlBody += '</soap:Body>';
        xmlBody += '</soap:Envelope>';

        return xmlBody;

    }

    public static string generateTokenBody(string csName){

        InforSytelineConfiguration__c inforCS = InforSytelineConfiguration__c.getValues(csName);
        string uname = inforCS.Username__c;
        string pwd = inforCS.Password__c;
        string configName = inforCS.Configuration_Name__c;
        string tokenXML = '<?xml version="1.0" encoding="utf-8"?>';
        tokenXML += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
        tokenXML += '<soap:Body>';
        tokenXML += '<CreateSessionToken xmlns="http://frontstep.com/IDOWebService">';
        tokenXML += '<strUserId>' + uname + '</strUserId>';
        tokenXML += '<strPswd>' + pwd + '</strPswd>';
        tokenXML += '<strConfig>' + configName + '</strConfig>';
        tokenXML += '</CreateSessionToken>';
        tokenXML += '</soap:Body>';
        tokenXML += '</soap:Envelope>';

        return tokenXML;
    }

    public static string generateSaveDataSetBody(string accToken, string updDSBody){

        string xmlToRet = '<?xml version="1.0" encoding="utf-8"?>';
        xmlToRet += '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">';
        xmlToRet += '<s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
        xmlToRet += '<SaveDataSet xmlns="http://frontstep.com/IDOWebService">';
        xmlToRet += '<strSessionToken>'+accToken+'</strSessionToken>';
        xmlToRet += '<updateDataSet>' + updDSBody + '</updateDataSet>';
        xmlToRet += '<refreshAfterSave>true</refreshAfterSave>';
        xmlToRet += '<strCustomInsert/>';
        xmlToRet += '<strCustomUpdate/>';
        xmlToRet += '<strCustomDelete/>';
        xmlToRet += '</SaveDataSet>';
        xmlToRet += '</s:Body>';
        xmlToRet += '</s:Envelope>';

        return xmlToRet;



    }

    public static String removeItemKeyword(string respBody){
        string strToReturn = '';
        if(!String.isBlank(respBody)){
            strToReturn = respBody;
        }
        if(strToReturn.contains('<Item>')){
            strToReturn = strToReturn.replaceAll('<Item>', '<ItemUniqueNum>');
        }
        if(strToReturn.contains('</Item>')){
            strToReturn = strToReturn.replaceAll('</Item>', '</ItemUniqueNum>');
        }
        return strToReturn;
    }

}