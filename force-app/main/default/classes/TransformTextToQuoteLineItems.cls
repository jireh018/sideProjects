public class TransformTextToQuoteLineItems {
    public class InputRequest{
        @Invocablevariable
        public String inputText;
        
        @Invocablevariable
        public Id quoteId;
    }
    
    public class QuoteLineItem{
        public Id quoteId;
        public String productCode;
        public String description;
        public Integer quantity;
        public Double unitPrice;
    }
    
    public class Result{
        @Invocablevariable
        public String message;
        
        @Invocablevariable
        public Boolean isSuccess;
        
        public Result(String message, Boolean isSuccess){
            this.message = message;
            this.isSuccess = isSuccess;
        }
    }
    
    @InvocableMethod(label='Transform Products Text to Quote Line Items And Insert' description='Transform Products Text to Quote Line Items and Insert them.')
    public static void transformAndInsertQuoteLineItems(List<InputRequest> inputRequests){
        List<Result> results = new List<Result>();
        Map<Id, String> quoteLineItemMap = new Map<Id, String>();
        Map<Id, List<String>> quoteLineItemMapToBeInserted = new Map<Id, List<String>>();
        List<QuoteLineItem> allquoteLineItemsToBeInserted = new List<QuoteLineItem>();
        
        Integer i = 0;
        
        for(InputRequest inputRequest: inputRequests){
            quoteLineItemMap.put(inputRequest.quoteId, inputRequest.inputText);
        }
        
        for(Id quoteId : quoteLineItemMap.KeySet()){
            String[] quoteLineItemsForEachQuoteId = quoteLineItemMap.get(quoteId)?.split('\n');
            quoteLineItemMapToBeInserted.put(quoteId, quoteLineItemsForEachQuoteId);
            for(String p: quoteLineItemsForEachQuoteId){
                String[] sanitizeProduct = p.split('\t');
                QuoteLineItem qLI = new QuoteLineItem();
                qLI.quoteId = quoteId;
                qLI.productCode = sanitizeProduct[0];
                qLI.description = sanitizeProduct[2];
                qLI.quantity = Integer.valueOf(sanitizeProduct[3]);
                qLI.unitPrice = Decimal.valueOf(sanitizeProduct[4]?.replace('$', '').replace(' ', '').replace(',', '.'));
                
                allquoteLineItemsToBeInserted.add(qlI);
            }
            i++;
        }
        
        for(QuoteLineItem qLI: allquoteLineItemsToBeInserted){
            System.debug('qlI ' + qlI);
        }
    }
}