import { LightningElement, track } from 'lwc';
import getProducts from '@salesforce/apex/ProductController.getProducts';
import createProduct from '@salesforce/apex/ProductController.createProduct';
import deleteProduct from '@salesforce/apex/ProductController.deleteProduct';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ProductManager extends LightningElement {
    @track productName = '';
    @track productPrice;
    @track products;

    columns = [
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'Price', fieldName: 'Price__c', type: 'currency' },
    {
        type: 'button',
        fieldName: 'delete', // Not required, but doesn't hurt
        typeAttributes: {
            label: 'Delete',
            name: 'delete',
            title: 'Delete Product',
            iconName: 'utility:delete',
            variant: 'destructive'
        }
    }
];


    connectedCallback() {
        this.fetchProducts();
    }

    fetchProducts() {
        getProducts()
            .then(data => {
                this.products = data;
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    handleNameChange(event) {
        this.productName = event.target.value;
    }

    handlePriceChange(event) {
        this.productPrice = event.target.value;
    }

    addProduct() {
        if (!this.productName || !this.productPrice) {
            this.showToast('Validation Error', 'Please fill in both name and price', 'warning');
            return;
        }

        createProduct({ name: this.productName, price: parseFloat(this.productPrice) })
            .then(() => {
                this.showToast('Success', 'Product added', 'success');
                this.productName = '';
                this.productPrice = '';
                this.fetchProducts();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

handleRowAction(event) {
    console.log('Row action triggered:', JSON.stringify(event.detail));

    const action = event.detail.action;
    const row = event.detail.row;

    if (action.name === 'delete') {
        deleteProduct({ productId: row.Id })
            .then(() => {
                this.showToast('Deleted', 'Product deleted', 'success');
                this.fetchProducts();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
                console.error(error);
            });
    }
}




    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}