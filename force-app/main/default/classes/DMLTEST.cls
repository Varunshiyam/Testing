public class DMLTEST {
    public static void test() {

        Integer i = 100;

        // SOSL should be OUTSIDE the loop
        List<List<SObject>> searchResults = [
            FIND '"Execute Anonymous Account"'
            IN NAME FIELDS
            RETURNING Account(Name)
        ];

        // Extract Account records
        List<Account> accList = (List<Account>) searchResults[0];

        for(Integer j = 0; j < i; j++){
            for(Account acc : accList){
                System.debug(acc.Name);
            }
        }
    }
}