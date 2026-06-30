public class EmployeePay {
    Public static void salary(integer hourwage,integer hours,String name){
       integer basesalary;
       integer bonusadded;
       integer netsalary;
       integer totalwage;
       integer taxdeductedamt;
       integer taxdeducted;


           if(hours>160){
            integer overhours=hours-160;
            integer normalhours=160;
            integer normalhourswage=hourwage*160;
            Decimal overtimewage=overhours*(1.5*hourwage);
			 totalwage= (Integer)overtimewage+normalhourswage;
             taxdeductedamt=totalwage*10/100;
             taxdeducted=totalwage-taxdeductedamt;

            basesalary=160*hourwage;  
               System.debug('Employee Name:'+name);
               System.debug('Base Salary:'+basesalary);
               System.debug('OverTime Pay:'+overtimewage);
               System.debug('Gross Salary:'+totalwage);
               System.debug('Tax Deducted:'+taxdeductedamt);     
               if(basesalary>50000){
                 netsalary =taxdeducted+2000;
               System.debug('Bonus Added: 2,000');
           }
               else{
                   netsalary=taxdeducted;
                   System.debug('Bonus Added:0');
               }
               System.debug('Net Salary:'+netsalary);


               
    }
        
        
        
        else{
            totalwage= hourwage*hours;
            taxdeductedamt=totalwage*(10/100);
            taxdeducted=totalwage-taxdeductedamt;
               System.debug('Employee Name:'+name);
               System.debug('Base Salary:'+totalwage);
               System.debug('OverTime Pay: 0');
               System.debug('Gross Salary:'+totalwage);
               System.debug('Tax Deducted:'+taxdeductedamt);
            
            if(totalwage>50000){
             netsalary=taxdeducted+2000;
             System.debug('Bonus Added: 2,000');
            }
            else{
                netsalary=taxdeducted;
             System.debug('Bonus Added:0');
            }
            System.debug('Net Salary:'+netsalary);
            
            
        }
        

    }
}