package obliczenia;

public abstract class Operand extends Wyrazenie
{
    double wartosc;
    public Operand()
    {}
    public Operand(double wartosc)
    {
        this.wartosc = wartosc;
    }
}
