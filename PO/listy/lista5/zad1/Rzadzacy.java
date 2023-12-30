public abstract class Rzadzacy implements Hierarchia, Comparable<Rzadzacy>
{
    //implementacja metod interfejsu Hierarchia
    public int compareTo(Rzadzacy r)
    {
        if(r == null) return -1;
        return ranga() - r.ranga();
    }
    public boolean czy_wazniejszy_od(Rzadzacy r)
    {
        if(compareTo(r) >= 0) return false;
        return true;
    }
    //wypisuje cechy rzadzacych
    public String Dane()
    {
        if(this == null) throw new IndexOutOfBoundsException("Element nie istnieje!");;
        return imie+" "+nazwisko+", "+narodowosc;
    }
    //cechy rzadzacych, dziedziczone przez klasy pochodne
    protected String imie;
    protected String nazwisko;
    protected String narodowosc;
    //gettery
    public String GetImie() {return imie;}
    public String GetNazwisko() {return nazwisko;}
    public String GetNarodowosc() {return narodowosc;}
    //settery
    public void SetImie(String s) {imie = s;}
    public void SetNazwisko(String s) {nazwisko = s;}
    public void SetNarodowosc(String s) {narodowosc = s;}
    //konstruktory
    protected Rzadzacy()
    {
        imie = "";
        nazwisko = "";
        narodowosc = "";
    }
    protected Rzadzacy(String i, String naz, String nar)
    {
        imie = i;
        nazwisko = naz;
        narodowosc = nar;
    }
}
