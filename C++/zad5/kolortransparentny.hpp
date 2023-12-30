#ifndef TRANS
#define TRANS

#include <iostream>
#include "kolor.hpp"

using namespace std;

class kolortransparentny : public kolor
{
    int alfa;
    //gettery i settery
public:
    int GetAlfa()     {return alfa; }
    void SetAlfa(int value)
    {
        if(value<0 || value>255) throw new invalid_argument("Zly zakres koloru alfa!");
        alfa = value;
    }
    //konstruktory
    kolortransparentny() : kolor() {alfa = 0;}
    kolortransparentny(int a) : kolor()
    {
        if(a<0 || a>255) throw new invalid_argument("Zly zakres koloru alfa!");
        alfa = a;
    }
    kolortransparentny(int a,int r, int g, int b) : kolor(r,g,b)
    {
        if(a<0 || a>255) throw new invalid_argument("Zly zakres koloru alfa!");
        alfa = a;
    }
};

#endif
