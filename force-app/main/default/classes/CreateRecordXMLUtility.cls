public without sharing class CreateRecordXMLUtility {
    public CreateRecordXMLUtility() {

    }


    public static string returnXMLSchemaTag(string InforIDOName, map<string, string> mapOfInforFieldsAndType){
        string xmlToRet = '';
        
        xmlToRet += '<xs:schema id="'+ InforIDOName + '" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">';
        xmlToRet += '<xs:element name="'+ InforIDOName + '" msdata:IsDataSet="true" msdata:UseCurrentLocale="true">';
        xmlToRet += '<xs:complexType>';
        xmlToRet += '<xs:choice minOccurs="0" maxOccurs="unbounded">';
        xmlToRet += '<xs:element name="IDO">';
        xmlToRet += '<xs:complexType>';
        xmlToRet += '<xs:sequence>';
        for(string infProp: mapOfInforFieldsAndType.keySet()){
            xmlToRet += '<xs:element name="' +infProp+ '" type="xs:'+mapOfInforFieldsAndType.get(infProp)+'" minOccurs="0"/>';
        }
        xmlToRet += '</xs:sequence>';
        xmlToRet += '</xs:complexType>';
        xmlToRet += '</xs:element>';
        xmlToRet += '</xs:choice>';
        xmlToRet += '</xs:complexType>';
        xmlToRet += '</xs:element>';
        xmlToRet += '</xs:schema>';

        System.debug('XMLSchema= '+xmlToRet);
        return xmlToRet;

    }

    public static string returnXMLDiffGramTag(string IDOName, map<string, string> mapOfIDOFieldsAndTypes, Map<String,String> mapOfMapping, Map<string,SObject> mapOfSObject){

        string xmlToReturn = '';
        
        xmlToReturn += '<diffgr:diffgram xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">';
        xmlToReturn += '<'+IDOName+' xmlns="">';
        Integer i = 0;
        for(string sfID :mapOfSObject.keySet()){
            
            sObject rec = mapOfSObject.get(sfID);
            xmlToReturn += '<IDO diffgr:id="IDO'+i+'" msdata:rowOrder="'+i+'" diffgr:hasChanges="inserted">';
            i++;
            for(string InfoProp: mapOfIDOFieldsAndTypes.keySet()){
                string SffieldName = mapOfMapping.containsKey(InfoProp) ? mapOfMapping.get(InfoProp) : 'Name';
                /*if(InfoProp == 'CustSeq'){
                    xmlToReturn += '<'+InfoProp+'>'+'1'+'</'+InfoProp+'>';
                }
                else {
                    xmlToReturn += '<'+InfoProp+'>'+ rec.get(SffieldName)+'</'+InfoProp+'>';
                }*/
                xmlToReturn += '<'+InfoProp+'>'+ rec.get(SffieldName)+'</'+InfoProp+'>';
            }
            xmlToReturn += '</IDO>';
            
        }
        xmlToReturn += '</'+IDOName+'>';
        xmlToReturn += '</diffgr:diffgram>';
        
        System.debug('XMLData= '+xmlToReturn);
        return xmlToReturn;

    }

    public static map<string, string> returnMapOfFieldsAndTypes(string objName, list<string> listOfFields){
        map<string, string> mapToReturn = new map<string, string>();
        String objectName = objName;
        
        for(string fName :listOfFields){
            String fieldName = fName;
            SObjectType r = ((SObject)(Type.forName('Schema.'+objectName).newInstance())).getSObjectType();
            DescribeSObjectResult d = r.getDescribe();
            System.debug(d.fields.getMap().get(fieldName).getDescribe().getType());
            mapToReturn.put(fieldName,string.valueOf(d.fields.getMap().get(fieldName).getDescribe().getType()));
        }
        return mapToReturn;
    }
}