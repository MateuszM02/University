package figury;

public class Punkt 
{
    private double x;
    private double y;
    public double GetX() {return x; }
    public double GetY() {return y; }
    public static final double epsilon = 0.01;

    public Punkt(double x, double y)
    {
        this.x = x;
        this.y = y;
    }

    @Override
    public boolean equals(Object p)
    {
        if (p == this) // porownanie z samym soba
            return true;
        if (!(p instanceof Punkt)) // zly typ
            return false;
        Punkt temp = (Punkt)p;
        return  Math.abs(x - temp.x) <= Punkt.epsilon && 
                Math.abs(y - temp.y) <= Punkt.epsilon;
    }

    public Punkt przesun(Wektor v)
    {
        return new Punkt(x + v.dx, y + v.dy);
    }

    /**
     * obraca punkt self wzgledem punktu p o dana ilosc stopni
     * @param p punkt, wzgledem ktoregp chcemy obrocic self
     * @param katStopnie ilosc stopni (0-360), o ktora chcemy obrocic self
     * @return obrocony punkt self
     */
    public Punkt obroc(Punkt p, double katStopnie) 
    {
        double katRadiany = Math.toRadians(katStopnie);
        double nowyX = (x - p.x) * Math.cos(katRadiany) - (y - p.y) * Math.sin(katRadiany) + p.x;
        double nowyY = (x - p.x) * Math.sin(katRadiany) + (y - p.y) * Math.cos(katRadiany) + p.y;
        return new Punkt(nowyX, nowyY);
    }

    public Punkt odbij(Prosta prosta) 
    {
        Prosta nowaProsta = Prosta.prostopadla(prosta, this);
        Punkt punktPrzeciecia = Prosta.punktPrzeciecia(prosta, nowaProsta);
        return new Punkt((punktPrzeciecia.x - x) * 2 + x, (punktPrzeciecia.y - y) * 2 + y);
    }
}
