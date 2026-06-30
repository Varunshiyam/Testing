trigger mailtrigger on ELECTRONICPRODUCT__c (after insert) {
    // Only one email per transaction
    if (!Trigger.new.isEmpty()) {
        // You can modify this to loop and send per record, but that hits limits.
        ELECTRONICPRODUCT__c  product = Trigger.new[0];
        
        String toAddress = '717823s160@kce.ac.in';  // Replace with actual email
        String subject = 'New Electronic Product Created';
        String body = 'A new electronic product has been inserted:\n\n' +
                      'Name: ' + product.Name + '\n' +
                      'ID: ' + product.Id + '\n\n' +
                      'Regards,\nSalesforce System';

        // Use your reusable class
        EmailManager.sendMail(toAddress, subject, body);
    }
}