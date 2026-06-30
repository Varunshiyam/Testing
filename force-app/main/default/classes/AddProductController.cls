public class AddProductController {
public String productName { get; set; }
public Decimal productPrice { get; set; }
public String message { get; set; }
    public void AddProductController(){}

 public void saveProduct() {
  if (String.isNotBlank(productName) && productPrice != null) {
      ELECTRONICPRODUCT__c  newProduct = new ELECTRONICPRODUCT__c (
           Name__c = productName,
            price__c = productPrice
         );
            insert newProduct;
            message = 'Product added successfully!';
            productName = '';
            productPrice = null;
        } else {
            message = 'Please enter both product name and price.';
        }
    }
}