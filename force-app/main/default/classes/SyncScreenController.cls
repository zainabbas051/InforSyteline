public without sharing class SyncScreenController {
    public SyncScreenController() {

    }

    @AuraEnabled
    public static string callSyncMethods(string syncType) 
    {
        string msgToReturn = 'You will be notified once completed';
        try{
            if(syncType == 'Customers')
            {
                //Customers GET
                String filter = 'CustNum = \'HYDER1\'';
                list<string> lst = new list<string>{'CustNum','CustSeq','Name','City','Country', 'Addr_1','Addr_2','Addr_3','Addr_4','State','Zip','Phone_1'};
                list<string> lst2 = new list<string>();
                GETCustomerController.customerGETCallout('SLCustomers', lst, '', lst2, 100);
                // GETCustomerController.customerGETCallout('SLCustomers', lst, filter, lst2, 100);
            }
            else if(syncType == 'Products'){
                //Products GET
                String filter = 'Item = \'21751\'';
                list<string> lst = new list<string>{'Description' ,'Item' ,'DerQtyOnHand', 'ProductCode', 'Overview'};
                list<string> lst2 = new list<string>();
                GETItemController.itemGETCallout('SLItems', lst, filter, lst2, 0);

            } 
            else if(syncType == 'Pricing') {
                //PricebookEntries GET
                String filter = 'Item = \'21751\'';
                list<string> lst = new list<string>{'CurrCode' ,'EffectDate' ,'InWorkflow' ,'Item','ItmDescription ','ItmUnitCost' ,'NoteExistsFlag' ,'RecordDate' ,'Reprice', 'UnitPrice1', 'UnitPrice2', 'UnitPrice3','UnitPrice4', 'UnitPrice5'};
                list<string> lst2 = new list<string>{'EffectDate ASC'};
                GETItemPricesController.itemPricesGETCallout('SLItemPrices', lst, filter, lst2, 0);
            }

            else if(syncType == 'Orders') 
            {
                //Orders GET
                string filter = 'CoNum = \'Q01-008486\' OR CoNum = \'S01-001575\' OR CoNum = \'S01-006903\' OR CoNum = \'Q01-002023\'';
                list<string> lst = new list<string>{'CustNum','CustSeq','CoNum','OrderDate','DerStatFormatted', 'CurrCode','BillToAddr_1','BillToAddr_2','BillToAddr_3','BillToAddr_4','BillToCity','BillToCountry','BillToName','BillToState','BillToZip'};
                list<string> lst2 = new list<string>();
                GETOrderController.orderGETCallout('SLCos', lst, filter, lst2, 1000);
            }
            else if(syncType == 'OrderItems') {
                //OrderItem GET
                string filter = 'CoNum = \'Q01-008486\' OR CoNum = \'S01-001575\' OR CoNum = \'S01-006903\' OR CoNum = \'Q01-002023\'';
                list<string> lst = new list<string>{'Item','CoLine','CoRelease','CoNum', 'RecordDate','DerCurrCode', 'Price', 'QtyOrdered'};
                list<string> lst2 = new list<string>{'Item ASC'};
                GETOrderItemsController.itemPricesGETCallout('SLCoItems', lst, filter, lst2, 1000);
            }
        }
        catch(exception e){
            msgToReturn = e.getMessage();
            System.debug('exception=='+e.getMessage());
        }
        return msgToReturn;
    }
}