public class product_page {   
    public List<ELECTRONICPRODUCT__c> products {get ;set;}
    public product_page(){
        products=[SELECT name__c, price__c FROM ELECTRONICPRODUCT__c LIMIT 10];
    }
}