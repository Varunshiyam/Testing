import { LightningElement } from 'lwc';
import bookcreate from '@salesforce/apex/BookLWCController.bookcreate';

export default class book extends LightningElement {

    name;
    author;
    isbn;
    price;
    copies;
    purchasedDate;

    handleName(event) {
        this.name = event.target.value;
    }

    handleAuthor(event) {
        this.author = event.target.value;
    }

    handleIsbn(event) {
        this.isbn = event.target.value;
    }

    handlePrice(event) {
        this.price = event.target.value;
    }

    handleCopies(event) {
        this.copies = event.target.value;
    }

    handleDate(event) {
        this.purchasedDate = event.target.value;
    }

    saveBook() {
    bookcreate({
        name: this.name,
        author: this.author,
        isbn: this.isbn,
        price: this.price,
        copies: this.copies,
        purchasedDate: this.purchasedDate
    })
    .then(id => {
        alert('Book created successfully: ' + id);
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

}