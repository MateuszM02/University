package obliczenia;

public class Dziel extends Oper2
{
    public static final String divByZeroError = "Nie wolno dzielic przez zero";

    public Dziel(Wyrazenie w1, Wyrazenie w2)
    {
        super(w1, w2, Priorytet.Mnozenie);
    }

    @Override
    public String toString() 
    {
        return String.format("%s / %s", w.toString(), w2.toString());
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Dziel))
            return false;
        return ((Dziel) obj).w.equals(this.w) && ((Dziel) obj).w2.equals(this.w2);
    }

    @Override
    public double oblicz()
    {
        double mianownik = w2.oblicz();
        if (mianownik == 0)
            throw new IllegalArgumentException(divByZeroError);
        return w.oblicz() / mianownik;
    }     
}
