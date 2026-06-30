trigger eptrigger on ELECTRONICPRODUCT__c(before insert, before update)
	{

	for(ELECTRONICPRODUCT__c a: Trigger.new){

		if(a.check_me__c  ==True)
		{
			A.Price__c=2500;
		}
}
}