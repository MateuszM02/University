#include <iostream>
#include "wielomian.h"

using namespace std;

int main()
{
    wielomian w0 = wielomian(5); //konstruktor jednomianowy
    //operacje
    cout<< w0 <<endl; //wypisuje wspolczynniki wielomianu dzieki nadpisaniu operatora <<
    //w0.~wielomian(); //zwolnij pamiec
    
    //konstruktor wielomianu
    double t[] = {3,5,7};
    wielomian w1 = wielomian(3,t);
    //operacje
    cout<< w1 <<endl; //wypisuje wspolczynniki wielomianu dzieki nadpisaniu operatora <<
    //w1 = w1 * 2; //mnozy wspolczynniki wielomianu przez stala dzieki nadpisaniu operatora *
    //cout<< w1 <<endl; //wypisuje wspolczynniki wielomianu dzieki nadpisaniu operatora <<
    w1.~wielomian(); //zwolnij pamiec
    
    //lista inicjalizacyjna
    //wielomian w2 = wielomian{2,4};
    //operacje
    //cout<< w2 <<endl; //wypisuje wspolczynniki wielomianu dzieki nadpisaniu operatora <<
    /*
    //konstruktor kopiujacy
    wielomian w3 = wielomian(w2); //stworz nowy wielomian konstruktorem kopiujacym
    w2.~wielomian(); //usun oryginalny wielomian
    //operacje
    cout<< w3 <<endl; //wypisuje wspolczynniki wielomianu dzieki nadpisaniu operatora <<
    w3.~wielomian(); //usun skopiowany wielomian*/
    return 0;
}
