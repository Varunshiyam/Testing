public with sharing class StripePaymentService {



    @AuraEnabled
    public static String createCheckoutSession(Id orderId) {

        // 1️⃣ Fetch Order
        Order__c ord = [
            SELECT Id, Name, Amount__c
            FROM Order__c
            WHERE Id = :orderId
            LIMIT 1
        ];

        if (ord.Amount__c == null || ord.Amount__c <= 0) {
            throw new AuraHandledException('Order amount must be greater than 0');
        }

        Long amountInCents = (Long)(ord.Amount__c * 100);

        // 2️⃣ Create HTTP request
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://api.stripe.com/v1/checkout/sessions');
        req.setEndpoint('callout:Stripe_Legacy/v1/checkout/sessions');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + '{!$Credential.password}');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        // 🔥🔥🔥 THIS IS WHERE YOUR STRING BODY GOES 🔥🔥🔥
        String body =
            'mode=payment' +
            '&payment_method_types[]=card' +
            '&success_url=https://resilient-hawk-eqsdor-dev-ed.trailblaze.my.salesforce.com' +
            '&cancel_url=https://resilient-hawk-eqsdor-dev-ed.trailblaze.my.salesforce.com' +
            '&client_reference_id=' + ord.Id + // ⭐ VERY IMPORTANT ⭐
            '&line_items[0][price_data][currency]=usd' +
            '&line_items[0][price_data][product_data][name]=' +
                EncodingUtil.urlEncode(ord.Name, 'UTF-8') +
            '&line_items[0][price_data][unit_amount]=' + amountInCents +
            '&line_items[0][quantity]=1';

        req.setBody(body);

        // 3️⃣ Send request to Stripe
        Http http = new Http();
        HttpResponse res = http.send(req);

        System.debug('Stripe Response: ' + res.getBody());

        if (res.getStatusCode() == 200) {
            Map<String, Object> response =
                (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

            // 4️⃣ Return Checkout URL to LWC
            return (String) response.get('url');
        } else {
            throw new AuraHandledException(
                'Stripe Error: ' + res.getStatusCode() + ' - ' + res.getBody()
            );
            // return '';
        }
    }
}