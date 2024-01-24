package obliczenia;

public class Exp extends Fun1 
{
    public Exp(Wyrazenie w) 
    {
        super(w);
    }

    @Override
    public String toString() 
    {
        return String.format("e^(%s)", w);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Exp))
            return false;
        return ((Exp) obj).w.equals(this.w);
    }

    @Override
    public double oblicz() 
    {
        return Math.exp(w.oblicz());
    }  
}
