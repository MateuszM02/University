#ifndef PUNKT_KN
#define PUNKT_KN

#include "punktkolorowy.hpp"
#include "punktnazwany.hpp"

class punktkolorowynazwany : public punktkolorowy, public punktnazwany
{
public:
    //konstruktory
    punktkolorowynazwany() : punktnazwany()  {}
    punktkolorowynazwany(string n) : punktnazwany(n) {}
};

#endif
