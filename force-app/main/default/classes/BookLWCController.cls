public class BookLWCController {
    @AuraEnabled
    public static Id bookcreate(String name, string author, string isbn, Decimal price,
        Integer copies,
        Date purchasedDate)
        {
            Books__c book=new Books__c(Name=name, Author__c =author, Available_Copies__c = copies, ISBN__c=isbn, Price_Of_The_Book__c = price, Purchased_Date__c = purchasedDate );
             insert book;
            return book.id;
        }

}