public class first {

    public static void updateOlderAccounts(){
        List<Account> Accountlist= [SELECT Id, Description FROM Account ORDER BY CreatedDate ASC LIMIT 5 ];
        for( Account i:Accountlist){
            i.Description='Heritage Account';
            
        }
    }
}