trigger Booktrigger on Book__c (before insert) {
    
    Book__c[] books= Trigger.new;
    BookClass.applydisc(books);

}