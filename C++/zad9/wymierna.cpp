#include <math.h>
#include "wymierna.hpp"

namespace obliczenia
{
void wymierna::wypisz()
{
    cout << this->licznik << " \\ " << this->mianownik << endl;
}

void wymierna::update(int x, int y)
{
    if(y == 0)
    { 
        throw divide_by_zero();
    }
    else if(y < 0) return update(-x, -y);
    int size = sqrt(max(abs(x), abs(y)));
    //
    while(x % 2 == 0 && y % 2 == 0)
    {
        x /= 2;
        y /= 2;
    }
    for(int i = 3; i <= size; i++)
    {
        while(x % i == 0 && y % i == 0)
        {
            x /= i;
            y /= i;
        }
    }
    licznik = x;
    mianownik = y;
}

void wymierna::SetLicznik(int x)
{
    update(x, mianownik);
}

void wymierna::SetMianownik(int y)
{
    update(licznik, y);
}

/*-----------------------------------------------------------------------------
  operatory arytmetyczne
-----------------------------------------------------------------------------*/

wymierna wymierna::operator + (wymierna w)
{
    update(licznik * w.mianownik + w.licznik * mianownik, mianownik + w.mianownik);
    return *this;
}

wymierna wymierna::operator - (wymierna w)
{
    update(licznik * w.mianownik - w.licznik * mianownik, mianownik + w.mianownik);
    return *this;
}

wymierna wymierna::operator * (wymierna w) //mnozenie 2 liczb wymiernych
{
    update(licznik * w.licznik, mianownik + w.mianownik);
    return *this;
}

wymierna wymierna::operator / (wymierna w)
{
    update(licznik * w.mianownik, mianownik + w.licznik);
    return *this;
}

//jednoargumentowe

wymierna wymierna::operator - () //do zmiany znaku
{
    update(-licznik, mianownik);
    return *this;
}

wymierna wymierna::operator ! () //odwrotnosc
{
    update(mianownik, licznik);
    return *this;
}

//wypisanie strumienia wyjsciowego

ostream& operator << (ostream &wyj, const wymierna &w)
{
    int x = w.licznik;
    int y = w.mianownik;
	string temp = to_string(x / y);
	wyj << temp;
	return wyj;
}
}
