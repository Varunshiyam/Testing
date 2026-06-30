public class BookIssueLWCController {
    @AuraEnabled
    public static Id Createbookissue(String name , Id books, Id contact, Date Issuedate, Date Returndate){
        Book_Issue__c bookissue= new Book_Issue__c(Name=name, Books__c=books, Contact__c=contact, Issue_Date__c =Issuedate, Return_Date__c =Returndate  );
    	insert bookissue;
        return bookissue.id;
    
    }

}