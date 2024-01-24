package figury;

public class Prosta 
{
    public final double a; 
    public final double b; 
    public final double c;
    public static final String rownolegleError = "Proste rownolegle nie maja punktu przeciecia";
    public static final String zlaProstaError = "Prosta nie może być postaci C = 0!";

    public Prosta(double a, double b, double c) // AX + BY + C = 0
    {
        if (a == 0 && b == 0)
            throw new IllegalArgumentException(zlaProstaError);
        this.a = a;
        this.b = b;
        this.c = c;
    }

    @Override
    public boolean equals(Object p)
    {
        if (p == this) // porownanie z samym soba
            return true;
        if (!(p instanceof Prosta)) // zly typ
            return false;
        Prosta temp = (Prosta)p;
        return  Math.abs(a - temp.a) <= Punkt.epsilon && 
                Math.abs(b - temp.b) <= Punkt.epsilon &&
                Math.abs(c - temp.c) <= Punkt.epsilon;
    }

    public static boolean CzyProsteRownolegle(Prosta p1, Prosta p2)
    {
        // |A1*B2 - A2*B1| <= e
        return Math.abs(p1.a * p2.b - p2.a * p1.b) <= Punkt.epsilon;
    }

    public static boolean CzyProsteProstopadle(Prosta p1, Prosta p2)
    {
        // |A1*A2 + B1*B2| <= e
        return Math.abs(p1.a * p2.a + p1.b * p2.b) <= Punkt.epsilon;
    }

    /**
     * zwraca prosta prostopadla do 'prosta' przechodzaca przez 'punkt'
     * @param prosta prosta, ktorej prostopadla szukamy
     * @param punkt punkt, przez ktory prosta prostopadla ma przechodzic
     * @return prosta prostopadla do 'prosta' przechodzaca przez 'punkt'
     */ 
    public static Prosta prostopadla(Prosta prosta, Punkt punkt) 
    {
        double d = punkt.GetX() * prosta.b - punkt.GetY() * prosta.a;
        return new Prosta(-prosta.b, prosta.a, d);
    }

    // przesuniecie prostej o wektor
    public static Prosta PrzesunProsta(Prosta p, Wektor v)
    {
        double c = p.c + v.dy - p.a * v.dx; // C -> C + vb -A*va
        return new Prosta(p.a, p.b, c);
    }

    // zwraca punkt przeciecia prostych p1, p2
    public static Punkt punktPrzeciecia(Prosta p1, Prosta p2) 
    {
        double wAB = wyznacznik(p1.a, p2.a, p1.b, p2.b);
        if (wAB == 0) // proste sa rownolegle, nie maja punktu przeciecia!
            throw new IllegalArgumentException(rownolegleError);
        return new Punkt(wyznacznik(p1.b, p2.b, p1.c, p2.c) / wAB, wyznacznik(p1.c, p2.c, p1.a, p2.a) / wAB);
    }

    // wyznacznik macierzy 2x2 postaci [[a1 b1], [a2 b2]]
    private static double wyznacznik(double a1, double a2, double b1, double b2) 
    {
        return a1*b2 - a2*b1;
    }
}
