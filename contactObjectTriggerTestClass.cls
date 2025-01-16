@isTest
public class contactObjectTriggerTestClass {

    @isTest
    static void testTrigger() {
       
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact'
        );

        
        insert testContact;

        
        Contact insertedContact = [SELECT Id, LastName FROM Contact WHERE Id = :testContact.Id LIMIT 1];
        System.assertNotEquals(null, insertedContact);
        System.assertEquals('Contact', insertedContact.LastName);

       
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(204); 
        mockResponse.setBody('Custom Field updated successfully.');

       
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse));

      
        Test.startTest();


        System.enqueueJob(new ToolingAPIExample(testContact.LastName));

       
        Integer jobCount = [SELECT COUNT() FROM AsyncApexJob WHERE Status = 'Queued' AND JobType = 'Queueable' LIMIT 1];
        System.assert(jobCount > 0, 'Queueable job was not enqueued.');

        Test.stopTest();
    }

    @isTest
    static void testControllerExecute() {

        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(204);
        mockResponse.setBody('Custom Field updated successfully.');

        Test.startTest();

       
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse));

       
        ToolingAPIExample toolingAPIExample = new ToolingAPIExample('Test Picklist Value');

        toolingAPIExample.execute(null);

        Test.stopTest();

        System.debug('Test executed successfully.');
    }

    public class MockHttpResponseGenerator implements HttpCalloutMock {
        private HttpResponse mockResponse;

        public MockHttpResponseGenerator(HttpResponse response) {
            this.mockResponse = response;
        }

        public HttpResponse respond(HttpRequest req) {
            return mockResponse;
        }
    }
}