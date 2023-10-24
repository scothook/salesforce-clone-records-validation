@isTest
private class CloneCheckHandlerTest {

    static testMethod void testCloneCheckHandlerNegative() {
        // Create an original record with Status set to "Complete"
        YourObject__c originalRecord = new YourObject__c(
            Status__c = 'Complete',
            Name = 'Clone Test 1'
        );
        insert originalRecord;

        // Attempt to create a clone of the original record
        try {
            Test.startTest();
            YourObject__c cloneRecord = originalRecord.clone();
            insert cloneRecord;
            Test.stopTest();
        } catch (DMLException e) {
            System.assert(e.getMessage().contains('A Record with a Status of "Complete" cannot be cloned.'), 'message=' + e.getMessage());
        }

        // Verify that the clone was not created
        List<YourObject__c> clonedRecords = [SELECT Id FROM YourObject__c WHERE Subject__c = 'Clone Test 1'];
        System.assertEquals(1, clonedRecords.size(), 'Clone should not have been created.'); // '=1' because original record still exists
    }
    
    static testMethod void testCloneCheckHandlerPositive() {
        YourObject__c originalRecord = new YourObject__c(
            Status__c = 'Not Complete',
            Name = 'Clone Test 2'
        );
        insert originalRecord;
        
        Test.startTest();
        YourObject__c cloneRecord = originalRecord.clone();
        insert cloneRecord;
        Test.stopTest();
        
        // Verify that the clone was created
        List<YourObject__c> clonedRecords = [SELECT Id FROM YourObject__c WHERE Subject__c = 'Clone Test 2'];
        System.assertEquals(2, clonedRecords.size(), 'Clone should not have been created.'); // '=2' because original and clone exist
    }
}
