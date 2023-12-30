#include "kolor.hpp"

//konstruktory
kolor::kolor()
{
    red = 0;    
    green = 0;
    blue = 0;
}

kolor::kolor(int r, int g, int b)
{
    if(r<0 || r>255) throw new invalid_argument("Zly zakres koloru czerwonego!");
    else if(g<0 || g>255) throw new invalid_argument("Zly zakres koloru zielonego!");
    else if(b<0 || b>255) throw new invalid_argument("Zly zakres koloru niebieskiego!");
    red = r;
    green = g;
    blue = b; 
}

//metody
void kolor::SetRed(int value)     
{
    if(value<0 || value>255) throw new invalid_argument("Zly zakres koloru czerwonego!");
    red = value;
}
void kolor::SetGreen(int value)
{
    if(value<0 || value>255) throw new invalid_argument("Zly zakres koloru zielonego!");
    green = value;
}
void kolor::SetBlue(int value)
{
    if(value<0 || value>255) throw new invalid_argument("Zly zakres koloru niebieskiego!");
    blue = value;
}
