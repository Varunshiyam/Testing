public with sharing class HandsonCase {

    @AuraEnabled
    public static void createcase(
        Integer num,
        Id accid,
        String subjectparm
    ) {

        

        List<Case> caselst = new List<Case>();

        for (Integer i = 1; i <= num; i++) {
            Case c = new Case();
            c.Status    = 'Working';
            c.Origin    = 'Phone';
            c.Subject   = subjectparm + ' ' + i;
            c.AccountId = accid;

            caselst.add(c);
        }

        insert caselst;
    }
}