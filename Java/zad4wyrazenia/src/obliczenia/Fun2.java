package obliczenia;

public abstract class Fun2 extends Fun1 
{
    Wyrazenie w2;
    Priorytet priorytet;
    // public Fun2()
    // {}
    public Fun2(Wyrazenie w1, Wyrazenie w2, Priorytet priorytet)
    {
        super(w1);
        this.w2 = w2;
        this.priorytet = priorytet;
    }        
}
