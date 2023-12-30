#ifndef WIELOMIAN_H
#define WIELOMIAN_H

#include <iostream>

using namespace std;

class wielomian
{
public:
    ///konstruktory
    wielomian (double wspolczynnik); // konstruktor jednomianu
    wielomian (int stopien, const double wspolczynnik[]); // konstruktor wielomianu
    wielomian(initializer_list<double> lista) : n(lista.size()), // lista wspolczynnikow
            a(new double[n])
        {   cout<<"Ile elementow: "<<n<<endl<<endl;
            int index = 0;
            for (auto elem : lista)
            {
                a[index] = elem;
                index++;
            };//inicjalizuje wielomian lista
        }
    wielomian (const wielomian &w); // konstruktor kopiujacy
    wielomian (wielomian &&w); // konstruktor przenoszacy
    ///przypisania i destruktor
    wielomian& operator = (const wielomian &w); // przypisanie kopiujace
    wielomian& operator = (wielomian &&w); // przypisanie przenoszace
    ~wielomian (); // destruktor
    ///operatory strumieniowe
    friend istream& operator >> (istream &we, wielomian &w);
    friend ostream& operator << (ostream &wy, const wielomian &w);
    ///operatory arytmetyczne
    friend wielomian operator + (const wielomian &u, const wielomian &v);
    friend wielomian operator - (const wielomian &u, const wielomian &v);
    friend wielomian operator * (const wielomian &u, const wielomian &v);
    friend wielomian operator * (const wielomian &w, double c);
    wielomian& operator += (const wielomian &v);
    wielomian& operator -= (const wielomian &v);
    wielomian& operator *= (const wielomian &v);
    wielomian& operator *= (double c);
    double operator () (double x) const; // wartosc wielomianu dla x
    double operator [] (int i) const; // do odczytu wspolczynnika
    double& operator [] (int i); // do zapisu wspolczynnika
    ///metody
    int Get_Stopien()
    {
        return n;
    }
    double Get_Wspolczynnik(int pozycja);
    void Set_Wspolczynnik(int pozycja, double wartosc);

private:
    int n; //stopien wielomianu
    double *a; //tablica wspolczynnikow wielomianu
};

#endif // WIELOMIAN_H
