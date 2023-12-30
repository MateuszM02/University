using System;

interface IListCollection
{
    bool CzyZawiera(int value);
    void Dodaj(int value);
    void Wypisz();
    int Suma();
    int Ilosc();
    int MaxWartosc();
    int MinWartosc();
}
