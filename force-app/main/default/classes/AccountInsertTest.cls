@isTest
public class AccountInsertTest {

    @isTest
    static void testInsertAccount() {
        // 1. Create test data
        Account acc = new Account(
            Name = 'Test Account'
        );

        // 2. Perform DML operation
        insert acc;

        // 3. Verify result
        Account insertedAcc = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertNotEquals(null, insertedAcc.Id, 'Account was not inserted');
        System.assertEquals('Test Account', insertedAcc.Name);
    }
}