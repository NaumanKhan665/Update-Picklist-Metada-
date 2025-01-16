public class ToolingAPIExample implements Queueable, Database.AllowsCallouts {
 
        string picklistValues;
     //public  void execute(String picklistValues) {
     
     
    public ToolingAPIExample(String picklistValue){
        this.picklistValues=picklistValue;
        
    }
    
    public  void execute(QueueableContext QContext){
         
         
        String sessionId = UserInfo.getSessionId();

        
        List<PicklistEntry> entries = Account.PickList__c.getDescribe().getPicklistValues();
   
        List<Map<String, Object>> updatedValues = new List<Map<String, Object>>();
        
        
            for (PicklistEntry existingValue : entries) {
                    Map<String, Object> updatedValue = new Map<String, Object>();
                    updatedValue.put('label', existingValue.getLabel());
                    updatedValue.put('valueName', existingValue.getValue());
                    updatedValue.put('isActive', true); 
                    updatedValues.add(updatedValue);
                }
        
         Map<String, Object> newPicklistValue = new Map<String, Object>();
                newPicklistValue.put('label', picklistValues);
                newPicklistValue.put('valueName', picklistValues);
                newPicklistValue.put('isActive', true); // New value should be active
                updatedValues.add(newPicklistValue);
        
        
        
         Map<String, Object> updatedValueSetDefinition = new Map<String, Object>();
                updatedValueSetDefinition.put('value', updatedValues);
       
String endpoint2 = URL.getOrgDomainUrl().toExternalForm() + '/services/data/v50.0/tooling/sobjects/CustomField/00NJ2000003HfBr';

          String jsonString = '{' +
    '"Metadata": {' +
        '"businessOwnerGroup": null,' +
        '"businessOwnerUser": null,' +
        '"businessStatus": null,' +
        '"caseSensitive": null,' +
        '"complianceGroup": null,' +
        '"customDataType": null,' +
        '"defaultValue": null,' +
        '"deleteConstraint": null,' +
        '"deprecated": null,' +
        '"description": null,' +
        '"displayFormat": null,' +
        '"displayLocationInDecimal": null,' +
        '"encryptionScheme": null,' +
        '"escapeMarkup": null,' +
        '"externalDeveloperName": null,' +
        '"externalId": false,' +
        '"formula": null,' +
        '"formulaTreatBlanksAs": null,' +
        '"inlineHelpText": null,' +
        '"isAIPredictionField": null,' +
        '"isConvertLeadDisabled": null,' +
        '"isFilteringDisabled": null,' +
        '"isNameField": null,' +
        '"isSortingDisabled": null,' +
        '"label": "Custom Picklist",' +
        '"length": null,' +
        '"lookupFilter": null,' +
        '"maskChar": null,' +
        '"maskType": null,' +
        '"metadataRelationshipControllingField": null,' +
        '"populateExistingRows": null,' +
        '"precision": null,' +
        '"readOnlyProxy": null,' +
        '"referenceTargetField": null,' +
        '"referenceTo": null,' +
        '"relationshipLabel": null,' +
        '"relationshipName": null,' +
        '"relationshipOrder": null,' +
        '"reparentableMasterDetail": null,' +
        '"required": false,' +
        '"restrictedAdminField": null,' +
        '"scale": null,' +
        '"securityClassification": null,' +
        '"startingNumber": null,' +
        '"stripMarkup": null,' +
        '"summarizedField": null,' +
        '"summaryFilterItems": null,' +
        '"summaryForeignKey": null,' +
        '"summaryOperation": null,' +
        '"trackFeedHistory": false,' +
        '"trackHistory": false,' +
        '"trackTrending": false,' +
        '"translateData": null,' +
        '"type": "Picklist",' +
        '"unique": null,' +
        '"urls": null,' +
        '"valueSet": {' +
            '"controllingField": null,' +
            '"restricted": null,' +
            '"valueSetDefinition":' + JSON.serialize(updatedValueSetDefinition)+',' +
            '"valueSetName": null,' +
            '"valueSettings": []' +
        '},' +
        '"visibleLines": null,' +
        '"writeRequiresMasterRead": null' +
    '}' +
'}';

            
     

        
          HttpRequest req1 = new HttpRequest();
        req1.setEndpoint(endpoint2);
        req1.setMethod('PATCH');
        req1.setHeader('Content-Type', 'application/json');

        req1.setHeader('Authorization', 'Bearer ' + sessionId);

         req1.setBody(jsonString);

        Http http1 = new Http();
        HttpResponse res1 = http1.send(req1);

        // Check if the response status is successful
        if (res1.getStatusCode() == 204) {
            System.debug('Custom Field created successfully: ' + res1.getBody());
        } else {
            System.debug('Error creating field: ' + res1.getBody());
        }
     
          
    }
}