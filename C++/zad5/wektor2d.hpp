#ifndef WEKTOR2d
#define WEKTOR2d

#include <iostream>

using namespace std;

class wektor2d : public punkt
{
public:
    //konstruktory
    wektor2d() : punkt() {}
    wektor2d(double x, double y) : punkt(x,y) {}
};

#endif
