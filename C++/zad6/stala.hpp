#ifndef STALA
#define STALA

#include "wyrazenie.hpp"

using namespace std;

class stala : wyrazenie
{
    string nazwa;
    double wartosc;
    public:
    stala(string n, double x) : nazwa(n), wartosc(x) {}
    string GetName() {return nazwa;}
    double GetValue() {return wartosc;}
};

#endif
