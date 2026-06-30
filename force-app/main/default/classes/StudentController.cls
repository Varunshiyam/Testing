public with sharing class StudentController {
@AuraEnabled(cacheable=true)
public static List<Student_Data__c> getName(){
return[SELECT Name,Year_Of_Studying__c ,Roll_No__c  FROM Student_Data__c ORDER BY CreatedDate DESC];
    }
    
@AuraEnabled
public static Student_Data__c Create(String name, String mail, String rollno,string year ){
Student_Data__c stu = new Student_Data__c (Name= name,Roll_No__c= rollno, Year_Of_Studying__c= year, Email__c =mail );
Insert stu;
return stu;
}
@AuraEnabled
public Static void deletestudent(ID studentId){
delete [SELECT Id FROM Student_Data__c WHERE Id = :studentId LIMIT 1];
}
        
    }