package obliczenia;

public class Sinus extends Fun1 
{
    public Sinus(Wyrazenie w) 
    {
        super(w);
    }

    @Override
    public String toString() 
    {
        return String.format("sin(%s)", w);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Sinus))
            return false;
        return ((Sinus) obj).w.equals(this.w);
    }

    @Override
    public double oblicz() 
    {
        return Math.sin(w.oblicz());
    }
}
