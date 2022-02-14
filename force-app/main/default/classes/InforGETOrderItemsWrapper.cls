public with sharing class InforGETOrderItemsWrapper {
    public InforGETOrderItemsWrapper() {

    }

    public class Choice {
		public Element element {get;set;} 

	}
	
	public Envelope Envelope {get;set;} 

	
	public class Diffgram {
		public SLCoItems SLCoItems {get;set;} 

	}
	
	public class Element {
		public ComplexType complexType {get;set;} 

	}
	
	public class Schema {
		public Element_Z element {get;set;} 

	}
	
	public class SLCoItems {
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
		public String Adr01CreditHold {get; set;}
        public String Adr0CorpCred {get; set;}
        public String Adr0CorpCust {get; set;}
        public String Adr0CreditHold {get; set;}
        public String Adr0Name {get; set;}
        public String AdrAddr_1 {get; set;}
        public String AdrAddr_2 {get; set;}
        public String AdrAddr_3 {get; set;}
        public String AdrAddr_4 {get; set;}
        public String AdrCity {get; set;}
        public String AdrCountry {get; set;}
        public String AdrCreditHold {get; set;}
        public String AdrCurrCode {get; set;}
        public String AdrCurrdescription {get; set;}
        public String AdrFaxNum {get; set;}
        public String AdrName {get; set;}
        public String AdrState {get; set;}
        public String AdrZip {get; set;}
        public String AUInvItems {get; set;}
        public Integer BatchId {get; set;}
        public String Bol {get; set;}
        public Decimal BrkQty_1 {get; set;}
        public Decimal BrkQty_2 {get; set;}
        public Decimal BrkQty_3 {get; set;}
        public Decimal BrkQty_4 {get; set;}
        public Decimal BrkQty_5 {get; set;}
        public Decimal CblBlanketQtyConv {get; set;}
        public Integer CblCoLine {get; set;}
        public Decimal CblContPriceConv {get; set;}
        public Datetime CblEffDatetime {get; set;}
        public Datetime CblExpDatetime {get; set;}
        public String CblItem {get; set;}
        public String CblShipSite {get; set;}
        public String CblUM {get; set;}
        public String CfgMainConfigGid {get; set;}
        public String CfgMainConfigModel {get; set;}
        public String CfgMainConfigStatus {get; set;}
        public Decimal CgsTotal {get; set;}
        public Decimal CgsTotalFovhd {get; set;}
        public Decimal CgsTotalLbr {get; set;}
        public Decimal CgsTotalMatl {get; set;}
        public Decimal CgsTotalOut {get; set;}
        public Decimal CgsTotalVovhd {get; set;}
        public Datetime CoCloseDatetime {get; set;}
        public String CoCoCustNum {get; set;}
        public Integer CoCoCustSeq {get; set;}
        public String CoConsoliDatetime {get; set;}
        public Decimal CoCost {get; set;}
        public String CoCreditHold {get; set;}
        public String CoCustNum {get; set;}
        public String CoCustPo {get; set;}
        public String CoEdiOrder {get; set;}
        public Decimal CoExchRate {get; set;}
        public String CoExportType {get; set;}
        public String CoiiCoNum {get; set;}
        public String CoInvFreq {get; set;}
        public Integer CoLine {get; set;}
        public String CommCode {get; set;}
        public String ComSupplQtyReq {get; set;}
        public String ConfigID {get; set;}
        public Integer ConsNum {get; set;}
        public String ConsoliDatetime {get; set;}
        public String CoNum {get; set;}
        public Datetime CoOrderDatetime {get; set;}
        public String CoOrigSite {get; set;}
        public Decimal CoPrice {get; set;}
        public Integer CoRelease {get; set;}
        public Integer CosDoLine {get; set;}
        public String CosDoNum {get; set;}
        public Integer CosDoSeq {get; set;}
        public String CoShipCode {get; set;}
        public Decimal CosQtyInvoiced {get; set;}
        public Decimal CosQtyReturned {get; set;}
        public Decimal CosQtyShipped {get; set;}
        public Decimal CosShipmentId {get; set;}
        public Decimal Cost {get; set;}
        public String CoStat {get; set;}
        public Decimal CostConv {get; set;}
        public String CoTaxCode1 {get; set;}
        public String CoTaxCode2 {get; set;}
        public String CoTermsCode {get; set;}
        public String CoType {get; set;}
        public String CoUseExchRate {get; set;}
        public String CoWhse {get; set;}
        public String CurrencyAmtFormat {get; set;}
        public String CurrencyCstPrcFormat {get; set;}
        public String Cus0CustType {get; set;}
        public String CusContact_2 {get; set;}
        public String CusCustType {get; set;}
        public String CusDoInvoice {get; set;}
        public String CusPhone_2 {get; set;}
        public String CusTaxCode1Type {get; set;}
        public String CustItem {get; set;}
        public String CustNum {get; set;}
        public String CustPo {get; set;}
        public Integer CustSeq {get; set;}
        public String CusUseExchRate {get; set;}
        public String Delterm {get; set;}
        public String DerAllowOverCreditLimit {get; set;}
        public String DerApsOrderID {get; set;}
        public String DerAUContractPriceMethod {get; set;}
        public Decimal DerAvailable {get; set;}
        public Decimal DerAvailToReserve {get; set;}
        public String DerCanChangeItem {get; set;}
        public String DerCanChgShipSite {get; set;}
        public String DerCanConfigureItem {get; set;}
        public String DerCfgJobIsConfigurable {get; set;}
        public String DerCfgOnHold {get; set;}
        public String DerCoitemShipped {get; set;}
        public String DerControlledByExternalWhse {get; set;}
        public String DerCoverSheetCompany {get; set;}
        public String DerCoverSheetContact {get; set;}
        public String DerCurrCode {get; set;}
        public String DerCurrencyPlaces {get; set;}
        public Datetime DerCurrentDatetime {get; set;}
        public String DerCustNum {get; set;}
        public String DerCustPo {get; set;}
        public Integer DerCustSeq {get; set;}
        public String DerDescription {get; set;}
        public String DerDIFOT {get; set;}
        public String DerDomCurrCode {get; set;}
        public String DerDropShipAddress {get; set;}
        public String DerDropShipCustAddr {get; set;}
        public String DerDropShipFlag {get; set;}
        public String DerEndingItem {get; set;}
        public String DerEndingOrder {get; set;}
        public Decimal DerExtInvoicedCost {get; set;}
        public Decimal DerExtInvoicedPrice {get; set;}
        public Decimal DerExtPrice {get; set;}
        public Decimal DerExtPriceInDomesticCurrency {get; set;}
        public Decimal DerFovhdCostConv {get; set;}
        public Decimal DerFovhdExtended {get; set;}
        public String DerInfobar {get; set;}
        public String DerInFull {get; set;}
        public String DerItem {get; set;}
        public String DerItemContentExist {get; set;}
        public String DerItemFeatTempl {get; set;}
        public String DerItemNotAvailable {get; set;}
        public String DerItExist {get; set;}
        public String DerLate {get; set;}
        public Decimal DerLbrExtended {get; set;}
        public Decimal DerLineInvoicedPrice {get; set;}
        public String DerLoc {get; set;}
        public String DerLot {get; set;}
        public String DerLotPrefix {get; set;}
        public Decimal DerMargin {get; set;}
        public Decimal DerMarginPercent {get; set;}
        public Decimal DerMarkup {get; set;}
        public Decimal DerMatlExtended {get; set;}
        public Decimal DerMaxQtyToPackConv {get; set;}
        public String DerMessage {get; set;}
        public Decimal DerNetPrice {get; set;}
        public String DerNonInventoryItemFlag {get; set;}
        public Integer DerOldCoLine {get; set;}
        public String DerOldCoNum {get; set;}
        public String DerOldStat {get; set;}
        public String DerOnTime {get; set;}
        public String DerOrderID {get; set;}
        public Decimal DerOrigQtyOrderedConv {get; set;}
        public Decimal DerOutExtended {get; set;}
        public Decimal DerPercentShippedOnTime {get; set;}
        public String DerPostCfg {get; set;}
        public String DerPostCfgMsg {get; set;}
        public String DerPostCfgQueueType {get; set;}
        public String DerPostCfgRequestID {get; set;}
        public String DerPostCfgStat {get; set;}
        public String DerPrintingEstimateExists {get; set;}
        public String DerPrintingQuoteExists {get; set;}
        public Decimal DerPrintQuotePrice {get; set;}
        public String DerProdMix {get; set;}
        public Decimal DerProgBillTotalBilled {get; set;}
        public Decimal DerProgBillTotalInvoiced {get; set;}
        public Decimal DerQtyInvoicedConv {get; set;}
        public Decimal DerQtyPackedConv {get; set;}
        public Decimal DerQtyPicked {get; set;}
        public Decimal DerQtyPickedConv {get; set;}
        public Decimal DerQtyReady {get; set;}
        public Decimal DerQtyReadyByRefType {get; set;}
        public Decimal DerQtyReadyConv {get; set;}
        public Decimal DerQtyRsvdConv {get; set;}
        public Decimal DerQtyShippedConv {get; set;}
        public Decimal DerQtyShippedOver {get; set;}
        public Decimal DerQtyShippedUnder {get; set;}
        public Decimal DerQtyToInvoice {get; set;}
        public Decimal DerQtyToPack {get; set;}
        public Decimal DerQtyToPackConv {get; set;}
        public Decimal DerQtyToPick {get; set;}
        public Decimal DerQtyToShip {get; set;}
        public String DerReady {get; set;}
        public String DerRefType {get; set;}
        public Decimal DerReleaseInvoicedPrice {get; set;}
        public String DerSelected {get; set;}
        public String DerSerialPrefix {get; set;}
        public String DerShiIteActive {get; set;}
        public String DerShipFromAddress {get; set;}
        public Integer DerShippedAfterDueDatetime {get; set;}
        public Integer DerShippedBeforeDueDatetime {get; set;}
        public String DerShipToAddress {get; set;}
        public Decimal DerSiteQtyAvailable {get; set;}
        public String DerStartingItem {get; set;}
        public String DerStartingOrder {get; set;}
        public Decimal DerTotalQtyOrderedConv {get; set;}
        public Decimal DerTotCost {get; set;}
        public Decimal DerTotExtended {get; set;}
        public Decimal DerTotQtyToInvoice {get; set;}
        public Decimal DerUomConvFactor {get; set;}
        public String DerViewCustPortalDetail {get; set;}
        public Decimal DerVovhdExtended {get; set;}
        public String DerXRefJobExists {get; set;}
        public Decimal DerYield {get; set;}
        public String Description {get; set;}
        public Decimal Disc {get; set;}
        public String DltDescription {get; set;}
        public Integer DoLine {get; set;}
        public Datetime DueDatetime {get; set;}
        public String EcCode {get; set;}
        public Decimal ExportValue {get; set;}
        public Decimal ExtendedCost {get; set;}
        public Decimal ExtendedPrice {get; set;}
        public String FeatStr {get; set;}
        public Decimal FovhdCost {get; set;}
        public Decimal FovhdCostConv {get; set;}
        public String FSSROs {get; set;}
        public String InvFreq {get; set;}
        public String InWorkflow {get; set;}
        public String ItAutoJob {get; set;}
        public String ItAutoPost {get; set;}
        public String ItCfgModel {get; set;}
        public String ItCoPostConfig {get; set;}
        public String ItDescription {get; set;}
        public String ItemUniqueNum {get; set;}
        public Decimal IteWhsQtyOnHand {get; set;}
        public Decimal IteWhsQtyRsvdCo {get; set;}
        public String ItKit {get; set;}
        public String ItLotTracked {get; set;}
        public String ItOrderConfigurable {get; set;}
        public String ItPlanFlag {get; set;}
        public String ItReservable {get; set;}
        public String ItSerialTracked {get; set;}
        public String ItSupplySite {get; set;}
        public String ItUM {get; set;}
        public Decimal ItUWsPrice {get; set;}
        public Decimal LbrCost {get; set;}
        public Decimal LbrCostConv {get; set;}
        public Decimal Margin {get; set;}
        public Decimal MarginPercent {get; set;}
        public Decimal MatlCost {get; set;}
        public Decimal MatlCostConv {get; set;}
        public String MODerBOMType {get; set;}
        public Decimal MODerCostPiece {get; set;}
        public Decimal MODerExtendedCost {get; set;}
        public Decimal MODerExtPrice {get; set;}
        public Decimal MODerLaborPiece {get; set;}
        public Decimal MODerMarkup {get; set;}
        public Decimal MODerMaterialPiece {get; set;}
        public Decimal MODerNetPrice {get; set;}
        public Decimal MODerPrice {get; set;}
        public String MODerPriceBasis {get; set;}
        public Decimal MODerPriceBasisAmount {get; set;}
        public Decimal MODerPriceBasisUnitofMeasure {get; set;}
        public Decimal MODerPricePiece {get; set;}
        public Decimal MODerPriceUnit {get; set;}
        public Decimal MODerQty {get; set;}
        public Decimal MODerUnitCost {get; set;}
        public String MOUbBOMType {get; set;}
        public String MOUbCoProductMix {get; set;}
        public String MOUbJob {get; set;}
        public Integer MOUbJobSuffix {get; set;}
        public Integer MOUbProductCycles {get; set;}
        public String MOUbResource {get; set;}
        public Integer MOVenderPriceBreaks {get; set;}
        public String NoteExistsFlag {get; set;}
        public String Origin {get; set;}
        public Decimal OutCost {get; set;}
        public Decimal OutCostConv {get; set;}
        public String Packed {get; set;}
        public String ParCfgConfigGid {get; set;}
        public Datetime PickDatetime {get; set;}
        public String PictureExistsFlag {get; set;}
        public Decimal PrgBillApp {get; set;}
        public Decimal PrgBillTot {get; set;}
        public Decimal Price {get; set;}
        public String Pricecode {get; set;}
        public String PricecodeDesc {get; set;}
        public Decimal PriceConv {get; set;}
        public String PrintKitComponents {get; set;}
        public String ProcessInd {get; set;}
        public Datetime ProjectedDatetime {get; set;}
        public Datetime PromiseDatetime {get; set;}
        public Decimal QtyInvoiced {get; set;}
        public Decimal QtyOrdered {get; set;}
        public Decimal QtyOrderedConv {get; set;}
        public Decimal QtyPacked {get; set;}
        public Decimal QtyReady {get; set;}
        public Decimal QtyReturned {get; set;}
        public Decimal QtyRsvd {get; set;}
        public Decimal QtyShipped {get; set;}
        public Datetime RecordDatetime {get; set;}
        public Integer RefLineSuf {get; set;}
        public String RefNum {get; set;}
        public Integer RefRelease {get; set;}
        public String RefType {get; set;}
        public Datetime ReleaseDatetime {get; set;}
        public String Reprice {get; set;}
        public Integer RmaLine {get; set;}
        public String RmaNum {get; set;}
        public String RowPointer {get; set;}
        public String ShiIteActive {get; set;}
        public Datetime ShipDatetime {get; set;}
        public String ShipSite {get; set;}
        public String SLCoShipAlls {get; set;}
        public String SLCoships {get; set;}
        public String SLItemLocAlls {get; set;}
        public String SLJobPriceBreaks {get; set;}
        public String SLJobRoutes {get; set;}
        public String SLPlanningDetails {get; set;}
        public String SLPoItems {get; set;}
        public String SLPreqitems {get; set;}
        public String SLProgbills {get; set;}
        public String SLProjTasks {get; set;}
        public String SLRsvdInvs {get; set;}
        public String SLSerials {get; set;}
        public String SLShipmentSeqs {get; set;}
        public String SLTrnitems {get; set;}
        public String Stat {get; set;}
        public String Summarize {get; set;}
        public Decimal SupplQtyConvFactor {get; set;}
        public String SyncReqd {get; set;}
        public String TaxCode1 {get; set;}
        public String TaxCode2 {get; set;}
        public String Tc1Description {get; set;}
        public String Tc2Description {get; set;}
        public String TermsDescription {get; set;}
        public String TransNat {get; set;}
        public String TransNat2 {get; set;}
        public String TransNat2Description {get; set;}
        public String Transport {get; set;}
        public String TrnDescription {get; set;}
        public Decimal UbAmount {get; set;}
        public Decimal UbAmountWeb {get; set;}
        public Decimal UbBrkPrice_1 {get; set;}
        public Decimal UbBrkPrice_2 {get; set;}
        public Decimal UbBrkPrice_3 {get; set;}
        public Decimal UbBrkPrice_4 {get; set;}
        public Decimal UbBrkPrice_5 {get; set;}
        public Decimal UbCommissionAmount {get; set;}
        public String UbContractDescription {get; set;}
        public String UbContractID {get; set;}
        public Decimal UbCustPriceConv {get; set;}
        public String UbDispMsg {get; set;}
        public String UbDispXRefMsg {get; set;}
        public Integer UbGenerateQty {get; set;}
        public Decimal UbIncrPrice {get; set;}
        public String UbIndicator {get; set;}
        public String UbISOUM {get; set;}
        public String UbItem {get; set;}
        public String UbItemCustAdd {get; set;}
        public String UbItemCustUpDatetime {get; set;}
        public Decimal UbListPriceConv {get; set;}
        public Decimal UbNetAdjust {get; set;}
        public Decimal UbNewDisc {get; set;}
        public Decimal UbNewNet {get; set;}
        public Decimal UbNewPrice {get; set;}
        public Integer UbNumberOfCOLinesShipped {get; set;}
        public Integer UbNumberOfCOLinesToShip {get; set;}
        public Integer UbNumberOfPOLinesRcvd {get; set;}
        public Integer UbNumberOfPOLinesToRcv {get; set;}
        public Decimal UbOldCustPriceConv {get; set;}
        public Decimal UbOldNet {get; set;}
        public Decimal UbOrigCustPriceConv {get; set;}
        public Decimal UbOrigUnitPrice {get; set;}
        public Integer UbPackNum {get; set;}
        public Blob UbPicture {get; set;}
        public String UbPlanOnSave {get; set;}
        public String UbPortalPricingOptionsExist {get; set;}
        public String UbPrecision {get; set;}
        public Decimal UbProgBillAmount {get; set;}
        public Decimal UbQtyRsvd {get; set;}
        public Decimal UbQtyToAdjust {get; set;}
        public Integer UbRangeQty {get; set;}
        public Decimal UbRePrice {get; set;}
        public String UbSelect {get; set;}
        public Integer UbSelectedQty {get; set;}
        public String UbSetItemCust {get; set;}
        public Integer UbSourceCoLine {get; set;}
        public String UbSourceConfigID {get; set;}
        public String UbSourceCoNum {get; set;}
        public Integer UbTargetQty {get; set;}
        public String UM {get; set;}
        public Decimal UnitWeight {get; set;}
        public Decimal VovhdCost {get; set;}
        public Decimal VovhdCostConv {get; set;}
        public String WBItProductCode {get; set;}
        public String Whse {get; set;}
        public String WksBasis {get; set;}
        public Decimal WksValue {get; set;}
        public String CurrencyCurrCode {get; set;}
        public String MfrName {get; set;}
        public String ProCompany {get; set;}
        public String ProProspectId {get; set;}
        public String ShipSiteName {get; set;}
        public String CouEcCode {get; set;}
        public String ItmLanDescription {get; set;}
        public String MOJob {get; set;}
        public Decimal MOProdcodeMarkup {get; set;}
        public String Name {get; set;}
        public String NonInvAcctDesc {get; set;}
        public String ManufacturerItemDescription {get; set;}
        public Integer MOJobSuffix {get; set;}
        public String CoCustNnum {get; set;}
        public Integer CoCustSeq {get; set;}
        public String CurrencyPlaces {get; set;}
        public String PPJobRowPointer {get; set;}
        public String NonInvAccessUnit1 {get; set;}
        public String CblStat {get; set;}
        public String NonInvAccessUnit2 {get; set;}
        public String ItPMTCode {get; set;}
        public String NonInvAccessUnit3 {get; set;}
        public String NonInvAccessUnit4 {get; set;}
        public Integer LanLocaleID {get; set;}
        public String ParSite {get; set;}
        public String Site {get; set;}
        public Decimal AURePrice {get; set;}
        public String ProCurrCode {get; set;}
        public String ItStocked {get; set;}
        public String NonInvIsControl {get; set;}
        public String CoSlsman {get; set;}
        public String AUReasonText {get; set;}
        public String WhsControlledByExternalWms {get; set;}
        public String CopUseAltPriceCalc {get; set;}
        public String TaxRegNum1 {get; set;}
        public Decimal CoDisc {get; set;}
        public String MOProductMix {get; set;}
        public String ProdMix {get; set;}
        public String CoRowPointer {get; set;}
        public Integer MOCoProductMix {get; set;}
        public String CoIncludeTaxInPrice {get; set;}
        public String MOBomAlternateID {get; set;}
        public String MOBomAlternateDescription {get; set;}
        public String ProspectId {get; set;}
        public String MOCoJob {get; set;}
        public String CoConsignment {get; set;}
        public Integer MOProductCycles {get; set;}
        public String NonInvAcct {get; set;}
        public Decimal MOQtyCycle {get; set;}
        public String NonInvAcctUnit1 {get; set;}
        public String NonInvAcctUnit2 {get; set;}
        public String NonInvAcctUnit3 {get; set;}
        public String NonInvAcctUnit4 {get; set;}
        public Integer DaysShippedAfterDueDatetimeTolerance {get; set;}
        public Integer DaysShippedBeforeDueDatetimeTolerance {get; set;}
        public Decimal ShippedOverOrderedQtyTolerance {get; set;}
        public String CoPortalOrder {get; set;}
        public String DemandingSite {get; set;}
        public Decimal ShippedUnderOrderedQtyTolerance {get; set;}
        public String ManufacturerId {get; set;}
        public String InvoiceHold {get; set;}
        public String ManufacturerItem {get; set;}
        public String CoShipMethod {get; set;}
        public Integer Priority {get; set;}
        public String LastExternalShipmentDocId {get; set;}
        public Decimal QtyPicked {get; set;}
        public String ShowInDropDownList {get; set;}
        public String AllowOnPickList {get; set;}
        public String FSIncNum {get; set;}
        public String ExternalShipmentStatus {get; set;}
        public String PromotionCode {get; set;}
        public Datetime CusTaxRegNum1ExpDatetime {get; set;}
        public String AUContractPriceMethod {get; set;}
        public String AUPriceBy {get; set;}
        public String ItItemContent {get; set;}
        

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
