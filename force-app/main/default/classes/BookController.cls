public class BookController {
    
    public Books__c book{ get; set;}
    
    public BookController (){
        book=new Books__c();
    }
    
    public PageReference saveBook() {
        insert book;
        return new PageReference('/' + book.Id);
    }
    

}