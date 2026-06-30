import { LightningElement } from 'lwc';
import createFoodOrder from
'@salesforce/apex/FoodOrderService.createFoodOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FoodOrderForm extends LightningElement {
    customerLat;
    customerLng;

    handleLat(event) {
        this.customerLat = event.target.value;
    }

    handleLng(event) {
        this.customerLng = event.target.value;
    }

    placeOrder() {
    console.log('Button clicked');
    console.log('Latitude:', this.customerLat);
    console.log('Longitude:', this.customerLng);

    createFoodOrder({
        customerLat: this.customerLat,
        customerLng: this.customerLng
    })
    .then(orderId => {
        console.log('Order created:', orderId);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Food Order created',
                variant: 'success'
            })
        );
    })
    .catch(error => {
        console.error('ERROR FROM APEX:', JSON.stringify(error));
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: error.body?.message || 'Unknown error',
                variant: 'error'
            })
        );
    });
}

}