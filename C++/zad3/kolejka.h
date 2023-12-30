#ifndef KOLEJKA_H
#define KOLEJKA_H

#include <iostream>

using namespace std;

class kolejka
{
    public:
        kolejka() : kolejka(1) {}; //delegatowy
        kolejka(int poj);
        kolejka(initializer_list<string> lista) : pojemnosc(sizeof(lista)), //ilosc elementow listy
            poczatek(0),ile(0),
            tab(new string[pojemnosc])
        {
            int index = 0;
            for (auto elem : lista)
            {
                tab[index] = elem;
                index++;
            };//inicjalizuje kolejke za pomoca listy napisow
        }
        kolejka(kolejka & osoba); //kopiujacy
        kolejka(kolejka && osoba); //przenoszacy
        //
        kolejka & operator=(kolejka &kol); // przypisanie kopiujace
        kolejka & operator=(kolejka &&kol); // przypisanie przenoszace
        ~kolejka();
        //operacje na kolejce
        void wstaw(string napis);
        string usun();
        string zprzodu();
        int dlugosc();
        //gettery i settery
        int Get_Poczatek() { return poczatek; }
        int Get_Pojemnosc() { return pojemnosc; }
        int Get_Indeks_Nowego();
        void Set_Poczatek()
        {
            poczatek = (poczatek + 1) % pojemnosc;
        }
        void Set_Ile(bool next)
        {
            if(next)    ile++;
            else ile--;
        }

    private:
        int pojemnosc;
        int poczatek;
        int ile;
        string *tab;
};

#endif // KOLEJKA_H
