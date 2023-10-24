public class CloneCheckHandler {
    public static void validateStatus(List<YourObject__c> newRecords) {

        // create set of original records that are being cloned
        Set<Id> originalRecordIds = new Set<Id>();

        for (YourObject__c newRecord : newRecords) {
            if (newRecord.isClone()) {
                originalRecordIds.add(newRecord.getCloneSourceId());
            }
        }

        // map original record IDs to their record
        Map<Id, YourObject__c> originalRecordsMap = new Map<Id, YourObject__c>([SELECT Id, Status__c FROM YourObject__c WHERE Id IN :originalRecordIds]);

        // for reach new record, verify that the Status on the original is not "Complete"
        for (YourObject__c newRecord : newRecords) {
            if (originalRecordsMap.containsKey(newRecord.getCloneSourceId())) {
                YourObject__c originalRecord = originalRecordsMap.get(newRecord.getCloneSourceId());

                if (originalRecord.Status__c == 'Complete') {
                    newRecord.addError('A Record with a Status of "Complete" cannot be cloned.');
                }
            }
        }
    }
}
