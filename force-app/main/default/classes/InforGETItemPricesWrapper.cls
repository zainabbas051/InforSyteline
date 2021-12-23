public with sharing class InforGETItemPricesWrapper {
    public InforGETItemPricesWrapper() {

    }

    public class Choice {
		public Element element {get;set;} 

	}
	
	public Envelope Envelope {get;set;} 

	
	public class Diffgram {
		public SLItemPrices SLItemPrices {get;set;} 

	}
	
	public class Element {
		public ComplexType complexType {get;set;} 

	}
	
	public class Schema {
		public Element_Z element {get;set;} 

	}
	
	public class SLItemPrices {
		public List<IDO> IDO {get;set;} 

	}
	
	public class Sequence {
		public List<String> element {get;set;} 

	}
	
	public class Envelope {
		public Body Body {get;set;} 

	}
	
	public class ComplexType_Z {
		public Choice choice {get;set;} 

	}
	
	public class LoadDataSetResponse {
		public LoadDataSetResult LoadDataSetResult {get;set;} 

	}
	
	public class IDO {
		public String BaseCode_1 {get; set;}
        public String BaseCode_2 {get; set;}
        public String BaseCode_3 {get; set;}
        public String BaseCode_4 {get; set;}
        public String BaseCode_5 {get; set;}
        public Decimal BrkPrice_1 {get; set;}
        public Decimal BrkPrice_2 {get; set;}
        public Decimal BrkPrice_3 {get; set;}
        public Decimal BrkPrice_4 {get; set;}
        public Decimal BrkPrice_5 {get; set;}
        public Decimal BrkQty_1 {get; set;}
        public Decimal BrkQty_2 {get; set;}
        public Decimal BrkQty_3 {get; set;}
        public Decimal BrkQty_4 {get; set;}
        public Decimal BrkQty_5 {get; set;}
        public String CurrCode {get; set;}
        public String CurrCstPrcFormat {get; set;}
        public Decimal DerNewPrice {get; set;}
        public Decimal DerOldPrice {get; set;}
        public Decimal DerOldUnitPrice1 {get; set;}
        public String DerPriceType {get; set;}
        public Decimal DerQtyOnHand {get; set;}
        public Decimal DerUnitPrice1 {get; set;}
        public Decimal DerUnitPrice2 {get; set;}
        public Decimal DerUnitPrice3 {get; set;}
        public Decimal DerUnitPrice4 {get; set;}
        public Decimal DerUnitPrice5 {get; set;}
        public String DolPercent_1 {get; set;}
        public String DolPercent_2 {get; set;}
        public String DolPercent_3 {get; set;}
        public String DolPercent_4 {get; set;}
        public String DolPercent_5 {get; set;}
        public Datetime EffectDate {get; set;}
        public String InWorkflow {get; set;}
        public String ItemUniqueNum {get; set;}
        public Decimal ItmCurUCost {get; set;}
        public String ItmDescription {get; set;}
        public Long ItmJob {get; set;}
        public String ItmProductCode {get; set;}
        public Integer ItmSuffix {get; set;}
        public String ItmUM {get; set;}
        public Decimal ItmUnitCost {get; set;}
        public Integer NoteExistsFlag {get; set;}
        public String Pricecode {get; set;}
        public String PriDescription {get; set;}
        public Datetime RecordDate {get; set;}
        public Integer Reprice {get; set;}
        public String RowPointer {get; set;}
        public Decimal UnitPrice1 {get; set;}
        public Decimal UnitPrice2 {get; set;}
        public Decimal UnitPrice3 {get; set;}
        public Decimal UnitPrice4 {get; set;}
        public Decimal UnitPrice5 {get; set;}
        public Decimal UnitPrice6 {get; set;}

	}
	
	public class ComplexType {
		public Sequence sequence {get;set;} 

	}
	
	public class Body {
		public LoadDataSetResponse LoadDataSetResponse {get;set;} 

	}
	
	public class Element_Z {
		public ComplexType_Z complexType {get;set;} 

	}
	
	public class LoadDataSetResult {
		public Diffgram diffgram {get;set;} 
		public Schema schema {get;set;} 

	}
}
