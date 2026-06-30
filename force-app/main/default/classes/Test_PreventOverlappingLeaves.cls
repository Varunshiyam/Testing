@isTest
public class Test_PreventOverlappingLeaves {

    @isTest
    static void testNoOverlapAllowed() {
        // Set up Employee
        Employee__c emp = new Employee__c(Name = 'Test Employee', Employee_ID__c = 'E123', Employee_Email__c = 'emp1@example.com');
        insert emp;

        // Create an existing leave request: Aug 7 - Aug 9, 2025
        Leave_Request__c leave1 = new Leave_Request__c(
            Name = 'Existing Leave',
            Employee_Details__c = emp.Id,
            Start_Date__c = Date.newInstance(2025, 8, 7),
            End_Date__c   = Date.newInstance(2025, 8, 9)
        );
        insert leave1;

        // Attempt to insert a new, overlapping leave: Aug 8 - Aug 10, 2025
        Leave_Request__c leave2 = new Leave_Request__c(
            Name = 'Overlapping Leave',
            Employee_Details__c = emp.Id,
            Start_Date__c = Date.newInstance(2025, 8, 8),
            End_Date__c   = Date.newInstance(2025, 8, 10)
        );

        Test.startTest();
        try {
            insert leave2;
            System.assert(false, 'Expected an overlap error, but record was inserted');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('overlaps'), 'Error message should mention overlap');
        }
        Test.stopTest();
    }

    @isTest
    static void testNoOverlapIsAllowed() {
        // Set up Employee
        Employee__c emp = new Employee__c(Name = 'Test Employee2', Employee_ID__c = 'E124', Employee_Email__c = 'emp2@example.com');
        insert emp;

        // Create an existing leave request: Aug 1 - Aug 3, 2025
        Leave_Request__c leave1 = new Leave_Request__c(
            Name = 'First Leave',
            Employee_Details__c = emp.Id,
            Start_Date__c = Date.newInstance(2025, 8, 1),
            End_Date__c   = Date.newInstance(2025, 8, 3)
        );
        insert leave1;

        // Non-overlapping leave: Aug 4 - Aug 6, 2025
        Leave_Request__c leave2 = new Leave_Request__c(
            Name = 'Second Leave',
            Employee_Details__c = emp.Id,
            Start_Date__c = Date.newInstance(2025, 8, 4),
            End_Date__c   = Date.newInstance(2025, 8, 6)
        );

        Test.startTest();
        insert leave2; // Should succeed without error
        Test.stopTest();

        // Confirm leave inserted
        Leave_Request__c inserted = [SELECT Id FROM Leave_Request__c WHERE Id = :leave2.Id];
        System.assertNotEquals(null, inserted, 'Expected the leave request to be inserted');
    }

    @isTest
    static void testDifferentEmployeeAllowed() {
        // Set up 2 employees
        Employee__c emp1 = new Employee__c(Name = 'Emp One', Employee_ID__c = 'E200', Employee_Email__c = 'emp200@example.com');
        Employee__c emp2 = new Employee__c(Name = 'Emp Two', Employee_ID__c = 'E201', Employee_Email__c = 'emp201@example.com');
        insert new List<Employee__c>{emp1, emp2};

        // emp1's leave: Aug 7-9
        Leave_Request__c leave1 = new Leave_Request__c(
            Name = 'Emp1 Leave',
            Employee_Details__c = emp1.Id,
            Start_Date__c = Date.newInstance(2025, 8, 7),
            End_Date__c   = Date.newInstance(2025, 8, 9)
        );
        insert leave1;

        // emp2's leave: Overlaps with emp1, but should be allowed
        Leave_Request__c leave2 = new Leave_Request__c(
            Name = 'Emp2 Overlapping',
            Employee_Details__c = emp2.Id,
            Start_Date__c = Date.newInstance(2025, 8, 8),
            End_Date__c   = Date.newInstance(2025, 8, 10)
        );
        insert leave2;
        System.assertNotEquals(null, leave2.Id, 'Leave for different employee must be allowed');
    }

    @isTest
    static void testUpdateOverlapNotAllowed() {
        // Employee
        Employee__c emp = new Employee__c(Name = 'Jack', Employee_ID__c = 'E511', Employee_Email__c = 'jack@example.com');
        insert emp;

        // First leave: Aug 2 - 5
        Leave_Request__c leave1 = new Leave_Request__c(
            Name = 'First',
            Employee_Details__c = emp.Id,
            Start_Date__c = Date.newInstance(2025, 8, 2),
            End_Date__c   = Date.newInstance(2025, 8, 5)
        );
        insert leave1;

        // Second leave: Aug 10 - 12
        Leave_Request__c leave2 = new Leave_Request__c(
            Name = 'Second',
            Employee_Details__c = emp.Id,
            Start_Date__c = Date.newInstance(2025, 8, 10),
            End_Date__c   = Date.newInstance(2025, 8, 12)
        );
        insert leave2;

        // Try updating second leave to overlap with first
        leave2.Start_Date__c = Date.newInstance(2025, 8, 4); // Now overlaps Aug 4-5
        leave2.End_Date__c   = Date.newInstance(2025, 8, 11);

        Test.startTest();
        try {
            update leave2;
            System.assert(false, 'Expected overlap error when updating');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('overlaps'), 'Should block overlapping on update');
        }
        Test.stopTest();
    }
}