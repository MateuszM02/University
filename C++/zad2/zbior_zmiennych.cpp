#include "zbior_zmiennych.h"
#include <iostream>

zbior_zmiennych::zbior_zmiennych(int rozmiar) : n(rozmiar) //konstruktor z inicjalizacja stalej
{
    tab = NULL;
    if(rozmiar < 0)
        throw std::invalid_argument("Nalez podac nieujemna liczba");
    tab = new zmienna[rozmiar];
    ilosc_zmiennych = 0;
}

zbior_zmiennych::~zbior_zmiennych() //destruktor
{
    delete []tab;
    tab = NULL;
}

//funkcje

void zbior_zmiennych::WstawZmienna(zmienna z)
{
	if(ilosc_zmiennych == n) return; //nie tworz zmiennej, jesli osiagnieto limit
	for(int i = 0; i < ilosc_zmiennych; i++)
	{
		if(tab[i].GetName() == z.GetName())     return; //nie tworz zmiennej, jesli zmienna z ta nazwa juz istnieje
	}
	tab[ilosc_zmiennych] = z; //dodaj nowa zmienna na pierwsze wolne miejsce w tablicy
	ilosc_zmiennych++;
}

bool zbior_zmiennych::SprawdzCzyIstnieje(string nazwa)
{
	for(int i = 0;i < ilosc_zmiennych; i++)
	{
		if(tab[i].GetName().compare(nazwa) == 0) return true;
	}
	return false;
}

void zbior_zmiennych::UsunZmienna(string nazwa)
{
	for(int i = 0; i < ilosc_zmiennych; i++)
	{
		if(tab[i].GetName().compare(nazwa) == 0)
		{
			tab[i] = zmienna(); //inicjalizuje zmienna do wartosci poczatkowej
			return;
		}
	}
	cout<<"Zmienna o podanej nazwie nie istnieje!"<<endl;
}

void zbior_zmiennych::ZmienWartoscZmiennej(string nazwa, double wartosc)
{
	for(int i = 0; i < ilosc_zmiennych; i++)
	{
		if(tab[i].GetName().compare(nazwa) == 0)
		{
			tab[i].SetValue(wartosc);
			return;
		}
	}
	cout<<"Zmienna o podanej nazwie nie istnieje!"<<endl;
}

double zbior_zmiennych::WczytajWartoscZmiennej(string nazwa)
{
	for(int i = 0; i < ilosc_zmiennych; i++)
	{
		if(tab[i].GetName().compare(nazwa) == 0)
		{
			return tab[i].GetValue();
		}
	}
	cout<<"Zmienna o podanej nazwie nie istnieje!"<<endl;
	return 0;
}
