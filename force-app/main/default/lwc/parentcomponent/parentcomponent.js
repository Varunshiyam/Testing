import { LightningElement } from 'lwc';

export default class Parentcomponent extends LightningElement {
    parentName = '';
    showChild = false;
    passvalue;

    handleChange(event) {
        this.parentName = event.target.value;
    }

    handleClick() {
        this.showChild = true;
        this.passvalue = this.parentName;
    }
}