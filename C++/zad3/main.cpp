#include <iostream>
#include "kolejka.h"

using namespace std;

int main()
{
    //konstruktor bezparametrowy i delegatowy
    kolejka k0 = kolejka(); //stworz kolejke konstruktorem delegatowym - maksymalny rozmiar to 1
    k0.wstaw("jedyny_ciag");
    k0.wstaw("kolejka_zapelniona");
    cout << "Pierwszy element kolejki 1-elementowej (usuwanie): " << k0.usun() << endl;
    cout << "Pierwszy element kolejki 1-elementowej (z przodu): " << k0.zprzodu() << endl;
    cout << "       kolejka pusta, bo usunieto jedyny element (element 2 nigdy nie zostal do niej dodany)" << endl;
    k0.~kolejka(); //zwolnij pamiec
    
    //konstruktor 1-argumentowy
    
    kolejka k = kolejka(5); //stworz kolejke o maksymalnym rozmiarze 5
    cout << "Pierwszy element kolejki (usuwanie): " << k.usun() << endl;
    cout << "Pierwszy element kolejki (usuwanie): " << k.usun() << endl;
    k.wstaw("ciag1");
    k.wstaw("ciag2");
    cout << "Pierwszy element kolejki (z przodu): " << k.zprzodu() << endl;
    cout << "Pierwszy element kolejki (usuwanie): " << k.usun() << endl;
    cout << "Pierwszy element kolejki (z przodu): " << k.zprzodu() << endl;
    k.wstaw("ciag3");
    k.wstaw("ciag4");
    
    //konstruktor kopiujacy
    kolejka k2 = kolejka(k); //stworz nowa kolejke konstruktorem kopiujacym
    k.~kolejka(); //usun oryginalna kolejke
    
    cout<< "Pierwszy element skopiowanej kolejki (z przodu): " << k2.zprzodu() << endl;
    cout << "Pierwszy element skopiowanej kolejki (usuwanie): " << k2.usun() << endl;
    cout << "Pierwszy element skopiowanej kolejki (usuwanie): " << k2.usun() << endl;
    cout << "Pierwszy element skopiowanej kolejki (usuwanie): " << k2.usun() << endl;
    cout << "Pierwszy element skopiowanej kolejki (usuwanie): " << k2.usun() << endl;
    
    k2.~kolejka(); //usun skopiowana kolejke
    
    //konstruktor z lista inicjalizujaca
    kolejka k3 = kolejka{"init1","init2","init3"}; //stworz nowa kolejke konstruktorem kopiujacym
    
    cout<< "Pierwszy element kolejki listowej (z przodu): " << k3.zprzodu() << endl;
    cout << "Pierwszy element kolejki listowej (usuwanie): " << k3.usun() << endl;
    cout << "Pierwszy element kolejki listowej (usuwanie): " << k3.usun() << endl;
    cout << "Pierwszy element kolejki listowej (usuwanie): " << k3.usun() << endl;
    cout << "Pierwszy element kolejki listowej (usuwanie): " << k3.usun() << endl;
    
    k3.~kolejka(); //usun skopiowana kolejke
    return 0;
}
