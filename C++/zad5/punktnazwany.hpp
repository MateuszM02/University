#ifndef PUNKT_NAZWA
#define PUNKT_NAZWA

#include <string>
#include "punkt.hpp"

class punktnazwany : public virtual punkt
{
    string nazwa;
    //gettery i settery
public:
    string GetNazwa()     {return nazwa; }
    void SetNazwa(string n)
    {
        if((int)n[0] < 65 || (int)n[0] > 122 || ( ((int)n[0] >= 91) && ((int)n[0] <= 96)))
            throw new invalid_argument("Niepoprawna nazwa!");
        string liczby = "0123456789";
        for(int i=1; i<n.length(); i++)
        {
            if((int)n[i] < 65 || (int)n[i] > 122 || ( ((int)n[i] >= 91) && ((int)n[i] <= 96)))
            {
                for(int indeks = 0; indeks < 10; indeks++)
                {
                    if(n[i] == liczby[indeks]) goto end;
                }
                throw new invalid_argument("Niepoprawna nazwa!");
            }
        }
        end: nazwa = n;
    }
    //konstruktory
    punktnazwany() : punkt() {nazwa = "";}
    punktnazwany(string n) : punkt() { SetNazwa(n); }
};

#endif
