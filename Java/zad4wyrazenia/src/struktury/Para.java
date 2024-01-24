package struktury;

public class Para implements Cloneable, Comparable<Para> 
{
    public final String klucz;
    private double wartosc;
    
    // Getter
    public double getWartosc() { return this.wartosc; }
    // Setter
    public void setWartosc(double wartosc) { this.wartosc = wartosc; }

    public Para(String klucz, double wartosc)
    {
        if (klucz == null || klucz.isEmpty() || !klucz.matches("[a-z]+"))
            throw new IllegalArgumentException("klucz ma byc niepusty, skladajacy sie tylko z malych liter");
        this.klucz = klucz;
        this.wartosc = wartosc;
    }

    @Override
    public String toString()
    {
        return String.format("klucz: %s, wartosc: %d", this.klucz, this.wartosc);
    }

    @Override
    public boolean equals(Object p)
    {
        if (this == p)
            return true;
        if (!(p instanceof Para))
            return false;
        return this.klucz == ((Para)p).klucz;
    }

    @Override
    public Para clone() throws CloneNotSupportedException
    {
        return (Para)super.clone();
    }

    public int compareTo(Para p)
    {
        return (int)(this.wartosc - p.wartosc);
    }
}
