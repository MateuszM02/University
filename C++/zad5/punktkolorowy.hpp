#ifndef PUNKT_KOLOR
#define PUNKT_KOLOR

#include <iostream>
#include "punkt.hpp"
#include "kolortransparentny.hpp"

using namespace std;

class punktkolorowy : public punkt, public kolortransparentny
{
public:
    //konstruktory
    punktkolorowy() : kolortransparentny() {}
    punktkolorowy(int a) : kolortransparentny(a) {}
};

#endif
