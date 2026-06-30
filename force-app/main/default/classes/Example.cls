public class Example {
    String names;

    public Example(){
        List <Account> acclist= [SELECT Name, Id FROM Account LIMIT 2];
        names=acclist[1].Name;
        
    }
    public String getname(){
        return(names);
    }

}