package code;
// kompilacja: javac code/*.java
// uruchomienie: java code.zad2 [arg1] [arg2] ...

public class zad2 
{
    public static void wypiszCzynniki(long[] czynniki)
    {
        int ilosc = czynniki.length;
        System.out.print(czynniki[0]);
        for (int j = 0; j < ilosc-1; j++) 
        {
            if (czynniki[j] == 0)
                break;
            System.out.print(" * " + czynniki[j]);
        }
    }
    
    public static void main(String[] args) throws Exception 
    {
        if (args.length == 0)
        {
            System.err.println("Należy podać przynajmniej 1 liczbę całkowitą aby otrzymać listę jej dzielników!");
        }
        for (String s : args)
        {
            long x = Long.parseLong(s);
            System.out.print(x + " = ");
            long[] czynniki = LiczbyPierwsze.naCzynnikiPierwsze(x);
            wypiszCzynniki(czynniki);
        }
    }
}