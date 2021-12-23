public with sharing class InforGETOrdersWrapper {
    public InforGETOrdersWrapper() {

    }

    public class Choice {
		public Element element {get;set;} 

	}
	
	public Envelope Envelope {get;set;} 

	
	public class Diffgram {
		public SLCos SLCos {get;set;} 

	}
	
	public class Element {
		public ComplexType complexType {get;set;} 

	}
	
	public class Schema {
		public Element_Z element {get;set;} 

	}
	
	public class SLCos {
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
		Public String AckStat {get; set;}
        Public String ApplyToInvNum {get; set;}
        Public Integer ApsPullUp {get; set;}
        Public String BillToAddr_1 {get; set;}
        Public String BillToAddr_2 {get; set;}
        Public String BillToAddr_3 {get; set;}
        Public String BillToAddr_4 {get; set;}
        Public String BillToCity {get; set;}
        Public String BillToContact_3 {get; set;}
        Public String BillToCountry {get; set;}
        Public String BillToEmailAddr {get; set;}
        Public String BillToFaxNum {get; set;}
        Public String BillToName {get; set;}
        Public String BillToPhone_3 {get; set;}
        Public String BillToState {get; set;}
        Public String BillToZip {get; set;}
        Public Integer Cad01CreditHold {get; set;}
        Public String Cad01Name {get; set;}
        Public Integer Cad0CorpAddress {get; set;}
        Public Integer Cad0CorpCred {get; set;}
        Public String Cad0CorpCust {get; set;}
        Public Integer Cad0CreditHold {get; set;}
        Public Integer Cad0CurrPlaces {get; set;}
        Public String CadrCurrCode {get; set;}
        Public String CadrName {get; set;}
        Public String camCampaignId {get; set;}
        Public String camCampaignStatus {get; set;}
        Public String camCampaignType {get; set;}
        Public String CfgMainConfigGid {get; set;}
        Public String CfgMainConfigModel {get; set;}
        Public String CfgMainConfigStatus {get; set;}
        Public String Charfld1 {get; set;}
        Public String Charfld2 {get; set;}
        Public String Charfld3 {get; set;}
        Public Datetime CloseDate {get; set;}
        Public Integer CoCreditHold {get; set;}
        Public String ConfigId {get; set;}
        Public Integer Consolidate {get; set;}
        Public String Contact {get; set;}
        Public String CoNum {get; set;}
        Public String CoNumSort {get; set;}
        Public String ConvertType {get; set;}
        Public String CorpCust {get; set;}
        Public Decimal Cost {get; set;}
        Public Integer CreditHold {get; set;}
        Public Datetime CreditHoldDate {get; set;}
        Public String CreditHoldReason {get; set;}
        Public String CreditHoldReasonDesc {get; set;}
        Public String CreditHoldUser {get; set;}
        Public String Cur0AmtFormat {get; set;}
        Public String Cur0CstPrcFormat {get; set;}
        Public String CurrDescription {get; set;}
        Public String Cus01Contact_3 {get; set;}
        Public String Cus01Phone_3 {get; set;}
        Public String CusCustType {get; set;}
        Public String CusLangCode {get; set;}
        Public Integer CusLcrReqd {get; set;}
        Public String CustNum {get; set;}
        Public Blob CustomerPicture {get; set;}
        Public String CustPayType {get; set;}
        Public String CustPo {get; set;}
        Public Long CustSeq {get; set;}
        Public String CusTypTaxablePrice {get; set;}
        Public Integer CusUseExchRate {get; set;}
        Public Datetime Datefld {get; set;}
        Public Decimal Decifld1 {get; set;}
        Public Decimal Decifld2 {get; set;}
        Public Decimal Decifld3 {get; set;}
        Public String Delterm {get; set;}
        Public String DeltermDesc {get; set;}
        Public String DerASPSearch {get; set;}
        Public String DerBillToAddress {get; set;}
        Public String DerCoNum {get; set;}
        Public Integer DerCoShipmentApprovalRequired {get; set;}
        Public String DerCoverSheetCompany {get; set;}
        Public String DerCoverSheetContact {get; set;}
        Public String DerCurrCode {get; set;}
        Public String DerCustName {get; set;}
        Public String DerCustProspect {get; set;}
        Public String DerCustProspectCompany {get; set;}
        Public String DerDaysToShip {get; set;}
        Public String DerDaysToShipMsg {get; set;}
        Public String DerDestination {get; set;}
        Public Integer DerDocumentExists {get; set;}
        Public Integer DerDoLines {get; set;}
        Public Integer DerExistCoLine {get; set;}
        Public Integer DerHasCoShipped {get; set;}
        Public Integer DerHasXRef {get; set;}
        Public Integer DerInteractionExists {get; set;}
        Public String DerInteractionRefType {get; set;}
        Public Decimal DerItemsShippedOnTime {get; set;}
        Public String DerLaborType {get; set;}
        Public String DerLangCode {get; set;}
        Public Datetime DerLastLineShipDate {get; set;}
        Public Integer DerLineExists {get; set;}
        Public String DerMessage {get; set;}
        Public String DerMethod {get; set;}
        Public Integer DerNumCopies {get; set;}
        Public Integer DerNumPackages {get; set;}
        Public String DerOldStat {get; set;}
        Public Decimal DerOpenItems {get; set;}
        Public String DerOrderType {get; set;}
        Public Integer DerOutstandingOrderItems {get; set;}
        Public Integer DerPaidByCreditCard {get; set;}
        Public String DerPreviousStat {get; set;}
        Public String DerPriceBasis {get; set;}
        Public Decimal DerPriceBasisAmount {get; set;}
        Public String DerProdMix {get; set;}
        Public Integer DerProfileExists {get; set;}
        Public Long DerRESIDQTY {get; set;}
        Public Decimal DerRevaluedExchRate {get; set;}
        Public Integer DerSelect {get; set;}
        Public String DerShipDescription {get; set;}
        Public String DerShipToAddress {get; set;}
        Public String DerShipVia {get; set;}
        Public String DerSlsmanName {get; set;}
        Public String DerStatFormatted {get; set;}
        Public Decimal DerTotalProgBillAmt {get; set;}
        Public Decimal DerTurnaroundDays {get; set;}
        Public Decimal DerWeight {get; set;}
        Public Decimal Disc {get; set;}
        Public Decimal DiscAmount {get; set;}
        Public String DiscountType {get; set;}
        Public Integer EdiOrder {get; set;}
        Public String EdiType {get; set;}
        Public Datetime EffDate {get; set;}
        Public Integer Einvoice {get; set;}
        Public String EndUserType {get; set;}
        Public String EndUserTypeDesc {get; set;}
        Public String EstCoNum {get; set;}
        Public String EstNum {get; set;}
        Public Decimal ExchRate {get; set;}
        Public Datetime ExpDate {get; set;}
        Public String ExportType {get; set;}
        Public Integer FixedRate {get; set;}
        Public String FormatBillToAddress {get; set;}
        Public String FormatShipToAddress {get; set;}
        Public Decimal FovhdCostT {get; set;}
        Public Decimal Freight {get; set;}
        Public Decimal FreightT {get; set;}
        Public String FrtTaxCode1 {get; set;}
        Public String FrtTaxCode1Desc {get; set;}
        Public String FrtTaxCode2 {get; set;}
        Public String FrtTaxCode2Desc {get; set;}
        Public Integer IncludeTaxInPrice {get; set;}
        Public String InvFreq {get; set;}
        Public Integer Invoiced {get; set;}
        Public Integer InWorkflow {get; set;}
        Public Long ItemCount {get; set;}
        Public Decimal LbrCostT {get; set;}
        Public String LcrNum {get; set;}
        Public Integer Logifld {get; set;}
        Public Decimal MatlCostT {get; set;}
        Public Decimal MChargesT {get; set;}
        Public Decimal MiscCharges {get; set;}
        Public String MOCoProductMix {get; set;}
        Public Integer MODerEstJobFlag {get; set;}
        Public Integer MODerLoadByDateChange {get; set;}
        Public Long MOProductCycles {get; set;}
        Public String MOUbBOMType {get; set;}
        Public String MOUbResource {get; set;}
        Public String MscTaxCode1 {get; set;}
        Public String MscTaxCode1Desc {get; set;}
        Public String MscTaxCode2 {get; set;}
        Public String MscTaxCode2Desc {get; set;}
        Public Integer NoteExistsFlag {get; set;}
        Public Datetime OrderDate {get; set;}
        Public String OrderSource {get; set;}
        Public String OrigSite {get; set;}
        Public Decimal OutCostT {get; set;}
        Public String Phone {get; set;}
        Public Decimal PrepaidAmt {get; set;}
        Public Decimal PrepaidT {get; set;}
        Public Decimal Price {get; set;}
        Public String Pricecode {get; set;}
        Public String PricecodeDesc {get; set;}
        Public String ProcessInd {get; set;}
        Public Datetime ProjectedDate {get; set;}
        Public Integer QtyPackages {get; set;}
        Public Datetime RecordDate {get; set;}
        Public String RowPointer {get; set;}
        Public Decimal SalesTax {get; set;}
        Public Decimal SalesTax2 {get; set;}
        Public Decimal SalesTaxT {get; set;}
        Public Decimal SalesTaxT2 {get; set;}
        Public String SessionID {get; set;}
        Public String ShipCode {get; set;}
        Public String ShipCodeDesc {get; set;}
        Public Integer ShipEarly {get; set;}
        Public Integer ShipPartial {get; set;}
        Public String ShippingMethod {get; set;}
        Public String ShippingMethodDescription {get; set;}
        Public String ShipToAddr_1 {get; set;}
        Public String ShipToAddr_2 {get; set;}
        Public String ShipToAddr_3 {get; set;}
        Public String ShipToAddr_4 {get; set;}
        Public String ShipToCity {get; set;}
        Public String ShipToContact_2 {get; set;}
        Public String ShipToCountry {get; set;}
        Public String ShipToEmailAddr {get; set;}
        Public String ShipToFaxNum {get; set;}
        Public String ShipToName {get; set;}
        Public String ShipToPhone_2 {get; set;}
        Public String ShipToState {get; set;}
        Public String ShipToZip {get; set;}
        Public String SLCoShips {get; set;}
        Public String SLCoSlsComms {get; set;}
        Public String SLRsvdInvs {get; set;}
        Public String Slsman {get; set;}
        Public String SLXTaxes {get; set;}
        Public String Stat {get; set;}
        Public Integer Summarize {get; set;}
        Public Integer SyncReqd {get; set;}
        Public String TakenBy {get; set;}
        Public String TaxCode1 {get; set;}
        Public String TaxCode1Desc {get; set;}
        Public String TaxCode2 {get; set;}
        Public String TaxCode2Desc {get; set;}
        Public String TermsCode {get; set;}
        Public String TermsCodeDesc {get; set;}
        Public Long TermsCodeDiscDays {get; set;}
        Public Decimal TermsCodeDiscPct {get; set;}
        Public Long TermsCodeDueDays {get; set;}
        Public String TransNat {get; set;}
        Public String TransNat2 {get; set;}
        Public String TransNat2Description {get; set;}
        Public String TransNatDesc {get; set;}
        Public String Type {get; set;}
        Public Integer UbEstSetLineStat {get; set;}
        Public Long UbPackNum {get; set;}
        Public Datetime UbProgBillBillingDate {get; set;}
        Public String UbProgBillDescription {get; set;}
        Public String UbProgBillInvoiceFlag {get; set;}
        Public Integer UbProgBillPercentToBill {get; set;}
        Public String UbSourceConfigID {get; set;}
        Public String UbSourceCoNum {get; set;}
        Public Integer UseExchRate {get; set;}
        Public Decimal VovhdCostT {get; set;}
        Public Decimal Weight {get; set;}
        Public String Whse {get; set;}
        Public String AUContractID {get; set;}
        Public String LeadDescription {get; set;}
        Public String OppDescription {get; set;}
        Public String OrigSiteName {get; set;}
        Public String ParCompany {get; set;}
        Public String ProCompany {get; set;}
        Public String ProspectCompany {get; set;}
        Public String ShipMethodDesc {get; set;}
        Public String SiteSiteName {get; set;}
        Public String AdrName {get; set;}
        Public String Cad0Name {get; set;}
        Public String ParCity {get; set;}
        Public String ShmDescription {get; set;}
        Public String Ts1TaxMode {get; set;}
        Public String ParState {get; set;}
        Public Long ShmMinDaysToShip {get; set;}
        Public String ParZip {get; set;}
        Public Long ShmMaxDaysToShip {get; set;}
        Public String ConfigModel {get; set;}
        Public String Cus0CustType {get; set;}
        Public String ParmSite {get; set;}
        Public String ParSite {get; set;}
        Public String ParAddr1 {get; set;}
        Public String ParAddr2 {get; set;}
        Public String ProCurrCode {get; set;}
        Public Integer CurAllowOver {get; set;}
        Public String TaxRegNum1 {get; set;}
        Public Integer CurpAllowOver {get; set;}
        Public String UpdatedBy {get; set;}
        Public String ExternalConfirmationRef {get; set;}
        Public Integer IsExternal {get; set;}
        Public String OppId {get; set;}
        Public String ProspectId {get; set;}
        Public String LeadId {get; set;}
        Public Integer Consignment {get; set;}
        Public Integer DaysShippedBeforeDueDateTolerance {get; set;}
        Public Integer DaysShippedAfterDueDateTolerance {get; set;}
        Public Decimal ShippedOverOrderedQtyTolerance {get; set;}
        Public Decimal ShippedUnderOrderedQtyTolerance {get; set;}
        Public Integer Priority {get; set;}
        Public String DemandingSite {get; set;}
        Public Integer PortalOrder {get; set;}
        Public String DemandingSitePoNum {get; set;}
        Public Integer ShipHold {get; set;}
        Public Integer DefaultShipTo {get; set;}
        Public String PaymentMethod {get; set;}
        Public String ShipMethod {get; set;}
        Public Integer CoShipmentApprovalRequired {get; set;}
        Public Decimal Surcharge {get; set;}
        Public Decimal SurchargeT {get; set;}
        Public String ConfigDocId {get; set;}
        Public String CurrCode {get; set;}
        Public Integer ExternalWhseLineChanged {get; set;}
        Public Datetime CusTaxRegNum1ExpDate {get; set;}

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
