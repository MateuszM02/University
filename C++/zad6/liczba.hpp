#ifndef LICZBA
#define LICZBA

#include "wyrazenie.hpp"

using namespace std;

class liczba : public wyrazenie
{
    double wartosc;
    public:
    liczba(double x) : wartosc(x) {}
    ~liczba(){}
    double GetValue() {return wartosc;}
    virtual double oblicz();
    virtual string zapis();
};

#endif
