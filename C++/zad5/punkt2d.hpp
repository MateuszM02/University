#ifndef PUNKT2d
#define PUNKT2d

#include <iostream>
#include "wektor2d.hpp"

using namespace std;

class punkt2d : public punkt
{
public:
    //konstruktory
    punkt2d() : punkt() {}
    punkt2d(double x, double y) : punkt(x,y) {}
    //metody
    void transpozycja(wektor2d w)
    {
        SetX(GetX() + w.GetX());
        SetY(GetY() + w.GetY());
    }
};

#endif
