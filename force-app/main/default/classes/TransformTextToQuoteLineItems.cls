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
        String[] fields = null;
        
        for(InputRequest inputRequest: inputRequests){
            quoteLineItemMap.put(inputRequest.quoteId, inputRequest.inputText);
        }
        System.debug('quoteLineItemMap size ' + quoteLineItemMap.size());
    }
}