#ifndef MACIERZ
#define MACIERZ

#include <iostream>

using namespace std;

namespace obliczenia
{
    class wektor;
    class macierz 
    {
        public:
        wektor **tab = nullptr; // macierz wskaźników na wektory
        const int w, k; // rozmiar tablicy: w wierszy i k kolumn
        macierz(initializer_list<wektor> lista) : w(lista.size()), // lista wspolczynnikow
            k(lista.size()), tab(new wektor[w,k])
        {   int index = 0;
            for (auto elem : lista)
            {
                for(int i = 0; i < elem.k; i++)
                {
                    tab[index][i] = elem;
                }
                index++;
            };//inicjalizuje wektor lista
        }
        ~macierz (); // destruktor
        friend macierz operator-(const macierz &m); // zmiana znaku
        friend macierz operator+(const macierz &p, const macierz &q);
        friend macierz operator-(const macierz &p, const macierz &q);
        friend macierz operator*(const macierz &m, double d);
        friend macierz operator*(double d, const macierz &m);
        friend macierz operator*(const macierz &p, const macierz &q);
        friend macierz operator~(const macierz &m); // transpozycja
        const macierz& operator+=(const macierz &m);
        const macierz& operator-=(const macierz &m);
        const macierz& operator*=(double d);
        wektor operator [] (int i) const; // do odczytu wspolczynnika
        wektor& operator [] (int i); // do zapisu wspolczynnika
    };
    
    class wektor 
    {
        public:
        double *tab = nullptr; // macierz liczb zmiennopozycyjnych
        const int k; // rozmiar tablicy: k pozycji
        wektor(initializer_list<double> lista) : k(lista.size()), // lista wspolczynnikow
            tab(new double[k])
        {   int index = 0;
            for (auto elem : lista)
            {
                tab[index] = elem;
                index++;
            };//inicjalizuje wektor lista
        }
        wektor& operator = (const wektor &w); // przypisanie kopiujace
        wektor& operator = (wektor &&w); // przypisanie przenoszace
        ~wektor (); // destruktor
        friend wektor operator-(const wektor &v); // zmiana znaku
        friend wektor operator+(const wektor &x, const wektor &y);
        friend wektor operator-(const wektor &x, const wektor &y);
        friend wektor operator*(const wektor &v, double d);
        friend wektor operator*(double d, const wektor &v);
        // iloczyn skalarny x*y
        friend double operator*(const wektor &x, const wektor &y);
        const wektor& operator+=(const wektor &v);
        const wektor& operator-=(const wektor &v);
        const wektor& operator*=(double d);
        double operator [] (int i) const; // do odczytu wspolczynnika
        double& operator [] (int i); // do zapisu wspolczynnika

    };

}

#endif
