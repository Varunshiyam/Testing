@IsTest
public class HandsonCase_Test {

    @TestSetup
    static void setup() {
        Account acc = new Account(Name = 'Test case');
        insert acc;
    }

    @IsTest
    static void testCreateCase() {


        Id accId = [SELECT Id FROM Account WHERE Name = 'Test case' LIMIT 1].Id;


        Test.startTest();
        HandsonCase.createcase(2, accId, 'Test From TestClass');
        Test.stopTest();


        List<Case> casesList = [
            SELECT Id, Subject, AccountId
            FROM Case
            WHERE AccountId = :accId
        ];

        System.assertEquals(
            2,
            casesList.size(),
            'Two cases should be created'
        );
    }
}