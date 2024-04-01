public class ConvertTextToQuoteLineItems {
    
    public class InputRequest{
        @Invocablevariable
        public String inputText;
    }
    
    public class Result{
        @Invocablevariable
        public String productCode;
        
        @Invocablevariable
        public String description;
        
        @Invocablevariable
        public Integer quantity;
        
        @Invocablevariable
        public Double unitPrice;
    }
    
    @InvocableMethod(label='Convert Products Text to Quote Line Items' description='Convert Products Text to Quote Line Items.')
    public static List<Result> convertToQuoteLineItems(List<InputRequest> inputRequests){
        List<Result> results = new List<Result>();
        
        if(!inputRequests.isEmpty()){
            for(InputRequest singleIR: inputRequests){
                String[] fields = singleIR.inputText?.split('\t');
                Result result = new Result();
                
                if(fields.size() >= 5){
                    result.productCode = fields[0];
                    result.description = fields[2];
                    result.quantity = Integer.valueOf(fields[3]);
                    result.unitPrice = Decimal.valueOf(fields[4]?.replace('$', '').replace(' ', '').replace(',', '.'));
                    
                    results.add(result);
                }
                
            }
        }
        
        return results;
    }
}