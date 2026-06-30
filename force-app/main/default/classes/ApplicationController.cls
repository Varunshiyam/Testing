// LWC 1
public with sharing class ApplicationController {
    @AuraEnabled(cacheable=true)
    public static List<Application__c> getApplications() {
        return [SELECT Id, Name, Student_Name__c, Email__c, Role_Applied__c,
                       Current_Status__c, Note__c, Last_Date_to_Apply__c,
                       Applied_On__c, Applied__c, Company_Name__c
                  FROM Application__c
                  ORDER BY CreatedDate DESC];
    }

    @AuraEnabled
    public static Application__c createApplication(String name,
                                                  String studentName,
                                                  String email,
                                                  String role,
                                                  String status,
                                                  String note,
                                                  Date lastDate,
                                                  Date appliedOn,
                                                  Boolean applied,
                                                  String companyName) {
        Application__c app = new Application__c(
            Name = name,
            Student_Name__c = studentName,
            Email__c = email,
            Role_Applied__c = role,
            Current_Status__c = status,
            Note__c = note,
            Last_Date_to_Apply__c = lastDate,
            Applied_On__c = appliedOn,
            Applied__c = applied,
            Company_Name__c = companyName
        );
        insert app;
        return app;
    }

    @AuraEnabled
    public static void deleteApplication(Id appId) {
        delete [SELECT Id FROM Application__c WHERE Id = :appId];
    }
}