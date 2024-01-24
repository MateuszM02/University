package obliczenia;

public class Ln extends Fun1 
{
    public Ln(Wyrazenie w) 
    {
        super(w);
    }

    @Override
    public String toString() 
    {
        return String.format("ln(%s)", w);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Ln))
            return false;
        return ((Ln) obj).w.equals(this.w);
    }

    @Override
    public double oblicz() 
    {
        return Math.log(w.oblicz());
    }    
}
