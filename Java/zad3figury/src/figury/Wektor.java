package figury;

public class Wektor 
{
    public final double dx;
    public final double dy;
    
    public Wektor(double dx, double dy)
    {
        this.dx = dx;
        this.dy = dy;
    }

    @Override
    public boolean equals(Object p)
    {
        if (p == this) // porownanie z samym soba
            return true;
        if (!(p instanceof Wektor)) // zly typ
            return false;
        Wektor temp = (Wektor)p;
        return Math.abs(dx - temp.dx) <= Punkt.epsilon && Math.abs(dy - temp.dy) <= Punkt.epsilon;
    }

    // skladanie wektorow v1, v2 w jeden wektor
    public static Wektor zlozWektory(Wektor v1, Wektor v2) 
    {
        double noweDx = v1.dx + v2.dx;
        double noweDy = v1.dy + v2.dy;
        return new Wektor(noweDx, noweDy);
    }
}
