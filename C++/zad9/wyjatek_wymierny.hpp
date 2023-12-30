#ifndef WYJATEK
#define WYJATEK

#include <iostream>

using namespace std;

namespace obliczenia
{
    class wyjatek_wymierny : public logic_error
    {
    public:
        wyjatek_wymierny() : logic_error("Zlapano wyjatek w klasie wymierna!")
        {}
        wyjatek_wymierny(const char* msg) : logic_error(msg)
        {}
    };
    
    class divide_by_zero : public wyjatek_wymierny
    {
    public:
        divide_by_zero() : wyjatek_wymierny("Nie wolno dzielic przez zero!")
        {}
    };
}

#endif
