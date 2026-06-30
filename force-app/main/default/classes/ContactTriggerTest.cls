@isTest
public class ContactTriggerTest {

    @isTest
    static void testContactInsert() {

        // Create test contact
        Contact con = new Contact(
            LastName = 'Test Contact',
            Email = 'test@test.com'
        );

        // Insert to fire trigger
        insert con;

        // Re-query to verify trigger logic
        Contact insertedCon = [
            SELECT Id, LastName, Email
            FROM Contact
            WHERE Id = :con.Id
        ];

        // Assertions (required)
        System.assertNotEquals(null, insertedCon.Id);
        System.assertEquals('Test Contact', insertedCon.LastName);
    }
}