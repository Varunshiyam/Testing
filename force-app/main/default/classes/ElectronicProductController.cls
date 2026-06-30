public with sharing class ElectronicProductController {
@AuraEnabled(cacheable=true)
public static Product2 getProductByName(String name) {
List<Product2> products = [SELECT Id, Name, Price__c  FROM Product2 WHERE Name = :name LIMIT 1];
if (products.isEmpty()) {
return null;
}
return products[0];
}
}