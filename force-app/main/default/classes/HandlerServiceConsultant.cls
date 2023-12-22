public with sharing class HandlerServiceConsultant {

    public static void validateServiceConsultant (List<Service_Consultant__c> scTriggerNew){
        set<Id> serviceIds = new set<Id> ();
        set<Id> consultantIds = new set<Id>();

        //This is a junction object and we are trying to prevent duplicate data.
          Map<String, Service_Consultant__c> scMap = new Map<String, Service_Consultant__c>();

         //Create a string by merging the service and consultant Ids from triggering record
          for(Service_Consultant__c eachSC : scTriggerNew ) {
              serviceIds.add(eachSC.Service__c);
              consultantIds.add(eachSC.Consultant__c);
  
              string myKey = string.valueOf(eachSC.Service__c) + string.valueOf(eachSC.Consultant__c);
              scMap.put(myKey,eachSC);
              
          }
          System.debug('serviceIds: ' + serviceIds);
          System.debug('consultantIds: ' + consultantIds);

           //Check the previous records if the string matches with the new one (compare strings created by merging service and consultant Ids )
  
          for(Service_Consultant__c eachSC : [SELECT Id, Service__c, Consultant__c 
                                              FROM Service_Consultant__c 
                                              WHERE Service__c IN: serviceIds 
                                              AND Consultant__c IN: consultantIds]){
              string systemKey = string.valueOf(eachSC.Service__c) + string.valueOf(eachSC.Consultant__c);
              Service_Consultant__c toBeFailed = scMap.get(systemKey);

               //Then throw an error if record is duplicate
  
              if(toBeFailed != null){
                
                  toBeFailed.addError('This is a duplicate record of ' + string.valueOf(eachSC.Id));
              }
          }   
        }
 
}