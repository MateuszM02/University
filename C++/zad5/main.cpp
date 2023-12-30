#include <iostream>
#include "kolor.hpp"
#include "kolortransparentny.hpp"
#include "kolornazwany.hpp"
#include "punkt.hpp"
#include "punktnazwany.hpp"
#include "punktkolorowy.hpp"
#include "punktkolorowynazwany.hpp"
#include "punkt2d.hpp"
#include "punkt3d.hpp"

using namespace std;

int main()
{
    kolor k = kolor(); //ok
    kolor k1 = kolor(100,0,50); //ok
    //kolor k2 = kolor(-100,0,500); //rzuca wyjatek
    kolortransparentny kt = kolortransparentny(); //ok
    kolortransparentny kt1 = kolortransparentny(255); //ok
    //kolortransparentny kt2 = kolortransparentny(753); //rzuca wyjatek
    kolornazwany kn = kolornazwany(); //ok
    kolornazwany kn1 = kolornazwany("bialy"); //ok
    //kolornazwany kn2 = kolornazwany("bialy1"); //rzuca wyjatek
    //kolornazwany kn3 = kolornazwany("bia;y"); //rzuca wyjatek
    punkt p = punkt(); //ok
    punkt p1 = punkt(3,4); //ok
    cout<<p1.odleglosc(p)<<endl;
    punktnazwany pn = punktnazwany(); //ok
    punktnazwany pn1 = punktnazwany("Nazwa"); //ok
    punktnazwany pn2 = punktnazwany("Nazwa1"); //ok
    punktnazwany pn3 = punktnazwany("N4zw4"); //ok
    //punktnazwany pn4 = punktnazwany("8azwa"); //rzuca wyjatek
    //punktnazwany pn5 = punktnazwany("Na;wa"); //rzuca wyjatek
    punktkolorowy pk = punktkolorowy(); //ok
    punktkolorowy pk1 = punktkolorowy(100); //ok
    //punktkolorowy pk2 = punktkolorowy(500); //rzuca wyjatek
    punktkolorowynazwany pkn = punktkolorowynazwany(); //ok
    punktkolorowynazwany pkn1 = punktkolorowynazwany("Pkn1"); //ok
    //punktkolorowynazwany pkn2 = punktkolorowynazwany("2Pkn"); //rzuca wyjatek
    //punktkolorowynazwany pkn3 = punktkolorowynazwany("Pu;kt2"); //rzuca wyjatek
    //klasa punkt2d
    punkt2d p2d = punkt2d(1,1); //ok
    wektor2d w = wektor2d(2,3); //ok
    cout<< "Punkt 2d przed transpozycja: "<<p2d.GetX()<<", "<<p2d.GetY()<<endl;
    p2d.transpozycja(w); //ok
    cout<< "Punkt 2d po transpozycji: "<<p2d.GetX()<<", "<<p2d.GetY()<<endl;
    //klasa punkt3d
    punkt3d p3d = punkt3d(1,1,1); //ok
    wektor3d w3 = wektor3d(2,3,4); //ok
    cout<< "Punkt 3d przed transpozycja: "<<p3d.GetX()<<", "<<p3d.GetY()<<", "<<p3d.GetZ()<<endl;
    p3d.transpozycja(w3); //ok
    cout<< "Punkt 3d po transpozycji: "<<p3d.GetX()<<", "<<p3d.GetY()<<", "<<p3d.GetZ()<<endl;
    return 0;
}
