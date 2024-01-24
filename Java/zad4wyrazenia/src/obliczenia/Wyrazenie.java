package obliczenia;

public abstract class Wyrazenie implements Obliczalny
{
    /** metoda sumująca wyrażenia */
    public static int suma(Wyrazenie... wyr) 
    { 
        int suma = 0;
        for (Wyrazenie w : wyr) 
        {
            suma += w.oblicz();
        };
        return suma;
    }

    /** metoda mnożąca wyrażenia */
    public static int iloczyn(Wyrazenie... wyr) 
    { 
        int iloczyn = 1;
        for (Wyrazenie w : wyr) 
        {
            iloczyn *= w.oblicz();
        };
        return iloczyn;
    }
}
