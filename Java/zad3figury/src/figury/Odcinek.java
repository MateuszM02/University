package figury;

public class Odcinek 
{
    private Punkt a;
    private Punkt b;
    public static final String equalError = "Odcinek musi sie skladac z 2 roznych punktow";
    
    public Odcinek(Punkt a, Punkt b)
    {
        if (a.equals(b))
        {
            throw new IllegalArgumentException(equalError);
        }
        else 
        {
            this.a = a;
            this.b = b;
        }
    }

    @Override
    public boolean equals(Object p)
    {
        if (p == this) // porownanie z samym soba
            return true;
        if (!(p instanceof Odcinek)) // zly typ
            return false;
        Odcinek temp = (Odcinek)p;
        return a.equals(temp.a) && b.equals(temp.b);
    }

    public Odcinek przesun(Wektor w) 
    {
        return new Odcinek(new Punkt(a.GetX() + w.dx, a.GetY() + w.dy), new Punkt(b.GetX() + w.dx, b.GetY() + w.dy));
    }

    public Odcinek obroc(Punkt p, double katStopnie) 
    {
        return new Odcinek(a.obroc(p, katStopnie), b.obroc(p, katStopnie));
    }

    public Odcinek odbij(Prosta p) 
    {
        return new Odcinek(a.odbij(p), b.odbij(p));
    }
}
