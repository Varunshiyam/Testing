public with sharing class EmployeeLeaveController {
    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getEmployees() {
        return [SELECT Id, Name FROM Employee__c ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<LeaveWrapper> getLeavesForEmployee(Id employeeId) {
        List<LeaveWrapper> leavesList = new List<LeaveWrapper>();

        for (Leave_Request__c lr : [
            SELECT Id, Start_Date__c, End_Date__c, Request_Reason__c FROM Leave_Request__c
            WHERE Employee_Details__c = :employeeId
            ORDER BY Start_Date__c DESC
        ]) {
            Integer days = lr.End_Date__c.daysBetween(lr.Start_Date__c) + 1;
            leavesList.add(new LeaveWrapper(lr.Id, lr.Start_Date__c, lr.End_Date__c, days, lr.Request_Reason__c));
        }

        return leavesList;
    }

    public class LeaveWrapper {
        @AuraEnabled public Id leaveId {get;set;}
        @AuraEnabled public Date startDate {get;set;}
        @AuraEnabled public Date endDate {get;set;}
        @AuraEnabled public Integer numberOfDays {get;set;}
        @AuraEnabled public String reason {get;set;}

        public LeaveWrapper(Id leaveId, Date startDate, Date endDate, Integer numberOfDays, String reason) {
            this.leaveId = leaveId;
            this.startDate = startDate;
            this.endDate = endDate;
            this.numberOfDays = numberOfDays;
            this.reason = reason;
        }
    }
}