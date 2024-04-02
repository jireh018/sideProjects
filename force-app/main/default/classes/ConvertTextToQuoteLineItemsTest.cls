@isTest
public class ConvertTextToQuoteLineItemsTest {
    @isTest
    static void testStringConvertedIntoQuoteLineItems(){
        //Load data
        String inputText = 'BL-SPEED-HURDLES	HAIES DE VITESSE (6 PAR ENSEMBLE)	SPEED HURDLES (6 PER SET)	60	$1 980,00';
        
        ConvertTextToQuoteLineItems.InputRequest iRequest = new ConvertTextToQuoteLineItems.InputRequest();
        iRequest.inputText = inputText;
        
        List<ConvertTextToQuoteLineItems.InputRequest> request = new List
            <ConvertTextToQuoteLineItems.InputRequest>();
        request.add(iRequest);
        
        //Test
        Test.startTest();
        List<ConvertTextToQuoteLineItems.Result> resultList = ConvertTextToQuoteLineItems.convertToQuoteLineItems(request);
        Test.stopTest();
        
        //Assert
        System.assertEquals(1, resultList.size(), 'resultList should only have 1 QuoteLineItem');
        for(ConvertTextToQuoteLineItems.Result r: resultList){
            Assert.isTrue(inputText.contains(r.productCode), 'resultList.productCode should match the one in the input text');
        }
    }
    
    @isTest
    static void testBulkStringConvertedIntoQuoteLineItems(){
        //Load data
        String inputText = 'BL-SPEED-HURDLES	HAIES DE VITESSE (6 PAR ENSEMBLE)	SPEED HURDLES (6 PER SET)	60	$1 980,00\nCN-COL-BLACK	RONDELLE ENTRAÎNEMENT NOIR 6 ONCES	PRACTICE BLACK HOCKEY PUCK 6 OUNCES	100	$124,00\nGB-SLO	GREEN BISCUIT DRAPEAU OLYMPIQUE SLOVAQUIE	OLYMPIC  FLAG GREEN BISCUIT SLOVAKIA	5	$612,00';
        
        ConvertTextToQuoteLineItems.InputRequest iRequest = new ConvertTextToQuoteLineItems.InputRequest();
        iRequest.inputText = inputText;
        
        List<ConvertTextToQuoteLineItems.InputRequest> request = new List
            <ConvertTextToQuoteLineItems.InputRequest>();
        request.add(iRequest);
        
        //Test
        Test.startTest();
        List<ConvertTextToQuoteLineItems.Result> resultList = ConvertTextToQuoteLineItems.convertToQuoteLineItems(request);
        Test.stopTest();
        
        //Assert
        System.assertEquals(3, resultList.size(), 'resultList should have 3 QuoteLineItems');
    }

}