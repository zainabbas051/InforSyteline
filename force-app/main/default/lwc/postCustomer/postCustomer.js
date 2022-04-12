import { LightningElement, api, wire } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { CurrentPageReference } from 'lightning/navigation';
import sendToDbox from '@salesforce/apex/POSTCustomerController.PostCustomer';
export default class PostCustomer extends LightningElement {
    @api recordId;
    msg;
    iconVisibility = true;
    showbutton=false;
    dboxmsg = '';
    execute=false;
    loaded = false;
    showLoader = false;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
            console.log('currentPageReference='+this.recordId);
            this.init();
        }
    }

    init(){
        console.log('id in method='+this.recordId);
        this.showLoader=true;
        sendToDbox({ AccSFId: this.recordId })
            .then(data => {
                console.log('Result', JSON.stringify(data));
                let classname='slds-text-heading_small slds-align_absolute-center slds-text-color_success';
                this.msg = '<br>'+ data;
                if(data.includes('Error')){
                    classname = 'slds-text-color_error';
                    this.iconVisibility = false;
                    this.msg = '<br> Something went wrong! '+data + '<br><br>';
                }
                if(this.msg.includes("went wrong!")){
                    this.showbutton=true;
                    this.iconVisibility = false;
                }
                this.dboxmsg = '<div class="slds-align_absolute-center"><div class="'+classname+'">'+this.msg+'</div></div>';
                this.loaded = true;
                this.showLoader=false;
            })
            .catch(error => {
                //this.error = error;
                console.error('Error:', JSON.stringify(error));
                let classname = 'slds-text-heading_small slds-align_absolute-center slds-text-color_error';
                this.dboxmsg = '<div class="'+classname+'">'+JSON.stringify(error)+'</br> Please contact the App Developer.</div> <br>';
                this.showbutton=true;
                this.iconVisibility = false;
                this.loaded = true;
            });
}

closeAction(){
    this.dispatchEvent(new CloseActionScreenEvent());
}
}