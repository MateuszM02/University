package obliczenia;

import struktury.Para;
import struktury.ZbiorTablicowy;

public class Zmienna extends Operand
{
    String zmienna;
    static int maxIloscZmiennych = 100;
    static ZbiorTablicowy zbiorZmiennych = new ZbiorTablicowy(maxIloscZmiennych);

    public Zmienna(String zmienna) 
    {
        this.zmienna = zmienna;
        if (zbiorZmiennych.szukaj(zmienna) == null) // zmienna niezainicjalizowana
            zbiorZmiennych.wstaw(new Para(zmienna, 0)); // z wartoscia domyslna 0
    }

    public static void dodajZmienna(String zmienna, double wartosc)
    {
        zbiorZmiennych.wstaw(new Para(zmienna, wartosc));
    }

    @Override
    public String toString() 
    {
        return zmienna;
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Zmienna))
            return false;
        return this.zmienna == ((Zmienna)obj).zmienna;
    }

    @Override
    public double oblicz() 
    {
        return zbiorZmiennych.szukaj(this.zmienna).getWartosc();
    }
}