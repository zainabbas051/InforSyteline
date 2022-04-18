public  class InforGETIemsWrapper {
    
    public class Choice {
		public Element element {get;set;} 

	}
	
	public Envelope Envelope {get;set;} 

	
	public class Diffgram {
		public SLItems SLItems {get;set;} 

	}
	
	public class Element {
		public ComplexType complexType {get;set;} 

	}
	
	public class Schema {
		public Element_Z element {get;set;} 

	}
	
	public class SLItems {
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
		public string ItemUniqueNum {get; set;}
        public string Job {get; set;}
        public string Description {get; set;}
		public decimal DerQtyOnHand {get; set;}
		public dateTime EffectDate {get; set;}
		public string ProductCode {get; set;}
		public string Overview {get; set;}
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