@RestResource(urlMapping='/publicdata/*')
global with sharing class PublicDataController {

    /**
     * Handles HTTP GET requests.
     * Retrieves a PublicData__c record based on the ID provided in the URL.
     * Example URL: /services/apexrest/publicdata/a009D000003vjfgQAA
     */
    @HttpGet
    global static PublicData__c getData() {
        RestRequest req = RestContext.request;

        // Extract record ID from request URL
        String recordId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        
        try {
            // Retrieve the record
            PublicData__c result = [
                SELECT Id, Name, Description__c
                FROM PublicData__c
                WHERE Id = :recordId
                LIMIT 1
            ];

            return result;
        } catch (QueryException e) {
            // If no record found, return 404
            RestContext.response.statusCode = 404;
            return null;
        }
    }

    /**
     * Handles HTTP POST requests.
     * The request body should be:
     * {
     *   "name": "Item Name",
     *   "description": "Some description"
     * }
     */
    @HttpPost
    global static String createData() {
        try {
            // Read the request body
            String body = RestContext.request.requestBody.toString();

            // Deserialize JSON to a map
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(body);

            // Extract fields
            String name = (String) data.get('name');
            String description = (String) data.get('description');

            // Create and insert record
            PublicData__c newData = new PublicData__c(
                Name = name,
                Description__c = description
            );
            insert newData;

            return newData.Id;

        } catch (Exception e) {
            RestContext.response.statusCode = 500;
            return 'Error: ' + e.getMessage();
        }
    }
}