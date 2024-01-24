package obliczenia;

public abstract class Oper2 extends Oper1 
{
    Wyrazenie w2;
    Priorytet priorytet;
    // public Oper2()
    // {}
    public Oper2(Wyrazenie w1, Wyrazenie w2, Priorytet priorytet)
    {
        super(w1);
        this.w2 = w2;
        this.priorytet = priorytet;
    }
}
