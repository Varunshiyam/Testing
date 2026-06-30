import { LightningElement } from 'lwc';
import createcase from '@salesforce/apex/HandsonCase.createcase';

export default class CaseAccountInput extends LightningElement {

    subject = '';
    accountId;
    numberofcases;

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleAccountChange(event) {
        this.accountId = event.detail.recordId;
    }

    handlenumberofcasesChange(event) {
        this.numberofcases = event.target.value;
    }

    handleCreateCases() {
        createcase({
            subjectparm: this.subject,
            accid: this.accountId,
            num: this.numberofcases
        })
        .then(() => {
            alert('Cases created successfully');
        })
        .catch(error => {
            console.error(error);
            alert(error.body.message);
        });
    }
}