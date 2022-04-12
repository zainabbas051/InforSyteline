import { LightningElement } from 'lwc';
import SyncScreenController from '@salesforce/apex/SyncScreenController.callSyncMethods';

export default class SyncScreenLWC1 extends LightningElement {

  dboxmsg;
    syncProducts(event){
 
        SyncScreenController({ syncType: 'Products' })
          .then(result => {
            console.log('Result', result);
            this.dboxmsg = '<strong>' + result + '</strong><br/>';
          })
          .catch(error => {
            console.error('Error:', error);
            this.dboxmsg = '<strong>' + error + '</strong><br/>';
        });
    
    }

    syncOrderItems(event){
 
        SyncScreenController({ syncType: 'OrderItems' })
          .then(result => {
            console.log('Result', result);
            this.dboxmsg = '<strong>' + result + '</strong><br/>';
          })
          .catch(error => {
            console.error('Error:', error);
            this.dboxmsg = '<strong>' + error + '</strong><br/>';
        });
    
    }

    syncPricing(event){
 
        SyncScreenController({ syncType: 'Pricing' })
          .then(result => {
            console.log('Result', result);
            this.dboxmsg = '<strong>' + result + '</strong><br/>';
          })
          .catch(error => {
            console.error('Error:', error);
            this.dboxmsg = '<strong>' + error + '</strong><br/>';
        });
    
    }

    syncCustomers(event){
 
        SyncScreenController({ syncType: 'Customers' })
          .then(result => {
            console.log('Result', result);
            this.dboxmsg = '<strong>' + result + '</strong><br/>';
          })
          .catch(error => {
            console.error('Error:', error);
            this.dboxmsg = '<strong>' + error + '</strong><br/>';
        });
    
    }

    syncOrders(event){
 
      SyncScreenController({ syncType: 'Orders' })
        .then(result => {
          console.log('Result', result);
          this.dboxmsg = '<strong>' + result + '</strong><br/>';
        })
        .catch(error => {
          console.error('Error:', error);
          this.dboxmsg = '<strong>' + error + '</strong><br/>';
      });
  
  }

}