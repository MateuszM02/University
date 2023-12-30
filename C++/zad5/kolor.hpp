#ifndef KOLOR
#define KOLOR

#include <iostream>

using namespace std;

class kolor
{
    int red;
    int green;
    int blue;
    //gettery i settery
public:
    int GetRed()     {return red; }
    int GetGreen()   {return red; }
    int GetBlue()    {return blue;}
    void SetRed(int value);
    void SetGreen(int value);
    void SetBlue(int value);
    //konstruktory
    kolor();
    kolor(int r, int g, int b);
    //metody
    static double SumaKolorow(int red, int green, int blue)
    {
        return (red+green+blue)/3;
    }
};

#endif
