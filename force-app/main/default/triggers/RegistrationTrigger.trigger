trigger RegistrationTrigger on Registration__c (before insert) {
    Set<Id> eventIds = new Set<Id>();
    for (Registration__c reg : Trigger.new) {
        if (reg.Event__c != null) {
            eventIds.add(reg.Event__c);
        }
    }

    Map<Id, Event__c> eventMap = new Map<Id, Event__c>(
        [SELECT Id, Max_Participants__c,
         (SELECT Id FROM Registrations__r)
         FROM Event__c WHERE Id IN :eventIds]
    );

    for (Registration__c reg : Trigger.new) {
        if (reg.Event__c != null) {
            Event__c ev = eventMap.get(reg.Event__c);
            Integer currentCount = ev.Registrations__r.size();
            if (currentCount >= ev.Max_Participants__c) {
                reg.addError('Maximum number of participants reached for this event.');
            }
        }
    }
}