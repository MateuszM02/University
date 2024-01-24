package obliczenia;

public class Mnoz extends Oper2
{
    public Mnoz(Wyrazenie w1, Wyrazenie w2)
    {
        super(w1, w2, Priorytet.Mnozenie);
    }

    @Override
    public String toString() 
    {
        return String.format("%s * %s", w.toString(), w2.toString());
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Mnoz))
            return false;
        return ((Mnoz) obj).w.equals(this.w) && ((Mnoz) obj).w2.equals(this.w2);
    }

    @Override
    public double oblicz()
    {
        return w.oblicz() * w2.oblicz();
    }     
}
