@isTest
public class QuoteOrderPDFHandlerTest {
    @isTest
    static void testattachQuotePDFsToRelatedOrderWithPDFs(){
        //1. Load
        //fetch account of type engineering
        Account accountEngineering = [SELECT Id FROM Account WHERE Industry = 'Engineering'];
        //insert Quote
        Quote newQuote = new Quote(Name='Test Quote', Account__c=accountEngineering.Id);
        insert newQuote;
        //insert Order
        Date todayDate = Date.today();
        Order newOrder = new Order(AccountId=accountEngineering.Id, EffectiveDate=todayDate);
        insert newOrder;
        //create and insert PDF
        ContentVersion cvPDF = new ContentVersion(
            Title='Test PDF',
            PathOnClient = 'TestPDF.pdf',
            VersionData = Blob.valueOf('Test PDF Content'),
            IsMajorVersion = true
        );
        insert cvPDF;
        //link it to Quote
        Id contentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cvPDF.Id].ContentDocumentId;

        // Then, create a ContentDocumentLink to link it to the Quote
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = contentDocumentId,
            LinkedEntityId = newQuote.Id,
            ShareType = 'V', // V for View access
            Visibility = 'AllUsers'
        );
        insert cdl;
        //2. Test
        //call the QuoteOrderPDFHandler class
        //3. Assert
        //assert to check if we have any pdf in order record
    }
    
    @isTest
    static void testattachQuotePDFsToRelatedOrderWithNoPDFs(){
        //1. Load
        //insert Quote
        //insert Order
        //create PDF
        //link it to Quote
        //2. Test
        //call the QuoteOrderPDFHandler class
        //3. Assert
        //assert to confirm we dont have any pdf in order record
    }
}