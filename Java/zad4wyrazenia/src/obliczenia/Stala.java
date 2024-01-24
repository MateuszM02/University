package obliczenia;

public abstract class Stala extends Operand 
{
    @Override
    public String toString() 
    {
        return Double.toString(this.wartosc);
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Stala))
            return false;
        return this.wartosc == ((Stala)obj).wartosc;
    }

    @Override
    public double oblicz() 
    {
        return this.wartosc;
    }
}
