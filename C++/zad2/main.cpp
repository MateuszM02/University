#include <iostream>
#include "zmienna.h"
#include "zbior_zmiennych.h"

using namespace std;

int main()
{
    ///test klasy zmienna
    zmienna z1 = zmienna();
    zmienna z2 = zmienna("drugi_konstruktor");
    zmienna z3 = zmienna("trzeci_konstruktor",100);
    cout<<"Nazwa 1 zmiennej: "<<z1.GetName()<<endl<<"wartosc 1 zmiennej: "<<z1.GetValue()<<endl; 
    //wartosc z1 nie zostala zainicjalizowana zgodnie z poleceniem zadania, dlatego zwraca smieci z pamieci
    cout<<"Nazwa 2 zmiennej: "<<z2.GetName()<<endl<<"wartosc 2 zmiennej: "<<z2.GetValue()<<endl;
    cout<<"Nazwa 3 zmiennej: "<<z3.GetName()<<endl<<"wartosc 3 zmiennej: "<<z3.GetValue()<<endl;

    ///test klasy zbior_zmiennych
    zbior_zmiennych zbior = zbior_zmiennych(3);
    zbior.WstawZmienna(z1); //dodaje z1 do tablicy zmiennych
    zbior.WstawZmienna(z2); //dodaje z2 do tablicy zmiennych
    cout<<zbior.SprawdzCzyIstnieje(z1.GetName())<<endl; //wypisuje 1, bo z1 zostala dodana do tablicy
    cout<<zbior.WczytajWartoscZmiennej(z2.GetName())<<endl; //wypisuje wartosc z2, czyli 0
    zbior.UsunZmienna(z1.GetName()); //usuwa z1 z tablicy
    zbior.ZmienWartoscZmiennej(z2.GetName(),20); //zmienia wartosc z2
    cout<<zbior.WczytajWartoscZmiennej(z2.GetName())<<endl; //wypisuje nowa wartosc z2, tym razem 20
    return 0;
}
