package obliczenia;

public abstract class Dzialanie extends Wyrazenie 
{
    Wyrazenie w;
    public Dzialanie()
    {}
    public Dzialanie(Wyrazenie w)
    {
        this.w = w;
    }  
}
