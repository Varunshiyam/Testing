import { LightningElement, track } from 'lwc';
import getProductByName from '@salesforce/apex/ElectronicProductController.getProductByName';
export default class ProductPriceFetcher extends LightningElement {
@track productName = '';
@track product;
@track errorMessage;
handleNameChange(event) {
this.productName = event.target.value;
}
fetchPrice() {
if (!this.productName) {
this.errorMessage = 'Please enter a product name.';
this.product = null;
return;
}
getProductByName({ name: this.productName })
.then(result => {
if (result) {
this.product = result;
this.errorMessage = null;
} else {
this.product = null;
this.errorMessage = 'Product not found.';
}
})
.catch(error => {
this.product = null;
this.errorMessage = 'Error: ' + error.body.message;
});
}
}