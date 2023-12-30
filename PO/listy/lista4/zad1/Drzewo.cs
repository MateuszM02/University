using System;

public class Drzewo : IListCollection
{
	int wartosc;
	Drzewo lewe;
	Drzewo prawe;
	public Drzewo(int value)
	{
		wartosc = value;
		lewe = null;
		prawe = null;
	}
	public void Dodaj(int value)
    {
		if (value <= wartosc)
		{
			if (lewe != null) lewe.Dodaj(value);
			else lewe = new Drzewo(value);
		}
		else
		{
			if (prawe != null) prawe.Dodaj(value);
			else prawe = new Drzewo(value);
		}
	}
	
	public void Wypisz()
	{
		if(lewe != null) lewe.Wypisz();
		Console.WriteLine(wartosc);
		if (prawe != null) prawe.Wypisz();
	}
	public int Suma()
	{
		int suma = wartosc;
		if (lewe != null) suma += lewe.Suma();
		if (prawe != null) suma += prawe.Suma();
		return suma;
	}
	public int Ilosc()
	{
		int ilosc = 1;
		if (lewe != null) ilosc += lewe.Ilosc();
		if(prawe != null) ilosc += prawe.Ilosc();
		return ilosc;
	}
	public int Wysokosc()
	{
		int wlewy = 0;
		int wprawy = 0;
		if(lewe != null) wlewy = lewe.Wysokosc();
		if(prawe != null) wprawy = prawe.Wysokosc();
		return wlewy > wprawy ? wlewy+1 : wprawy+1;
	}
	public int MaxWartosc()
	{
		int max = wartosc;
		if (lewe != null && lewe.MaxWartosc() > max) max = lewe.MaxWartosc();
		if (prawe != null && prawe.MaxWartosc() > max) max = prawe.MaxWartosc();
		return max;
	}
	public int MinWartosc()
	{
		int min = wartosc;
		if (lewe != null && lewe.MinWartosc() < min) min = lewe.MinWartosc();
		if (prawe != null && prawe.MinWartosc() < min) min = prawe.MinWartosc();
		return min;
	}
	public bool CzyZawiera(int value)
	{
		if (wartosc == value) return true;
		bool zawiera = false;
		if (lewe != null) zawiera = lewe.CzyZawiera(value);
		if (zawiera) return true;
		if (prawe != null) zawiera = prawe.CzyZawiera(value);
		return zawiera;
	}
}
