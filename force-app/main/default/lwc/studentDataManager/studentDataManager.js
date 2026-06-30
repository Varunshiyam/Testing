import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi'; // optional alternative
import { LightningElement, track, wire } from 'lwc';
import getName from '@salesforce/apex/StudentController.getName';
import Create from '@salesforce/apex/StudentController.Create';
import deletestudent from '@salesforce/apex/StudentController.deletestudent';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class StudentComponent extends LightningElement {
    @track students;
    @track error;
    @track wiredResult;

    // Form fields
    name = '';
    email = '';
    rollno = '';
    year = '';

    // Table Columns
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email__c' },
        { label: 'Roll No', fieldName: 'Roll_No__c' },
        { label: 'Year', fieldName: 'Year_Of_Studying__c' },
        {
            type: 'button',
            typeAttributes: {
                label: 'Delete',
                name: 'delete',
                variant: 'destructive',
                iconName: 'utility:delete'
            }
        }
    ];

    // Fetch student records
    @wire(getName)
wiredStudents(result) {
    this.wiredResult = result;
    if (result.data) {
        this.students = result.data;
    } else if (result.error) {
        this.error = result.error;
    }
}

    @wire(getName)
    wiredStudents({ data, error }) {
        if (data) {
            this.students = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.students = undefined;
        }
    }

    handleInputChange(event) {
        const field = event.target.dataset.id;
        this[field] = event.target.value;
    }

    createStudent() {
        if (this.name && this.email && this.rollno && this.year) {
            Create({ name: this.name, mail: this.email, rollno: this.rollno, year: this.year })
                .then(result => {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: 'Student created',
                        variant: 'success'
                    }));
                    this.resetForm();
                    return refreshApex(this.wiredResult);
 // Refresh list
                })
                .catch(error => {
                    this.error = error;
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    }));
                });
        }
    }

    handleRowAction(event) {
        const action = event.detail.action;
        const row = event.detail.row;

        if (action.name === 'delete') {
            deletestudent({ studentId: row.Id })
                .then(() => {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Deleted',
                        message: 'Student record deleted',
                        variant: 'success'
                    }));
                    return refreshApex(this.wiredStudents); // Refresh list
                })
                .catch(error => {
                let errMsg = 'Unknown error';
                    if (error && error.body && error.body.message) {
                        errMsg = error.body.message;
                    } else if (error && error.message) {
                        errMsg = error.message;
    }

    this.dispatchEvent(new ShowToastEvent({
        title: 'Error creating record',
        message: errMsg,
        variant: 'error'
    }));
});

        }
    }

    resetForm() {
        this.name = '';
        this.email = '';
        this.rollno = '';
        this.year = '';
    }
}