#ifndef WEKTOR3d
#define WEKTOR3d

#include <iostream>

using namespace std;

class wektor3d : public wektor2d
{
    double z;
public:
    void SetZ(double z) {this->z = z;}
    double GetZ(){return z;}
    //konstruktory
    wektor3d() : wektor2d() {z = 0;}
    wektor3d(double x, double y, double z) : wektor2d(x,y) {this->z = z;}
};

#endif
