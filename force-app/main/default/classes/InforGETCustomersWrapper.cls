//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class InforGETCustomersWrapper {

	public class Choice {
		public Element element {get;set;} 

	}
	
	public Envelope Envelope {get;set;} 

	
	public class Diffgram {
		public SLCustomers SLCustomers {get;set;} 

	}
	
	public class Element {
		public ComplexType complexType {get;set;} 

	}
	
	public class Schema {
		public Element_Z element {get;set;} 

	}
	
	public class SLCustomers {
		public List<IDO> IDO {get;set;}
		public IDO IDOSingle {get; set;}
		
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
		public String ActiveForDataIntegration {get;set;}	
		public String Addr_1 {get;set;}	
		public String Addr_2 {get;set;}	
		public String Addr_3 {get;set;}	
		public String Addr_4 {get;set;}	
		public DateTime AdrRecordDate {get;set;}	
		public String AdrRowPointer {get;set;}	
		public Decimal AmtOverInvAmt {get;set;}	
		public String ApsPullUp {get;set;}	
		public Decimal AvgBalOs {get;set;}	
		public Integer AvgDaysOs {get;set;}	
		public String BalMethod {get;set;}	
		public String BankCode {get;set;}	
		public String BillToCountry {get;set;}	
		public String BillToEmail {get;set;}	
		public String BranchId {get;set;}	
		public DateTime CalcDate {get;set;}	
		public String CcContact_2 {get;set;}	
		public String CcExportType {get;set;}	
		public String CcPhone_2 {get;set;}	
		public String Charfld1 {get;set;}	
		public String Charfld2 {get;set;}	
		public String Charfld3 {get;set;}	
		public String City {get;set;}	
		public Decimal CompanyRevenue {get;set;}	
		public String Consolidate {get;set;}	
		public Decimal ConstructiveSalePricePct {get;set;}	
		public String Contact_1 {get;set;}	
		public String Contact_2 {get;set;}	
		public String Contact_3 {get;set;}	
		public String CorpAddress {get;set;}	
		public String CorpadrAddr_1 {get;set;}	
		public String CorpadrAddr_2 {get;set;}	
		public String CorpadrAddr_3 {get;set;}	
		public String CorpadrAddr_4 {get;set;}	
		public String CorpadrCity {get;set;}	
		public String CorpadrCountry {get;set;}	
		public String CorpadrCounty {get;set;}	
		public String CorpadrCreditHold {get;set;}	
		public String CorpadrCurrCode {get;set;}	
		public String CorpadrFaxNum {get;set;}	
		public String CorpadrName {get;set;}	
		public String CorpadrState {get;set;}	
		public String CorpadrZip {get;set;}	
		public String CorpCred {get;set;}	
		public String CorpCust {get;set;}	
		public String CorpDisplayAddress {get;set;}	
		public String CouExpDocReqd {get;set;}	
		public String Country {get;set;}	
		public String County {get;set;}	
		public DateTime CreateDate {get;set;}	
		public String CreditHold {get;set;}	
		public DateTime CreditHoldDate {get;set;}	
		public String CreditHoldDescription {get;set;}	
		public String CreditHoldReason {get;set;}	
		public String CreditHoldUser {get;set;}	
		public Decimal CreditLimit {get;set;}	
		public String CrmString {get;set;}	
		public String CurrAmtFormat {get;set;}	
		public String CurrAmtTotFormat {get;set;}	
		public String CurrCode {get;set;}	
		public String CurrCstPrcFormat {get;set;}	
		public String CustBank {get;set;}	
		public String CustNum {get;set;}	
		public String CustNum_1 {get;set;}	
		public String CustomerEmailAddr {get;set;}	
		public Integer CustSeq {get;set;}	
		public Integer CustSeq_1 {get;set;}	
		public String CustType {get;set;}	
		public DateTime Datefld {get;set;}	
		public Integer DaysOverInvDueDate {get;set;}	
		public Decimal Decifld1 {get;set;}	
		public Decimal Decifld2 {get;set;}	
		public Decimal Decifld3 {get;set;}	
		public Integer DefaultShipTo {get;set;}	
		public String Delterm {get;set;}	
		public String DeltermDescription {get;set;}	
		public Decimal DerArtranTotalYTD {get;set;}	
		public String DerBankTransitNumMask {get;set;}	
		public String DerBillToAddress {get;set;}	
		public String DerConsignmentWhse {get;set;}	
		public String DerContact {get;set;}	
		public Decimal DerContractsUpForRenewal {get;set;}	
		public String DerCreditHold {get;set;}	
		public String DerCreditHoldString {get;set;}	
		public String DerCustNum {get;set;}	
		public Integer DerDefaultShipTo {get;set;}	
		public Decimal DerDiscLstYr {get;set;}	
		public Decimal DerDiscYtd {get;set;}	
		public String DerEmplName {get;set;}	
		public String DerGlobal {get;set;}	
		public Decimal DerIncidentsOpenedThisPeriod {get;set;}	
		public Decimal DerLastInteractionID {get;set;}	
		public Decimal DerLateCustomerOrders {get;set;}	
		public Decimal DerLateIncidents {get;set;}	
		public Decimal DerLateSROs {get;set;}	
		public String DerNameCustNum {get;set;}	
		public Decimal DerOpenIncidents {get;set;}	
		public Decimal DerOrderBal {get;set;}	
		public Decimal DerOutstandingAR {get;set;}	
		public String DerOverCreditLimit {get;set;}	
		public Decimal DerOverdueContracts {get;set;}	
		public String DerPhone {get;set;}	
		public Decimal DerPostedBal {get;set;}	
		public Decimal DerSalesLstYr {get;set;}	
		public String DerSalesmanEmail {get;set;}	
		public String DerSalesmanName {get;set;}	
		public String DerSalesmanPhone {get;set;}	
		public Decimal DerSalesPtd {get;set;}	
		public Decimal DerSalesYtd {get;set;}	
		public String DerShipToAddress {get;set;}	
		public Decimal DiscLstYr {get;set;}	
		public Decimal DiscYtd {get;set;}	
		public String DoInvoice {get;set;}	
		public String DraftPrintFlag {get;set;}	
		public String EcCode {get;set;}	
		public String EdiCust {get;set;}	
		public String Einvoice {get;set;}	
		public String EndUserType {get;set;}	
		public String EndUserTypeDesc {get;set;}	
		public String EtpArAcct {get;set;}	
		public String EtpArAcctUnit1 {get;set;}	
		public String EtpArAcctUnit2 {get;set;}	
		public String EtpArAcctUnit3 {get;set;}	
		public String EtpArAcctUnit4 {get;set;}	
		public String ExportType {get;set;}	
		public String ExternalEmailAddr {get;set;}	
		public String FaxNum {get;set;}	
		public String FinChg {get;set;}	
		public Integer HistDaysOs {get;set;}	
		public String IncludeOrdersInTaxRpt {get;set;}	
		public String IncludeTaxInPrice {get;set;}	
		public String InternalEmailAddr {get;set;}	
		public String InternetUrl {get;set;}	
		public String InvCategory {get;set;}	
		public String InvCategoryDescription {get;set;}
		public String InvFreq {get;set;}
		public String InWorkflow {get;set;}
		public String LangCode {get;set;}
		public Integer LargDaysOs {get;set;}
		public Decimal LargeBalOs {get;set;}
		public Decimal LastBalOs {get;set;}
		public Integer LastDaysOs {get;set;}
		public DateTime LastFinChg {get;set;}
		public DateTime LastInv {get;set;}
		public DateTime LastPaid {get;set;}
		public String LcrReqd {get;set;}
		public String Logifld {get;set;}
		public String Name {get;set;}
		public String NoteExistsFlag {get;set;}
		public Integer NumberOfEmployees {get;set;}
		public Integer NumInvoices {get;set;}
		public Integer NumPeriods {get;set;}
		public String OnePackInv {get;set;}
		public String PayDay {get;set;}
		public DateTime PayDayEndTime_1 {get;set;}
		public DateTime PayDayEndTime_2 {get;set;}
		public DateTime PayDayStartTime_1 {get;set;}
		public DateTime PayDayStartTime_2 {get;set;}
		public String PayType {get;set;}
		public String Phone_1 {get;set;}
		public String Phone_2 {get;set;}
		public String Phone_3 {get;set;}
		public String PictureExistsFlag {get;set;}
		public String Pricecode {get;set;}
		public String PricecodeDescription {get;set;}
		public String PrintPackInv {get;set;}
		public String ProcessInd {get;set;}
		public String RcvInternalEmail {get;set;}
		public DateTime RecordDate {get;set;}
		public String RevisionDay {get;set;}
		public DateTime RevisionDayEndTime_1 {get;set;}
		public DateTime RevisionDayEndTime_2 {get;set;}
		public DateTime RevisionDayStartTime_1 {get;set;}
		public DateTime RevisionDayStartTime_2 {get;set;}
		public String RowPointer {get;set;}
		public Decimal SalesLstYr {get;set;}
		public Decimal SalesPtd {get;set;}
		public Decimal SalesYtd {get;set;}
		public String SendCustomerEmail {get;set;}
		public String ShipCode {get;set;}
		public String ShipCodeDescription {get;set;}
		public String ShipEarly {get;set;}
		public String ShipPartial {get;set;}
		public String ShipSite {get;set;}
		public String ShipToEmail {get;set;}
		public String ShowInDropDownList {get;set;}
		public String ShowInShipToDropDownList {get;set;}
		public String SICCode {get;set;}
		public String Slsman {get;set;}
		public String State {get;set;}
		public String StateCycle {get;set;}
		public String Summarize {get;set;}
		public String TaxCode1 {get;set;}
		public String TaxCode1Description {get;set;}
		public String TaxCode1Type {get;set;}
		public String TaxCode2 {get;set;}
		public String TaxCode2Description {get;set;}
		public String TaxRegNum1 {get;set;}
		public String TaxRegNum2 {get;set;}
		public String TelexNum {get;set;}
		public String TermDescription {get;set;}
		public String TermsCode {get;set;}
		public String TerrDescription {get;set;}
		public String TerritoryCode {get;set;}
		public String TransNat {get;set;}
		public String TransNat2 {get;set;}
		public String TransNat2Description {get;set;}
		public String TransNatDescription {get;set;}
		public String UBRowPointer {get;set;}
		public String UbSelectedCustNum {get;set;}
		public Integer UbShipTo {get;set;}
		public String UseExchRate {get;set;}
		public String UseRevisionPayDays {get;set;}
		public String Whse {get;set;}
		public String Zip {get;set;}
		public String EmplName {get;set;}
		public String SalesTeamName {get;set;}
		public String VendName {get;set;}
		public String VendVendNum {get;set;}
		public String BankName {get;set;}
		public String VendPhone {get;set;}
		public String CatalogDescription {get;set;}
		public String Outside {get;set;}
		public String RefNum {get;set;}
		public String ParSite {get;set;}
		public String VendExternalEmailAddr {get;set;}
		public String BankTransitNumber {get;set;}
		public String CarrierAccount {get;set;}
		public Decimal CarrierUpchargePct {get;set;}
		public String CarrierResidentialIndicator {get;set;}
		public String CarrierBillToTransportation {get;set;}
		public Decimal OrderCreditLimit {get;set;}
		public String BusinessIdentifierCode {get;set;}
		public String SalesTeamID {get;set;}
		public Integer DaysShippedBeforeDueDateTolerance {get;set;}
		public Integer DaysShippedAfterDueDateTolerance {get;set;}
		public Decimal ShippedOverOrderedQtyTolerance {get;set;}
		public Decimal ShippedUnderOrderedQtyTolerance {get;set;}
		public String ResellerSlsman {get;set;}
		public String ShipHold {get;set;}
		public String ShipMethodGroup {get;set;}
		public String JP_ConsumptionTaxRoundMethod {get;set;}
		public String JP_ConsumptionTaxHeaderLineMethod {get;set;}
		public String CusShipmentApprovalRequired {get;set;}
		public String VrtxGeoCode {get;set;}
		public String JPInvBatchCutoffDay {get;set;}
		public DateTime TaxRegNum1ExpDate {get;set;}
		public String SepaMandateRef {get;set;}
		public DateTime SepaMandateCreationDate {get;set;}
		public DateTime SepaMandateExpirationDate {get;set;}
		public DateTime SepaMandateLastUsedDate {get;set;}
		public String SepaCoreDirectDebit {get;set;}
		public String SepaOneOffMandate {get;set;}
		public String AUContractPriceMethod {get;set;}
		public String BankAcctNo {get;set;}
		public String AUPriceBy {get;set;}
		public String InternationalBankAccount {get;set;}
		public String AccountName {get;set;}
		public String CatalogId {get;set;}
		public String BankAuthorityPartyId {get;set;}
		public String Emplsname {get;set;}
		public String SlsmanEmailAddr {get;set;}
		public String BusinessPhone {get;set;}
 

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