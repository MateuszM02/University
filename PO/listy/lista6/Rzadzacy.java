public class Rzadzacy implements Comparable<Rzadzacy>
{
    //implementacja metody porownania interfejsu Comparable
    public int compareTo(Rzadzacy r)
    {
        if(r == null) return -1;
        return nazwisko.compareTo(r.nazwisko);
    }
    //cechy rzadzacych
    private String imie;
    private String nazwisko;
    private String narodowosc;
    //gettery
    public String GetImie() {return imie;}
    public String GetNazwisko() {return nazwisko;}
    public String GetNarodowosc() {return narodowosc;}
    //settery
    public void SetImie(String s) {imie = s;}
    public void SetNazwisko(String s) {nazwisko = s;}
    public void SetNarodowosc(String s) {narodowosc = s;}
    //konstruktor
    protected Rzadzacy(String i, String naz, String nar)
    {
        imie = i;
        nazwisko = naz;
        narodowosc = nar;
    }
}
