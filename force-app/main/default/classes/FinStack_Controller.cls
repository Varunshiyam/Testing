@RestResource(urlMapping='/finteam/*')
global with sharing class FinStack_Controller {

    // GET /services/apexrest/finteam/<recordId>
    @HttpGet
    global static Fin_Team__c getTeamData() {
        RestRequest req = RestContext.request;
        String id = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        try {
            Fin_Team__c team = [
                SELECT Id, Name, Corp_Management__c, Quotation__c
                FROM Fin_Team__c
                WHERE Id = :id
                LIMIT 1
            ];
            return team;
        } catch (Exception e) {
            RestContext.response.statusCode = 404;
            RestContext.response.responseBody = Blob.valueOf('Fin_Team__c record not found.');
            return null;
        }
    }

    // POST /services/apexrest/finteam/
    @HttpPost
    global static String createTeamData() {
        RestRequest req = RestContext.request;
        String requestBody = req.requestBody.toString();

        // Deserialize JSON to Map
        Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

        // Extract fields from JSON body
        String name = (String) data.get('name');
        String corpMgmt = (String) data.get('corpManagement');
        Decimal quotation = (data.containsKey('quotation')) ? Decimal.valueOf(String.valueOf(data.get('quotation'))) : null;

        // Create new record
        Fin_Team__c newTeam = new Fin_Team__c(
            Name = name,
            Corp_Management__c = corpMgmt,
            Quotation__c = quotation
        );

        insert newTeam;

        return newTeam.Id;
    }
}