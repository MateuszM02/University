package obliczenia;

public class Odejmij extends Oper2
{
    public Odejmij(Wyrazenie w1, Wyrazenie w2)
    {
        super(w1, w2, Priorytet.Dodawanie);
    }

    @Override
    public String toString() 
    {
        return String.format("(%s - %s)", w.toString(), w2.toString());
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Odejmij))
            return false;
        return ((Odejmij) obj).w.equals(this.w) && ((Odejmij) obj).w2.equals(this.w2);
    }

    @Override
    public double oblicz()
    {
        return w.oblicz() - w2.oblicz();
    }     
}
