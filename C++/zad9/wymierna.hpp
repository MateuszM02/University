#ifndef wymierna
#define WYMIERNA

#include <iostream>
#include "wyjatek_wymierny.hpp"

using namespace std;

namespace obliczenia
{
    class wymierna
    {
        int licznik;
        int mianownik;
    public:
        //gettery i settery
        int GetLicznik() const {return licznik;}
        int GetMianownik() const {return mianownik;}
        void SetLicznik(int x);
        void SetMianownik(int y);
        //konstruktory i destruktor
        wymierna()
        {
            licznik = 0;
            mianownik = 1;
        }
        wymierna(int x) //konstruktor konwertujacy
        {
            wymierna(x,1);
        }
        wymierna(int x, int y)
        {
            update(x, y);
        }
        ~wymierna()
        {
            //
        }
        //aktualizuje wartosc licznika i mianownika tak, zeby nwd(l,m) = 1 oraz m > 0
        void update(int x, int y);
        void wypisz(); //wypisuje liczbe jako ulamek zwykly
        ///operatory arytmetyczne
        wymierna operator + (wymierna w);
        wymierna operator - (wymierna w);
        wymierna operator * (wymierna w);
        wymierna operator / (wymierna w);
        //jednoargumentowe
        wymierna operator - (); //do zmiany znaku
        wymierna operator ! (); //odwrotnosc
        //inne
        operator double() {return (double)licznik / (double)mianownik;} //operator rzutowania na typ double
        operator int() {return licznik / mianownik;} //operator jawnego rzutowania na typ int
        friend ostream& operator << (ostream &wyj, const wymierna &w);
    };
}

#endif
