package obliczenia;

public class Przeciwna extends Oper1
{
    public Przeciwna(Wyrazenie w)
    {
        super(w);
    }

    @Override
    public String toString() 
    {
        return String.format("-%s", w.toString());
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Przeciwna))
            return false;
        return ((Przeciwna) obj).w.equals(this.w);
    }

    @Override
    public double oblicz()
    {
        return -w.oblicz();
    }
}
