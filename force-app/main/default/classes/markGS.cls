public class markGS {

    public integer mark;
    public void setmark(integer mark){
        this.mark=mark;
    }
    public void getmark(){

        if (mark >= 50){
    system.debug('pass');
}
else {
    system.debug('Fail');
}
    }
}