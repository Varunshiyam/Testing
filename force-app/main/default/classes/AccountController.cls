public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccountById(Id accountId) {
        return [
            SELECT Id, Name, Industry, Phone, Website, BillingCity
            FROM Account
            WHERE Id = :accountId
        ];
    }
}