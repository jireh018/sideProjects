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
        List<Result> results = new List<Result>();
        Map<Id, Id> quoteOrderIdsMap = preparequoteOrderIdsMap(idList, results); 
        /*
        for(ObjectIds ids: idList){
            if(ids.quoteId != null && ids.orderId != null){
                //quote and order Ids are provided
                quoteOrderIdsMap.put(ids.quoteId, ids.orderId);
            }else{
                //no quote and order Ids found!
                results.add(new Result('No quote and order Ids found!', false));
            }
        }
*/
        
        try{
            List<ContentDocumentLink> quotePDFs = retrieveQuotePDFs(quoteOrderIdsMap.keySet());
            List<ContentDocumentLink> orderPDFs = new List<ContentDocumentLink>();
            
            for(ContentDocumentLink quotePdf: quotePDFs){
                Id quoteId = quotePdf.LinkedEntityId;
                Id orderId = quoteOrderIdsMap.get(quoteId);//quotePdf.LinkedEntityId captures quoteIds for each pdf 
                //and we get use quoteId to get related or associated value which is orderId
                if(orderId != null){
                    ContentDocumentLink oPdf = new ContentDocumentLink(
                        ContentDocumentId = quotePDF.ContentDocumentId,
                        LinkedEntityId = orderId,
                        ShareType = 'V',
                        Visibility = 'AllUsers'
                    );
                    orderPDFs.add(oPdf);
                }else{
                    //no order Ids found! for given quote Id
                    results.add(new Result('No order Ids found for quote Id: ' + quoteId, false));
                }
            }

            if(!orderPDFs.isEmpty()){
                insert orderPDFs;
                for(Id orderId : quoteOrderIdsMap.values()){
                    results.add(new Result('Pdfs attached to Order Id: ' + orderId, true));
                }
            }else{
                results.add(new Result('No Pdfs attached!', false));
            }
        }catch(Exception ex){
            System.debug('Error while attaching quote Pdfs to order.');
            results.add(new Result('Error while attaching quote Pdfs to order.', false));
        }
        
        return results;
    }
    
    private static Map<Id, Id> preparequoteOrderIdsMap(List<ObjectIds> idList, List<Result> results){
        Map<Id, Id> quoteOrderIdsMap = new Map<Id, Id>();
        
        for(ObjectIds ids: idList){
            if(ids.quoteId != null && ids.orderId != null){
                //quote and order Ids are provided
                quoteOrderIdsMap.put(ids.quoteId, ids.orderId);
            }else{
                //no quote and order Ids found!
                results.add(new Result('No quote and/order Ids found!', false));
            }
        }
        return quoteOrderIdsMap;
    }
    
    private static List<ContentDocumentLink> retrieveQuotePDFs(Set<Id> quoteIds){
        return [SELECT ContentDocumentId, LinkedEntityId 
                FROM ContentDocumentLink 
                WHERE LinkedEntityId =: quoteIds
               ];
    }
    
    private static List<ContentDocumentLink> prepareOrderPDFs(List<ContentDocumentLink> quotePDFs, List<Result> results){
        return null;
    }
}