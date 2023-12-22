public with sharing class CampaignUpdateScheduler implements Schedulable{
    public void execute(SchedulableContext Bc){

        CampaignUpdateBatchClass ab=new CampaignUpdateBatchClass();
        id batchid=database.executeBatch(ab,200);
    }
}