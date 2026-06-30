@isTest
public class TestVerifyDate {
    @isTest
    static void testDateWithin30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(10); // within 30 days
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, result, 'Should return date2 if within 30 days');
    }

    @isTest
    static void testDateBeforeDate1() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(-5); // in the past
        Date result = VerifyDate.CheckDates(date1, date2);

        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        Date expected = Date.newInstance(date1.year(), date1.month(), totalDays);

        System.assertEquals(expected, result, 'Should return end of month if date2 is in the past');
    }

    @isTest
    static void testDateBeyond30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(40); // beyond 30 days
        Date result = VerifyDate.CheckDates(date1, date2);

        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        Date expected = Date.newInstance(date1.year(), date1.month(), totalDays);

        System.assertEquals(expected, result, 'Should return end of month if date2 is beyond 30 days');
    }
}