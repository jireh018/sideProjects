@isTest
public class QuoteOrderPDFHandlerTest {
    @testSetup
    static void loadTestData(){
        //1. Load
        //insert Account of type Engineering
        Account accountEngineering = new Account(Name='Test Account', Industry='Engineering');
        insert accountEngineering;
        //insert Quote
        Quote newQuote = new Quote(Name='Test Quote', Account__c=accountEngineering.Id);
        insert newQuote;
        //insert Order
        Date todayDate = Date.today();
        Order newOrder = new Order(AccountId=accountEngineering.Id, EffectiveDate=todayDate, Status='Draft');
        insert newOrder;
        Order newOrder2 = new Order(AccountId=accountEngineering.Id, EffectiveDate=todayDate + 1, Status='Draft');
        insert newOrder2;
    }
    
    @isTest
    static void testattachQuotePDFsToRelatedOrderWithPDFs(){
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
        Id insertedQuoteId = [SELECT Id FROM Quote WHERE Name = 'Test Quote'].Id;
        Id insertedOrderIdWithPDF = [SELECT Id FROM Order WHERE EffectiveDate=: Date.today() AND Status='Draft'].Id;
        Id insertedOrderIdWithNoPDF = [SELECT Id FROM Order WHERE EffectiveDate=: Date.today() + 1 AND Status='Draft'].Id;
        // Then, create a ContentDocumentLink to link it to the Quote
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = contentDocumentId,
            LinkedEntityId = insertedQuoteId,
            ShareType = 'V', // V for View access
            Visibility = 'AllUsers'
        );
        insert cdl;
        
        QuoteOrderPDFHandler.ObjectIds ids = new QuoteOrderPDFHandler.ObjectIds();
        ids.quoteId = insertedQuoteId;
        ids.orderId = insertedOrderIdWithPDF;
        List<QuoteOrderPDFHandler.ObjectIds> idList = new List<QuoteOrderPDFHandler.ObjectIds>();
        idList.add(ids);
        //2. Test
        Test.startTest();
        //call the QuoteOrderPDFHandler class
        List<QuoteOrderPDFHandler.Result> results = QuoteOrderPDFHandler.attachQuotePDFsToRelatedOrder(idList);
        Test.stopTest();
        //3. Assert
        //assert to check if we have any pdf in order record
        System.assertEquals(1, results.size(), 'There should only be 1 pdf inserted');
        // Verify that the PDF is now attached to the Order
        List<ContentDocumentLink> orderPDFs = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :insertedOrderIdWithPDF];
        System.assertEquals(1, orderPDFs.size(), 'Should have one PDF attached to the Order');
        // Verify that the PDF is not attached to the Order
        List<ContentDocumentLink> order2PDFs = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :insertedOrderIdWithNoPDF];
        System.assertEquals(0, order2PDFs.size(), 'Should have no PDF attached to the Order');
    }
    
    @isTest
    static void testattachQuotePDFsToRelatedOrderWithNoOrder(){
        Id insertedQuoteId = [SELECT Id FROM Quote WHERE Name = 'Test Quote'].Id;
        QuoteOrderPDFHandler.ObjectIds ids = new QuoteOrderPDFHandler.ObjectIds();
        ids.quoteId = insertedQuoteId;
        //ids.orderId = insertedOrderIdWithPDF;
        List<QuoteOrderPDFHandler.ObjectIds> idList = new List<QuoteOrderPDFHandler.ObjectIds>();
        idList.add(ids);
        
        Test.startTest();
        //call the QuoteOrderPDFHandler class
        List<QuoteOrderPDFHandler.Result> results = QuoteOrderPDFHandler.attachQuotePDFsToRelatedOrder(idList);
        Test.stopTest();
        //3. Assert
        //assert to check if we have any pdf in order record
        System.assertNotEquals(0, results.size(), 'There should be 0 pdf inserted');
    }
}