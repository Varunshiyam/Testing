public class ContactTriggerHandler {

    public static void insertion(List<Contact> lst) {

        Set<Id> accountIds = new Set<Id>();

        for (Contact c : lst) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
		System.debug('insertion' + accountIds);
        updateAccountCounts(accountIds);
    }

    public static void updation(List<Contact> newList, List<Contact> oldList) {

        Set<Id> accountIds = new Set<Id>();

        for (Integer i = 0; i < newList.size(); i++) {
            Contact newC = newList[i];
            Contact oldC = oldList[i];

            // Re-parenting case
            if (newC.AccountId != oldC.AccountId) {
                if (newC.AccountId != null)
                    accountIds.add(newC.AccountId);

                if (oldC.AccountId != null)
                    accountIds.add(oldC.AccountId);
            }
        }

        updateAccountCounts(accountIds);
    }

    // Common reusable logic
    private static void updateAccountCounts(Set<Id> accountIds) {

        if (accountIds.isEmpty()) return;

        List<Account> accList = [
            SELECT Id, (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id IN :accountIds
        ];

        for (Account acc : accList) {
            acc.Total_Contact__c = acc.Contacts.size();
        }
		System.debug('updateAccountCounts' + accList);
        update accList;
    }
}