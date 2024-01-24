package obliczenia;

public class Odwrotna extends Oper1
{
    public Odwrotna(Wyrazenie w)
    {
        super(w);
    }

    @Override
    public String toString() 
    {
        return String.format("1/%s", w.toString());
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Odwrotna))
            return false;
        return ((Odwrotna) obj).w.equals(this.w);
    }

    @Override
    public double oblicz()
    {
        double wynik = w.oblicz();
        if (wynik == 0)
            throw new IllegalArgumentException(Dziel.divByZeroError);
        return 1 / wynik;
    }
}
