trigger Student_mail_trigger on Student_Data__c (after insert, after update) {

    if (!Trigger.new.isEmpty()) {


        Student_Data__c studentmail = Trigger.new[0];
        

        String toAddress = studentmail.Email__c;
        String subject = 'Your Submission Was Successful';
        String body = 'Your Recent Insertion was Successful:\n\n' +
                      'Name: ' + studentmail.Name + '\n' +
                      'Roll NO: ' + studentmail.Roll_No__c + '\n' +
                      'Year: ' + studentmail.Year_Of_Studying__c + '\n\n' +
                      'Regards,\n VarunShiyam';

        //reusable email class
        EmailManager.sendMail(toAddress, subject, body);
    }
}