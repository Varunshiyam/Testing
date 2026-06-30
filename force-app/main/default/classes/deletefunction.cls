public class deletefunction {
    public void run(){
        ELECTRONICPRODUCT__c[] product= [SELECT Id FROM ELECTRONICPRODUCT__c WHERE Name__c ='prod2' ];
        delete product;
    }
}