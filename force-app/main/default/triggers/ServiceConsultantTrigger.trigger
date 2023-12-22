trigger ServiceConsultantTrigger on Service_Consultant__c (before insert, before update) {

    if (trigger.isBefore) {
      
        if (trigger.isInsert || trigger.isUpdate) {
          HandlerServiceConsultant.validateServiceConsultant(trigger.new);
        }
      }

}