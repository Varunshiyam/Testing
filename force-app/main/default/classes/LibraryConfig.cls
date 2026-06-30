public class LibraryConfig {

    public final Integer MAX_DAYS;
    public final Decimal DAILY_FINE;

    // Constructor
    public LibraryConfig(Integer days, Decimal fine) {
        this.MAX_DAYS = days;
        this.DAILY_FINE = fine;
    }
    
    

    public void showConfig() {
        System.debug('Max Days: ' + MAX_DAYS);
        System.debug('Daily Fine: ' + DAILY_FINE);
    }
}