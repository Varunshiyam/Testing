@isTest
public class TestRestrictContactByName  {
    
    @isTest
    static void testValidContactInsert() {
        Contact validContact = new Contact(FirstName = 'John', LastName = 'ValidName');
        Test.startTest();
        insert validContact;
        Test.stopTest();

        System.assertNotEquals(null, validContact.Id, 'Valid contact should be inserted');
    }

    @isTest
    static void testInvalidContactInsert() {
        Contact invalidContact = new Contact(FirstName = 'Jane', LastName = 'INVALIDNAME');
        Test.startTest();
        try {
            insert invalidContact;
            System.assert(false, 'Insert should have failed due to invalid LastName');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('not allowed for DML'), 'Expected validation error not found');
        }
        Test.stopTest();
    }

    @isTest
    static void testInvalidContactUpdate() {
        Contact c = new Contact(FirstName = 'Jim', LastName = 'GoodName');
        insert c;

        c.LastName = 'INVALIDNAME';
        Test.startTest();
        try {
            update c;
            System.assert(false, 'Update should have failed due to invalid LastName');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('not allowed for DML'), 'Expected update validation error not found');
        }
        Test.stopTest();
    }
}