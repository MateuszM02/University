package obliczenia;

public class Dodaj extends Oper2
{
    public Dodaj(Wyrazenie w1, Wyrazenie w2)
    {
        super(w1, w2, Priorytet.Dodawanie);
    }

    @Override
    public String toString() 
    {
        return String.format("(%s + %s)", w.toString(), w2.toString());
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj)
            return true;
        if (!(obj instanceof Dodaj))
            return false;
        return ((Dodaj) obj).w.equals(this.w) && ((Dodaj) obj).w2.equals(this.w2);
    }

    @Override
    public double oblicz()
    {
        return w.oblicz() + w2.oblicz();
    }    
}
