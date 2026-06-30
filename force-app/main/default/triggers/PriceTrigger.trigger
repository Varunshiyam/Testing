trigger PriceTrigger on Product2 (before update) {
    for(Product2 newprod: trigger.new){
        Product2 oldprod= Trigger.oldMap.get(newprod.Id);
        
        if(oldprod.Price__c > newprod.Price__c ){
            system.debug('Trigger fired');
        }
            
        
    }

}