package obliczenia;

public class Liczba extends Operand 
{
    public Liczba(double liczba) 
    {
        super(liczba);
    }

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
        if (!(obj instanceof Liczba))
            return false;
        return this.wartosc == ((Liczba)obj).wartosc;
    }

    @Override
    public double oblicz() 
    {
        return this.wartosc;
    }
}
