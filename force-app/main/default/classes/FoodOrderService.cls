public with sharing class FoodOrderService {

    @AuraEnabled
    public static Id createFoodOrder(
        Double customerLat,
        Double customerLng
    ) {
        // Validate input
        if (customerLat == null || customerLng == null) {
            throw new AuraHandledException('Customer location is required');
        }

        // Fetch active delivery agents
        List<Delivery_Agent__c> agents = [
            SELECT Id,
                   Current_Location__Latitude__s,
                   Current_Location__Longitude__s
            FROM Delivery_Agent__c
            WHERE Is_Active__c = true
            LIMIT 1
        ];

        if (agents.isEmpty()) {
            throw new AuraHandledException('No active delivery agents available');
        }

        // Assign nearest agent (simple version for Phase 2)
        Delivery_Agent__c assignedAgent = agents[0];

        // Create Food Order
        Food_Order__c order = new Food_Order__c(
            Status__c = 'Placed',
            Delivery_Agent__c = assignedAgent.Id,
            Customer_Location__Latitude__s = customerLat,
            Customer_Location__Longitude__s = customerLng
        );

        insert order;
        return order.Id;
    }
}