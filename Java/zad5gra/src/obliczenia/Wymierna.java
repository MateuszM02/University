package obliczenia;

public class Wymierna implements Comparable<Wymierna>
{
    private int licznik, mianownik = 1;

    public int getLicznik()
    {
        return this.licznik;
    }

    public int getMianownik()
    {
        return this.mianownik;
    }

    // Konstruktory ------------------------------------------------------
    public Wymierna()
    {
        this.licznik = 0;
        this.mianownik = 1;
    }

    public Wymierna(int n)
    {
        this(n, 1);
    }

    public Wymierna(int k, int m)
    {
        if (m == 0)
            throw new IllegalArgumentException("Mianownik nie moze byc zerem");
        else if (m < 0)
        {
            k = -k;
            m = -m;
        }
        int nwd = nwd(Math.abs(k), Math.abs(m));
        this.licznik = k / nwd;
        this.mianownik = m / nwd;
    }

    private int nwd(int a, int b)
    {
        if (b > 0)
            return nwd(b, a % b);
        return a;
    }

    // Nadpisania --------------------------------------------------------
    @Override
    public String toString()
    {
        return String.format("%d / %d", this.licznik, this.mianownik);
    }

    @Override
    public boolean equals(Object other)
    {
        if (this == other)
            return true;
        if (!(other instanceof Wymierna))
            return false;
        return  this.licznik == ((Wymierna)other).licznik &&
                this.mianownik == ((Wymierna)other).mianownik;
    }

    @Override
    public int compareTo(Wymierna other) 
    {
        double thisValue = (double) this.licznik / this.mianownik;
        double otherValue = (double) other.licznik / other.mianownik;
        return (int) Math.signum(thisValue - otherValue);
    }

    public double wartosc()
    {
        assert this.mianownik != 0;
        return (double)this.licznik / (double)this.mianownik;
    }

    // operacje arytmetyczne ---------------------------------------------
    public static Wymierna dodawanie(Wymierna w1, Wymierna w2)
    {
        int licznik = w1.licznik * w2.mianownik + w2.licznik * w1.mianownik;
        return new Wymierna(licznik, w1.mianownik * w2.mianownik);
    }

    public static Wymierna odejmowanie(Wymierna w1, Wymierna w2)
    {
        int licznik = w1.licznik * w2.mianownik - w2.licznik * w1.mianownik;
        return new Wymierna(licznik, w1.mianownik * w2.mianownik);
    }

    public static Wymierna mnozenie(Wymierna w1, Wymierna w2)
    {
        return new Wymierna(w1.licznik * w2.licznik, w1.mianownik * w2.mianownik);
    }

    public static Wymierna dzielenie(Wymierna w1, Wymierna w2)
    {
        if (w2.licznik == 0)
            throw new ArithmeticException("Nie mozna dzielic przez zero");
        return mnozenie(w1, new Wymierna(w2.mianownik, w2.licznik)); // mnozenie przez 1 / w2
    }
}
