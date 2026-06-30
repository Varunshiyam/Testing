@isTest
public class testcase1 {
    @isTest static void test1(){
        integer result1=Test_Class_1.sub(10,2);
        system.assertEquals(8,result1);
    }
    
    @isTest static void test2(){
        integer result2=Test_Class_1.sub(4, 1);
        system.assertEquals(3,result2);
    }
    

}