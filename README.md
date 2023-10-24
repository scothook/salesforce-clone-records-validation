# salesforce-clone-records-validation
An Apex validation rule that prevents a record from being cloned depending on a status field.

Include the following in the Before Insert Apex Trigger for the target object.
```
CloneCheckHandler.validateStatus(Trigger.new);
```
