trigger AccountBeforeInsertTrigger on Account (before insert) {
    System.debug('Trigger.old = ' + Trigger.old);
    System.debug('Trigger.new = ' + Trigger.new);
}