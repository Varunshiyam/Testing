public class Student_data {
    public void Insertion(String name, String rollno, String year, String mail){
     Student_Data__c data= new Student_Data__c(Name=name,Year_Of_Studying__c = year, Roll_No__c= rollno,Email__c =mail);
     Insert data;
    }

}