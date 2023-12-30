#ifndef ZMIENNA
#define ZMIENNA

#include <iostream>

using namespace std;

class zmienna
{
    public:
        zmienna ();
        zmienna (string nazwa);
        zmienna (string nazwa, double wartosc);
        
        void SetValue(int wartosc);
        double GetValue();
        string GetName();

    private:
        string nazwa;
        double wartosc;
};

#endif
