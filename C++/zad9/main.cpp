#include <iostream>
#include "wymierna.hpp"
#include "wyjatek_wymierny.hpp"

using namespace std;
using namespace obliczenia;

int main()
{
    wymierna w = wymierna(8,-2); //w = 8 / (-2) => (-4) / 1
    w.wypisz(); //w = (-4) / 1
    
    w.update(w.GetLicznik(),-2); //w = (-4) / (-2) => 2 / 1
    w.wypisz(); //w = 2 / 1
    
    w.SetMianownik(-2); //w = 2 / (-2) => (-1) / 1
    w.wypisz(); //w = (-1) / 1
    
    try{
    w.SetMianownik(0); //error - rzuca wyjatek
    }
    catch(divide_by_zero d)
    {
        cout << "Zlapano wyjatek: " << d.what() << endl;
    }
    
    w.update(3, 8); //w = 3 / 8
    w.wypisz(); //w = 3 / 8
    
    -w; //w = (-3) / 8
    w.wypisz(); //w = (-3) / 8
    
    !w; //w = (-8) / 3
    w.wypisz(); //w = (-8) / 3
    
    double wartosc = w; //korzystamy z operatora rzutowania na typ double
    cout << wartosc << endl; //-2.666
    int wartosc_zaokr = w; //korzystamy z operatora jawnego rzutowania na typ int
    cout << wartosc_zaokr << endl; //-2
    
    cout << w; //-2
    return 0;
}
