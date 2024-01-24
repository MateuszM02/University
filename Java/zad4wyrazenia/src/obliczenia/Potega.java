package obliczenia;

public class Potega extends Fun2 
{
    public Potega(Wyrazenie w1, Wyrazenie w2) 
    {
        super(w1, w2, Priorytet.Potega);
    }

    @Override
    public String toString() 
    {
        return String.format("%s^%s", w, w2);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Potega))
            return false;
        return ((Potega) obj).w.equals(this.w) && ((Potega) obj).w2.equals(this.w2);
    }

    @Override
    public double oblicz() 
    {
        return Math.pow(w.oblicz(), w2.oblicz());
    }
}
