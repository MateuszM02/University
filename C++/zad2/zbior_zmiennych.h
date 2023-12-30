#ifndef ZBIOR
#define ZBIOR

#include "zmienna.h"
#include <iostream>

using namespace std;

class zbior_zmiennych
{
    public:
        zbior_zmiennych(int rozmiar);
        ~zbior_zmiennych();
        void WstawZmienna(zmienna z);
        bool SprawdzCzyIstnieje(string nazwa);
        void UsunZmienna(string nazwa);
        void ZmienWartoscZmiennej(string nazwa, double wartosc);
        double WczytajWartoscZmiennej(string nazwa);
    private:
        const int n;
        zmienna *tab;
        int ilosc_zmiennych;
};

#endif
