@isTest
public class multestcases {
    @isTest static void test1(){
        Integer Result1=Testcode.mul(4, 5);
        System.assertEquals(20,Result1);
    }
    @isTest static void test2(){
        Integer Result2=Testcode.mul(0, 2);
        System.AssertEquals(0,Result2);
    }
    

}