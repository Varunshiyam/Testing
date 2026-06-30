import { LightningElement } from 'lwc';

export default class BookIssue extends LightningElement {

    issueDate;
    returnDate;

    today = new Date().toISOString().split('T')[0];

    handleIssueDate(event) {
        this.issueDate = event.target.value;
    }

    handleReturnDate(event) {
        this.returnDate = event.target.value;
    }

    handleSubmit() {

        // 🔹 1. Required field validation
        const fields = this.template.querySelectorAll(
            'lightning-input-field'
        );

        let isValid = true;
        fields.forEach(field => {
            if (!field.reportValidity()) {
                isValid = false;
            }
        });

        if (!isValid) return;

        // 🔹 2. Issue Date should not be in the past
        if (this.issueDate < this.today) {
            alert('Issue Date cannot be in the past');
            return;
        }

        // 🔹 3. Return Date must be GREATER than Issue Date
        if (this.returnDate <= this.issueDate) {
            alert('Return Date must be after Issue Date');
            return;
        }

        // ✅ 4. Submit only if all validations pass
        this.template
            .querySelector('lightning-record-edit-form')
            .submit();
    }
}