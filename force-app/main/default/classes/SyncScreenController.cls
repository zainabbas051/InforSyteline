public without sharing class SyncScreenController {
    public SyncScreenController() {

    }

    @AuraEnabled
    public static string callSyncMethods(string syncType) 
    {
        string msgToReturn = 'Success: Please wait for the Process to finish';
        try{
            if(syncType == 'Customers')
            {
                //Customers GET
                list<string> lst = new list<string>{'CustNum','CustSeq','Name','City','Country', 'Addr_1','Addr_2','Addr_3','Addr_4','State','Zip','Phone_1'};
                list<string> lst2 = new list<string>();
                GETCustomerController.customerGETCallout('SLCustomers', lst, '', lst2, 20);
            }
            else if(syncType == 'Products'){
                //Products GET
                list<string> lst = new list<string>{'Description' ,'Item' ,'DerQtyOnHand', 'ProductCode', 'Overview'};
                list<string> lst2 = new list<string>();
                GETItemController.itemGETCallout('SLItems', lst, '', lst2, 1000);

            } 
            else if(syncType == 'Pricing') {
                //PricebookEntries GET
                list<string> lst = new list<string>{'CurrCode' ,'EffectDate' ,'InWorkflow' ,'Item','ItmDescription ','ItmUnitCost' ,'NoteExistsFlag' ,'RecordDate' ,'Reprice', 'UnitPrice1', 'UnitPrice2', 'UnitPrice3','UnitPrice4', 'UnitPrice5'};
                list<string> lst2 = new list<string>{'EffectDate ASC'};
                GETItemPricesController.itemPricesGETCallout('SLItemPrices', lst, '', lst2, 5000);
            }

            else if(syncType == 'Orders') 
            {
                //Orders GET
                list<string> lst = new list<string>{'CustNum','CustSeq','CoNum','OrderDate','DerStatFormatted'};
                list<string> lst2 = new list<string>();
                GETOrderController.orderGETCallout('SLCos', lst, '', lst2, 10);
            }
            else if(syncType == 'OrderItems') {
                //OrderItem GET
                string filter = 'CoNum = \'Q01-000203\'';
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