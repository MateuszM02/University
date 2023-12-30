#include "kolejka.h"

//konstruktory i destruktory

kolejka::kolejka(int poj) //1-argumentowy
{
    poczatek = 0;
    ile = 0;
    pojemnosc = poj;
    tab = new string[pojemnosc];
}

kolejka::kolejka(kolejka &kol) //kopiujacy
{
    tab = new string [kol.pojemnosc];
    for(int i=0; i<kol.pojemnosc;i++)
    {
        tab[i] = kol.tab[i];
    }
    pojemnosc = kol.pojemnosc;
    poczatek = kol.poczatek;
}

kolejka::kolejka(kolejka &&kol) //przenoszacy
{
    pojemnosc = kol.pojemnosc;
    poczatek = kol.poczatek;
    tab = kol.tab;

    kol.tab = nullptr;
}

kolejka::~kolejka() //destruktor
{
    delete [] tab;
    tab = NULL;
}

//operatory

kolejka &kolejka::operator=(kolejka &kol) //kopiujacy
{
    if (&kol != this)
    {
        this->~kolejka();
        pojemnosc = kol.pojemnosc;
        poczatek = kol.poczatek;
        tab = new string [pojemnosc];
        for(int i=0; i<pojemnosc;i++)
        {
            tab[i] = kol.tab[i];
        }
    }
    return *this;
}

kolejka &kolejka::operator=(kolejka &&kol) //przenoszacy
{
    if (&kol != this)
    {
        this->~kolejka();
        pojemnosc = kol.pojemnosc;
        poczatek = kol.poczatek;
        tab = kol.tab;
    }
    return *this;
}

//operacje na kolejce

int kolejka::Get_Indeks_Nowego()
{
    int indeks = Get_Poczatek() + dlugosc();
    return indeks % Get_Pojemnosc();
}

void kolejka::wstaw(string napis)
{
    if(dlugosc() >= Get_Pojemnosc()) return; //nie dodawaj elementu do kolejki, jesli jest zapelniona
    if(napis == "") return; //nie dodawaj pustych napisow do kolejki
    int indeks = Get_Indeks_Nowego();
    tab[indeks] = napis;
    Set_Ile(true); //zwieksz ilosc elementow w kolejce o 1
}

string kolejka::usun()
{
    int indeks = Get_Poczatek();
    if(tab[indeks] == "") return ""; //zabron usuwania z pustej kolejki
    string napis = tab[indeks];
    tab[indeks] = "";
    Set_Poczatek(); //zwieksz indeks pierwszego elementu kolejki o 1
    Set_Ile(false); //zmniejsz ilosc elementow w kolejce o 1
    return napis;
}

string kolejka::zprzodu()
{
    return tab[Get_Poczatek()];
}

int kolejka::dlugosc()
{
    return ile;
}
