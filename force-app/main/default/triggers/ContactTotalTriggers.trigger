trigger ContactTotalTriggers on Contact (after insert, after update, after delete) {

    if (Trigger.isAfter) {

        if (Trigger.isInsert) {
            ContactTriggerHandler.insertion(Trigger.new);
        }

        if (Trigger.isUpdate) {
            ContactTriggerHandler.updation(Trigger.new, Trigger.old);
        }

        if (Trigger.isDelete) {
            ContactTriggerHandler.insertion(Trigger.old);
        }
    }
}