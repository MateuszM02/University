#include "zmienna.h"

//konstruktory

zmienna::zmienna()
{
    this->nazwa = "_";
}

zmienna::zmienna(string nazwa)
{
    this->nazwa = nazwa;
    this->wartosc = 0;
}

zmienna::zmienna(string nazwa, double wartosc)
{
    this->nazwa = nazwa;
    this->wartosc = wartosc;
}

//funkcje
void zmienna::SetValue(int wartosc)
{
    this->wartosc = wartosc;
};

double zmienna::GetValue()
{
    return this->wartosc;
};

string zmienna::GetName()
{
    return this->nazwa;
};
