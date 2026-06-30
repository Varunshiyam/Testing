public class StudentAdmissionController {
public Student__c student { get; set; }
public Admission__c admission { get; set; }
public StudentAdmissionController() {
student = new Student__c();
admission = new Admission__c();
}
public PageReference saveDetails() {
try {
insert student;
admission.Student__c = student.Id;
insert admission;
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Admissionsuccessful.'));
} catch (Exception e) {
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
}
return null;
}
}