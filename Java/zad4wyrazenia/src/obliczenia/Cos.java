package obliczenia;

public class Cos extends Fun1 
{
    public Cos(Wyrazenie w) 
    {
        super(w);
    }

    @Override
    public String toString() 
    {
        return String.format("cos(%s)", w);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Cos))
            return false;
        return ((Cos) obj).w.equals(this.w);
    }

    @Override
    public double oblicz() 
    {
        return Math.cos(w.oblicz());
    }
}
