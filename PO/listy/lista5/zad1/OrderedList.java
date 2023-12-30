public class OrderedList<T extends Comparable<T>>
{
    //klasa przechowujaca pojedncza wartosc i wskazniki na 2 sasiednie wartosci
    public class Element<T extends Comparable<T>>
    {
        Element<T> previous;
        Element<T> next;
        T wartosc;
        public T GetValue()
        {
            if(this != null) return wartosc;
            else throw new IndexOutOfBoundsException("Element nie istnieje!");
        }
        //konstruktory
        public Element(T value) //konstruktor elementu dla pustej listy
        {
            previous = null;
            next = null;
            wartosc = value;
        }
        public Element(T value, Element<T> poprzedni, Element<T> nastepny) //konstruktor elementu dla niepustej listy
        {
            previous = poprzedni;
            next = nastepny;
            wartosc = value;
        }
    }
    //--------------------------
    public Element<T> first; //wskaznik na pierwszy element listy
    public Element<T> last; //wskaznik na ostatni element listy
    //konstruktor listy 1-elementowej
    public OrderedList(T value)
    {
        Element<T> e = new Element<T>(value);
        first = e;
        last = e;
    }
    //metody
    void DodajDoListy(T value, Element<T> aktualny)
    {
        try 
        {
            if(aktualny.wartosc.compareTo(value) >= 0) //wartosc nie wieksza od aktualnego elementu listy - nalezy dolaczyc ja przed tym elementem
            {
                if(aktualny.previous == null) //jesli wartosc jest dodawana na poczatek listy
                {
                    Element<T> e = new Element<T>(value, null, aktualny);
                    aktualny.previous = e;
                    first = e;
                }
                else //jesli wartosc jest dodawana w srodku listy
                {
                    Element<T> e = new Element<T>(value, aktualny.previous, aktualny);
                    aktualny.previous.next = e;
                    aktualny.previous = e;
                }
            }
            else //wartosc wieksza od aktualnego elementu listy - nalezy porownac ja z nastepnym elementem
            {
                if(aktualny.next == null) //jesli nastepny element listy nie istnieje to wartosc jest dodawana na koniec listy
                {
                    Element<T> e = new Element<T>(value, aktualny, null);
                    aktualny.next = e;
                    last = e;
                }
                else DodajDoListy(value, aktualny.next); //jesli nastepny element listy istnieje to wartosc jest z nim porownywana
            }
        } 
        catch(Exception e) 
        {
            throw e;
        }
    }
    //metody z polecenia zadania
    public T get_first()
    {
        if(first != null)        return first.GetValue();
        else throw new IndexOutOfBoundsException("Lista jest pusta!");
    }
    public void add_element(T elem)
    {
        DodajDoListy(elem, first);
    }
    public String toString()
    {
        return Dopisz("",first);
    }
    //metody pomocnicze
    private String Dopisz(String ciag, Element<T> elem)
    {
        String nowy = ciag + elem.wartosc;
        if(elem.next != null) return Dopisz(nowy,elem.next);
        else return nowy;
    }
    public T get_n(Element<T> elem, int n)
    {
        if(elem == null) throw new IndexOutOfBoundsException("Lista nie zawiera takiego indeksu!");
        else if(n == 0) return elem.GetValue();
        else return get_n(elem.next,n-1);
    }
}
