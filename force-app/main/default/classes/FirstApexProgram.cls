public class FirstApexProgram {

    public String Name; 


    public void setProductName(String Name) {
        this.Name = Name;
    }


    public String getProductCode() {
        List<Product2> productList = [SELECT Name, ProductCode FROM Product2 WHERE Name = :this.Name LIMIT 1];

        if (!productList.isEmpty()) {
            return productList[0].ProductCode;
        } else {
            return 'Product not found';
        }
    }
}