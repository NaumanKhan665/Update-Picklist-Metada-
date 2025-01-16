trigger contactObjectTrigger on Contact (after insert, after update) {
    List<Contact> contactsToUpdate = new List<Contact>();
    
    for (Contact  customObj : Trigger.new) {
        
        ToolingAPIExample updatePicklistValues= new ToolingAPIExample(customObj.LastName);
                system.enqueueJob(updatePicklistValues);
   
        }
    }

    
   
//  ToolingAPIExample.fetchPicklistValues(customObj.LastName);