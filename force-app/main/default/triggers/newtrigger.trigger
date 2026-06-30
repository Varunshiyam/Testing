trigger newtrigger on Account (before update) {

     for (Account acc : Trigger.new) {
        Account oldAcc = Trigger.oldMap.get(acc.Id);
         if (acc.phone!= oldAcc.phone) {
            system.debug('phone updated');
        }
    }

}