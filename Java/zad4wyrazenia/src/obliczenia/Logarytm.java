package obliczenia;

public class Logarytm extends Fun2 
{
    public Logarytm(Wyrazenie w1, Wyrazenie w2) 
    {
        super(w1, w2, Priorytet.Potega);
    }

    @Override
    public String toString() 
    {
        return String.format("log_%s(%s)", w, w2);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Logarytm))
            return false;
        return ((Logarytm) obj).w.equals(this.w) && ((Logarytm) obj).w2.equals(this.w2);
    }

    @Override
    public double oblicz() 
    {
        double mianownik = Math.log(w2.oblicz());
        if (mianownik == 0)
            throw new IllegalArgumentException(Dziel.divByZeroError);
        return Math.log(w.oblicz()) / mianownik;
    }
}
