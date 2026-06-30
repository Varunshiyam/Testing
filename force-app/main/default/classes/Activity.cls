public class Activity {
    public void run(){
        List<ELECTRONICPRODUCT__c> elelist= [SELECT price__c FROM ELECTRONICPRODUCT__c ];
        for(ELECTRONICPRODUCT__c i:elelist){
            if(i.price__c<=500){
                i.pricedesp__c='LOW';
            }
            else if(i.price__c>=501 && i.price__c<=1000){
                i.pricedesp__c='MEDIUM';
                }
            else {
                i.pricedesp__c='HIGH';
            }
        }
        update elelist;
    }
    

}