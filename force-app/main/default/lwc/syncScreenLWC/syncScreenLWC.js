import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import SyncScreenController from "@salesforce/apex/SyncScreenController.callSyncMethods";

export default class SyncScreenLWC1 extends LightningElement {
  dboxmsg;

  makeToast = (title, message, variant) => {
    const toastEvent = new ShowToastEvent({
      title,
      message,
      variant
    });
    this.dispatchEvent(toastEvent);
  };

  syncProducts(event) {
    SyncScreenController({ syncType: "Products" })
      .then((result) => {
        console.log("Result", result);
        this.dboxmsg = "<strong>" + result + "</strong><br/>";
        this.makeToast("Success: Request Submitted!", result, "success");
      })
      .catch((error) => {
        console.error("Error:", error);
        this.dboxmsg = "<strong>" + error + "</strong><br/>";
        this.makeToast("Error", error, "error");
      });
  }

  syncOrderItems(event) {
    SyncScreenController({ syncType: "OrderItems" })
      .then((result) => {
        console.log("Result", result);
        this.dboxmsg = "<strong>" + result + "</strong><br/>";
        this.makeToast("Success: Request Submitted!", result, "success");
      })
      .catch((error) => {
        console.error("Error:", error);
        this.dboxmsg = "<strong>" + error + "</strong><br/>";
        this.makeToast("Error", error, "error");
      });
  }

  syncPricing(event) {
    SyncScreenController({ syncType: "Pricing" })
      .then((result) => {
        console.log("Result", result);
        this.dboxmsg = "<strong>" + result + "</strong><br/>";
        this.makeToast("Success: Request Submitted!", result, "success");
      })
      .catch((error) => {
        console.error("Error:", error);
        this.dboxmsg = "<strong>" + error + "</strong><br/>";
        this.makeToast("Error", error, "error");
      });
  }

  syncCustomers(event) {
    SyncScreenController({ syncType: "Customers" })
      .then((result) => {
        console.log("Result", result);
        this.dboxmsg = "<strong>" + result + "</strong><br/>";
        this.makeToast("Success: Request Submitted!", result, "success");
      })
      .catch((error) => {
        console.error("Error:", error);
        this.dboxmsg = "<strong>" + error + "</strong><br/>";
        this.makeToast("Error", error, "error");
      });
  }

  syncOrders(event) {
    SyncScreenController({ syncType: "Orders" })
      .then((result) => {
        console.log("Result", result);
        this.dboxmsg = "<strong>" + result + "</strong><br/>";
        this.makeToast("Success: Request Submitted!", result, "success");
      })
      .catch((error) => {
        console.error("Error:", error);
        this.dboxmsg = "<strong>" + error + "</strong><br/>";
        this.makeToast("Error", error, "error");
      });
  }
}