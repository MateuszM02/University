#ifndef PUNKT
#define PUNKT

#include <iostream>
#include <math.h>

using namespace std;

class punkt
{
    double x;
    double y;
    //gettery i settery
public:
    double GetX()     {return x; }
    double GetY()     {return y; }
    void SetX(double value) {x = value;}
    void SetY(double value) {y = value;}
    //konstruktory
    punkt() {x = 0; y = 0;}
    punkt(double x, double y) {this->x = x; this->y = y;}
    //metody
    double odleglosc(punkt p)
    {
        return sqrt(pow(x-p.x,2)+pow(y-p.y,2));
    }
    double odleglosc(double x1, double y1)
    {
        return sqrt(pow(x-x1,2)+pow(y-y1,2));
    }
    static double static_odleglosc(punkt p1, punkt p2)
    {
        return sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2));
    }
    static bool wspolliniowe(punkt p1, punkt p2, punkt p3)
    {
        if(static_odleglosc(p1,p2) == static_odleglosc(p1,p3) + static_odleglosc(p2,p3)) return true;
        else if(static_odleglosc(p1,p3) == static_odleglosc(p1,p2) + static_odleglosc(p2,p3)) return true;
        else if(static_odleglosc(p2,p3) == static_odleglosc(p1,p2) + static_odleglosc(p1,p3)) return true;
        else return false;
    }
};

#endif
