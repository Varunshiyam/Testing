public class BookIssueCreate {
    
    public Book_Issue__c  book{ get; set;}
    
    public BookIssueCreate (){
        book=new Book_Issue__c ();
    }
    
    public PageReference saveBook() {
        insert book;
        return new PageReference('/' + book.Id);
    }
    

}