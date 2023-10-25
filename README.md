# salesforce-clone-records-validation
An Apex validation rule that prevents a record from being cloned depending on a status field.

This arose from the need to prevent records with a certain status from being cloned. Validation Rules and Record-Triggered Flows were unable to reference the original record so an Apex Class was the best solution.

Include the following in the Before Insert Apex Trigger for the target object.
```
CloneCheckHandler.validateStatus(Trigger.new);
```
