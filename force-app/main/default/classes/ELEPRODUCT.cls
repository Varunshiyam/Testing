public class ELEPRODUCT {
    public void run(){
        
        List<ELECTRONICPRODUCT__c> elelist= new List<ELECTRONICPRODUCT__c> {
            new ELECTRONICPRODUCT__c(Name= 'firstproduct' ,Name__c ='prod1', price__c= 9000),
			new ELECTRONICPRODUCT__c(Name= 'secondproduct' ,Name__c ='prod2', price__c= 5000),
            new ELECTRONICPRODUCT__c(Name= 'thirdproduct' ,Name__c ='prod3', price__c= 2000)};
            
    
    Insert elelist;
        
        List<ELECTRONICPRODUCT__c> updatelist = new list<ELECTRONICPRODUCT__c> ();
        for(ELECTRONICPRODUCT__c i: updatelist){
            if(i.price__c >= 9000){
                i.price__c=7000;
                updatelist.add(i);
            }
        }
    
update updatelist;
    }
}