@istest
public with sharing class TestCampaignUpdateBatchClass {
    @TestSetup
    public static void makeData(){
        List<Campaign> cmpList=new List<Campaign>();

        for (Integer i = 0; i < 1000; i++) {
            Campaign nc=new Campaign();
            nc.Name='test'+i;
            nc.EndDate=date.today().addDays(-1);
            nc.Target_Donation_Amount__c=1000;
            nc.Achieved_Donation_Amount__c=500;
            cmpList.add(nc);
        }
        insert cmpList;
    }
    @istest 
    public static void testBatch() {
       
        test.startTest();
        CampaignUpdateBatchClass cb=new CampaignUpdateBatchClass();
        Database.executeBatch(cb,1000);
        test.stopTest();

        List<Campaign> lc=[select id, name, status from campaign where status='Expired'];
        Assert.areEqual(1000, lc.size());
        
    }
  
}