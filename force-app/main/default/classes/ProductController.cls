public with sharing class ProductController {
@AuraEnabled(cacheable=true)
public static List<Product2 > getProducts() {
return [SELECT Id, Name, Price__c  FROM Product2  ORDER BY
CreatedDate DESC];
}
@AuraEnabled
public static Product2 	 createProduct(String name, Decimal price) {
Product2  prod = new Product2  (Name = name, Price__c  = price);
insert prod;
return prod;
}
@AuraEnabled
public static void deleteProduct(Id productId) {
delete [SELECT Id FROM Product2  WHERE Id = :productId LIMIT 1];
}
}