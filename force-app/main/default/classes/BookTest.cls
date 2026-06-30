@isTest
public class BookTest {
    @isTest static void test1(){
        Book__c b= new Book__c(Name='first', Price__c=1000);
        System.debug('Price Befor Discount the Book'+b.Price__c	);
        Insert b;
        
        b=[SELECT Price__c	FROM Book__c WHERE ID= :b.ID];
        System.debug('Price After Discount Applied'+ b.Price__c);
    }

}