package rozgrywka;

import obliczenia.Wymierna;

public class Gra 
{
    private int zakres;
    private Wymierna liczba;
    private int maksIloscProb;
    private int licznikProb;
    private double minWartosc;
    private double maxWartosc;

    // gettery
    public double getMinWartosc() { return minWartosc; }
    public double getMaxWartosc() { return maxWartosc; }
    public int getMaxIloscProb() { return maksIloscProb; }
    public int getLicznik() { return licznikProb; }
    public int getZakres() { return zakres; }
    public String GET_RESULT() { return liczba.toString(); }

    // settery
    public void IncLicznik()
    {
        licznikProb++;
    }
    public void setMinWartosc(double wartosc) 
    { 
        minWartosc = Math.max(minWartosc, wartosc); 
    }
    public void setMaxWartosc(double wartosc) 
    { 
        maxWartosc = Math.min(maxWartosc, wartosc); 
    }
    public void setZakres(int zakres) 
    { 
        this.zakres = zakres; 
        //this.maxWartosc = zakres + 1;
    }

    public Gra()
    {
        zakres = 5;
        liczba = null;
        maksIloscProb = 0;
        licznikProb = 0;
        minWartosc = 0;
        maxWartosc = 1;
    }

    public void start(int z) 
    {
        if (z < 5 || z > 20) 
            throw new IllegalArgumentException("Zakres musi byc miedzy 5 a 20");
        zakres = z;
        //do {
        int licz = (int) (Math.random() * zakres) + 1;
        int mian = (int) (Math.random() * zakres) + 1;
        //while (licz >= mian);
        liczba = new Wymierna(licz, mian);
        maksIloscProb = 3 * (int)Math.ceil(Math.log(zakres));
        licznikProb = 0;
        minWartosc = 0;
        maxWartosc = 1;
        assert licz < mian : "Liczba poza zakresem (0, 1)"; // czy 0 < liczba < 1
        //if (licz >= mian)
        //throw new IllegalArgumentException();
    }

    public double wyslijTyp(String sLicznik, String sMianownik)
    {
        try 
        {
            double licznik = Integer.parseInt(sLicznik);
            double mianownik = Integer.parseInt(sMianownik);
            if (mianownik == 0)
                return Double.NaN;
            return Math.signum((licznik / mianownik) - this.liczba.wartosc());
        } catch (Exception e) 
        {
            return Double.NaN;
        }
    }

    public String wiadomosc(double x)
    {
        if (x == 0)
            return "Brawo, zgadłeś!";
        else if (x < 0)
            return "Za mało!";
        return "Za dużo!";
    }
}