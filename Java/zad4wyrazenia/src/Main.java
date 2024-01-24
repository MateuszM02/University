import obliczenia.*;

public class Main 
{
    static void test1()
    {
        //7 + 5 * 3 - 1 => [7 + (5 * 3)] - 1 => 21
        Wyrazenie w = new Odejmij(
                            new Dodaj(
                                new Liczba(7), 
                                new Mnoz(
                                    new Liczba(5),
                                    new Liczba(3)
                                )), 
                            new Liczba(1));
        
        System.out.println(w.toString());
        //System.out.println(w.oblicz());
        //System.out.println();
    }

    static void test2()
    {
        //~ (2 - x) * e => ~ [(2 - x) * e] => -1.038
        Wyrazenie w = new Przeciwna(
                            new Mnoz(
                                new Odejmij(
                                    new Liczba(2),
                                    new Zmienna("x")),
                                new E()));
        
        System.out.println(w.toString());
        //System.out.println(w.oblicz());
        //System.out.println();
    }

    static void test3()
    {
        //(3 * π - 1) / (x + 5) => 1.273
        Wyrazenie w = new Dziel(
                        new Odejmij(
                            new Mnoz(
                                new Liczba(3), 
                                new PI()), 
                            new Liczba(1)),
                        new Dodaj(
                            new Zmienna("x"), 
                            new Liczba(5)));
        
        System.out.println(w.toString());
        //System.out.println(w.oblicz());
        //System.out.println();
    }

    static void test4()
    {
        //sin((x + 13) * π / (1 - x)) => 0.886
        Wyrazenie w = new Sinus(
                        new Dziel(
                            new Mnoz(
                                new Dodaj(
                                    new Zmienna("x"), 
                                    new Liczba(13)),
                                new PI()),
                            new Odejmij(
                                new Liczba(1),
                                new Zmienna("x")
                        )));
        
        System.out.println(w.toString());
        //System.out.println(w.oblicz());
        //System.out.println();
    }

    static void test5()
    {
        //exp(5) + x * log(e, x) => 151.776
        Wyrazenie w = new Dodaj(
                        new Potega(
                            new E(),
                            new Liczba(5)),
                        new Mnoz(
                            new Zmienna("x"),
                            new Logarytm(
                                new E(),
                                new Zmienna("x")
                        )));
        
        System.out.println(w.toString());
        //System.out.println(w.oblicz());
        //System.out.println();
    }

    public static void main(String[] args) 
    {
        Zmienna.dodajZmienna("x", 1.618);
        
        test1();
        test2();
        test3();
        test4();
        test5();
    }
}