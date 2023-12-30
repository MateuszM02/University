using System;

public class MyDictionary<K, V>
{

	int rozmiar, ostatni_indeks;
	K[] klucze;
	V[] wartosci;

	public MyDictionary(int r)
	{
		this.rozmiar = r; 
		this.ostatni_indeks = 0;
		klucze = new K[r];
		wartosci = new V[r];
	}

	public int Rozmiar() { return rozmiar; }
	public int Ile_elementow() { return ostatni_indeks; }

	public bool Wstaw(K klucz, V wartosc)
	{
		if (ostatni_indeks == rozmiar) return false; //nie dodawaj elementow, jesli osiagnieto limit w slowniku
		for (int i = 0; i < ostatni_indeks; i++)
		{
			if (klucze[i].Equals(klucz)) return false; //nie dodawaj elementow, jesli istnieje element z podanym kluczem w slowniku
		}
		klucze[ostatni_indeks] = klucz;
		wartosci[ostatni_indeks] = wartosc; 
		ostatni_indeks++;
		return true; //zwroc true jesli udalo sie wstawic element do slownika
	}
	void CofnijElementy(int od_indeksu, int ile_miejsc) //cofa wszystkie elementy tablicy o dana liczbe
	{
		for (int j = od_indeksu + ile_miejsc; j < ostatni_indeks; j++)
		{
			klucze[j - ile_miejsc] = klucze[j]; //cofnij klucze o ile_miejsc
			wartosci[j - ile_miejsc] = wartosci[j]; //cofnij wartosci o ile_miejsc
		}
		ostatni_indeks -= ile_miejsc; //cofnij indeks ostatniego elementu o ile_miejsc
	}
	public V Usun(K klucz)
	{
		for (int i = 0; i < ostatni_indeks; i++)
		{
			if (klucze[i].Equals(klucz)) //jesli znaleziono element o podanym kluczu
			{
				V zmienna = wartosci[i];
				CofnijElementy(i, 1);
				return zmienna;
			}
		}
		return default(V);
	}
	public bool CzyIstniejeKlucz(K klucz)
	{
		for (int i = 0; i < ostatni_indeks; i++)
		{
			if (klucze[i].Equals(klucz)) return true;
		}
		return false;
	}
	public V Wartosc(K klucz)
	{
		for (int i = 0; i < ostatni_indeks; i++)
		{
			if (klucze[i].Equals(klucz)) return wartosci[i];
		}
		return default(V);
	}

}
