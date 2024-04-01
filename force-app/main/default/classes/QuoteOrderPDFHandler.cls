public class QuoteOrderPDFHandler {
    public class ObjectIds{
        @Invocablevariable
        public Id quoteId;
        
        @Invocablevariable
        public Id orderId;
    }
    
    public class Result{
        @Invocablevariable
        public String resultMessage;
        
        @Invocablevariable
        public Boolean isSuccess;
        
        public Result(String message, Boolean isSuccess){
            this.resultMessage = message;
            this.isSuccess = isSuccess;
        }
    }
    
    @InvocableMethod(label='Attach Quote PDF to Order' description='Attaches related Quote PDFs to the specified generated Order.')
    public static List<Result> attachQuotePDFsToRelatedOrder(List<ObjectIds> idList){
        List<Result> result = new List<Result>();
        
        for(ObjectIds ids: idList){
            List<ContentDocumentLink> quotePDFs = [SELECT ContentDocumentId, LinkedEntityId 
                FROM ContentDocumentLink 
                WHERE LinkedEntityId =: ids.quoteId];
            List<ContentDocumentLink> orderPDFs = new List<ContentDocumentLink>();
            
            for(ContentDocumentLink quotePdf: quotePDFs){
                ContentDocumentLink oPdf = new ContentDocumentLink(
                    ContentDocumentId = quotePDF.ContentDocumentId,
                    LinkedEntityId = ids.orderId,
                    ShareType = 'V',
                    Visibility = 'AllUsers'
                );
                orderPDFs.add(oPdf);
            }
            insert orderPDFs;
        }
        
        return null;
    }

}