public class Newclass {
    public void run(){
// Create the account sObject
Account acct = new Account(Name='Varun', Phone='(91)81229-97786', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;
// Get the new ID on the inserted sObject argument
ID acctID = acct.Id;
// Display this ID in the debug log
System.debug('ID = ' + acctID);
// Debug log result (the ID will be different in your case)

    }
 

}