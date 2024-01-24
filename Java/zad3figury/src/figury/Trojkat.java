package figury;

public class Trojkat 
{
    private Punkt a;
    private Punkt b;
    private Punkt c;
    public static final String errorMessage = "Trojkat musi sie skladac z 3 niewspollinowych punktow";

    public Trojkat(Punkt a, Punkt b, Punkt c)
    {
        if (czyWspolliniowe(a, b, c))
        {
            throw new IllegalArgumentException(errorMessage);
        }
        else 
        {   
            this.a = a;
            this.b = b;
            this.c = c;
        }
    }

    @Override
    public boolean equals(Object p)
    {
        if (p == this) // porownanie z samym soba
            return true;
        if (!(p instanceof Trojkat)) // zly typ
            return false;
        Trojkat temp = (Trojkat)p;
        return a.equals(temp.a) && b.equals(temp.b) && c.equals(temp.c);
    }

    // sprawdzanie wspolliniowosci 3 punktow (z dokladnoscia do epsilona)
    private boolean czyWspolliniowe(Punkt p1, Punkt p2, Punkt p3) 
    {
        double a = (p1.GetY() - p2.GetY()) / (p1.GetX() - p2.GetX());
        double b = p1.GetY() - (p1.GetX() * a);

        return Math.abs(p3.GetY() - p3.GetX()*a - b) <= Punkt.epsilon;
    }

    public Trojkat przesun(Wektor w) 
    {
        return new Trojkat(a.przesun(w), b.przesun(w), c.przesun(w));
    }

    public Trojkat obroc(Punkt p, double katStopnie) 
    {
        return new Trojkat(a.obroc(p, katStopnie), b.obroc(p, katStopnie), c.obroc(p, katStopnie));
    }

    public Trojkat odbij(Prosta p) 
    {
        return new Trojkat(a.odbij(p), b.odbij(p), c.odbij(p));
    }
}
