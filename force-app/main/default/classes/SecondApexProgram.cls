public class SecondApexProgram {

 public String Types; 


public void setAccountType(String Types) {
        this.Types = Types;
    }
    
public String getAccounts() {
    
        List<Account> AccountList = [SELECT Name FROM Account WHERE Type = :this.Types LIMIT 10];

        if (!AccountList.isEmpty()) {
            List<String> names = new List<String>();
			for (Account acc : AccountList) {
   				 names.add(acc.Name);}
			
            return String.join(names, ', ');

        } else {
            return 'Wrong Type';
        }
    }
}