using System;
using System.Collections; //potrzebne do IEnumerable

public class Lista : IListCollection, IEnumerable
{
	int Length;
	int wartosc;
	Lista poprzedni;
	Lista nastepny; 
	public int GetLength() { return Length; }
	public Lista(int value)
	{
		Length = 1;
		wartosc = value;
		poprzedni = null;
		nastepny = null;
	}
	public Lista(int value, Lista p, Lista n)
	{
		Length = 1;
		wartosc = value;
		poprzedni = p;
		nastepny = n;
	}
	//metody klasy
	public void Dodaj(int value) //dodaje element na koniec listy
	{
		if (nastepny == null) nastepny = new Lista(value, this, null);
		else nastepny.Dodaj(value);
		Length++;
	}

	public void Wypisz()
	{
		Console.WriteLine(wartosc);
		if (nastepny != null) nastepny.Wypisz();
	}
	public int Suma()
	{
		int suma = wartosc;
		if (nastepny != null) suma += nastepny.Suma();
		return suma;
	}
	public int Ilosc()
	{
		int ilosc = 1;
		if (nastepny != null) ilosc += nastepny.Ilosc();
		return ilosc;
	}
    public int MaxWartosc()
    {
		if (nastepny != null)
		{
			int max = nastepny.MaxWartosc();
			return wartosc > max ? wartosc : max;
		}
		else return wartosc;
    }
    public int MinWartosc()
    {
		if (nastepny != null)
		{
			int min = nastepny.MinWartosc();
			return wartosc < min ? wartosc : min;
		}
		else return wartosc;
	}
    public bool CzyZawiera(int value)
	{
		if (wartosc == value) return true;
		if (nastepny != null) return nastepny.CzyZawiera(value);
		return false;
	}

	//metody z polecenia zadania

	public int Wartosc(int indeks) //dostep indeksowany do elementow listy
	{
		if (indeks == 0) return wartosc;
		else if (nastepny != null) return nastepny.Wartosc(--indeks); 
		else throw new IndexOutOfRangeException("Lista nie zawiera takiego indeksu!"); 
	}
	override public string ToString() //metoda ToString() wypisujaca wszystkie elementy listy jako ciag
	{
        string elementy = "";
        foreach (int elem in this)
        {
			elementy += elem.ToString();
        }
		return elementy;
	}
	//Implementacja metod IEnumerator
	int pozycja = -1;
	IEnumerator IEnumerable.GetEnumerator()
	{
		return (IEnumerator) GetEnumerator();
	}
	public Lista GetEnumerator()
	{
		return this;
	}
	public bool MoveNext()
	{
		pozycja++;
		return (pozycja < Length);
	}
	public int Current
	{
		get
		{
			try
			{
				return Wartosc(pozycja);
			}
			catch (IndexOutOfRangeException)
			{
				throw new IndexOutOfRangeException("Podczas wyliczania elementow listy wykryto probe wyjscia poza jej zakres!");
			}
		}
	}
}
