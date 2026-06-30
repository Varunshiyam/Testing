public class Updatefield {
    public void run(){
        List<Account> acclist= [SELECT Id FROM Account];

        for(Account i:acclist){
            i.Status__c='Active';
            
        }
        update acclist;
    }
}