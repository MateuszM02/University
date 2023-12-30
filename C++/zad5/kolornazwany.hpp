#ifndef NAZWANY
#define NAZWANY

#include <iostream>
#include "kolortransparentny.hpp"

using namespace std;

class kolornazwany : public kolortransparentny
{
    string nazwa;
    //gettery i settery
public:
    string GetNazwa()     {return nazwa; }
    void SetNazwa(string n) 
    {
        for(int i=0; i<n.length(); i++)
        {
            if((int)n[i] < 65 || (int)n[i] > 122 || ( ((int)n[i] >= 91) && ((int)n[i] <= 96)))
            throw new invalid_argument("Niepoprawna nazwa!");
        }
        nazwa = n;
    }
    //konstruktory
    kolornazwany() : kolortransparentny() {nazwa = "";}
    kolornazwany(string n) : kolortransparentny() { SetNazwa(n); }
};

#endif
