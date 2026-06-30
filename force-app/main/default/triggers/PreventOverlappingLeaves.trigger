trigger PreventOverlappingLeaves on Leave_Request__c (before insert, before update) {
    

    // Collect employee IDs from all leave requests in this trigger context
    Set<Id> employeeIds = new Set<Id>();
    for (Leave_Request__c lr : Trigger.new) {
        if (lr.Employee_Details__c != null) {
            employeeIds.add(lr.Employee_Details__c);
        }
    }

    
    // Query existing leave requests for all these employees
    Map<Id, List<Leave_Request__c>> leavesMap = new Map<Id, List<Leave_Request__c>>();
    for (Leave_Request__c existing : [
            SELECT Id, Employee_Details__c, Start_Date__c, End_Date__c
            FROM Leave_Request__c
            WHERE Employee_Details__c IN :employeeIds
        ]) {
        if (!leavesMap.containsKey(existing.Employee_Details__c)) {
            leavesMap.put(existing.Employee_Details__c, new List<Leave_Request__c>());
        }
        leavesMap.get(existing.Employee_Details__c).add(existing);
    }

    // For each trigger record, check for overlapped dates
    for (Leave_Request__c lr : Trigger.new) {
        if (lr.Employee_Details__c == null || lr.Start_Date__c == null || lr.End_Date__c == null)
            continue;

        List<Leave_Request__c> employeeLeaves = leavesMap.get(lr.Employee_Details__c);

        if (employeeLeaves == null) continue;

        for (Leave_Request__c existing : employeeLeaves) {
            // Skip checking against itself (for update)
            if (Trigger.isUpdate && existing.Id == lr.Id) continue;

            // Overlap logic:
            // If (new.start <= existing.end) && (existing.start <= new.end) --> Overlap!
            if (lr.Start_Date__c <= existing.End_Date__c && existing.Start_Date__c <= lr.End_Date__c) {
                lr.addError('There is already a leave request that overlaps with these dates for this employee.');
                break;
            }
        }
    }
}