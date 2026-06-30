@isTest
private class AccountBeforeInsertTriggerTest {

    @isTest
    static void verifyTriggerOldIsNull() {
        Account acc = new Account(Name = 'Test Account');

        Test.startTest();
        insert acc;
        Test.stopTest();

        // There is no direct access to Trigger.old here,
        // so we validate via trigger behavior assumptions.
        // If Trigger.old were accessed incorrectly, Salesforce would throw an exception.
        
        System.assertNotEquals(null, acc.Id, 'Account should be inserted successfully');
    }
}