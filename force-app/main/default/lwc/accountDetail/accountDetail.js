import { LightningElement, api, wire } from 'lwc';
import getAccountById from '@salesforce/apex/AccountController.getAccountById';

export default class AccountDetail extends LightningElement {

    @api accountId;
    account;

    @wire(getAccountById, { accountId: '$accountId' })
    wiredAccount({ data, error }) {
        if (data) {
            this.account = data;
        } else if (error) {
            console.error(error);
        }
    }
}