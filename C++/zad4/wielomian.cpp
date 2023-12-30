#include "wielomian.h"

///konstruktory i destruktory

wielomian::wielomian(double wspolczynnik) :n(1) // konstruktor jednomianu
{
    a = new double[n];
    a[0] = wspolczynnik;
}

wielomian::wielomian (int stopien, const double wspolczynnik[]) // konstruktor wielomianu
{
    if(stopien < 0)
    {
        throw std::invalid_argument("Potega wielomianu nie moze byc ujemna!");
        return;
    }
    a = new double[stopien];
    for(int i = 0; i < stopien; i++)
    {
        try
        {
            a[i] = wspolczynnik[i];
        }
        catch(std::out_of_range)
        {
            throw std::out_of_range("Nie ma takiego stopnia wielomianu");
        }
    }
}

wielomian::wielomian(const wielomian &w) //konstruktor kopiujacy
{
    n = w.n;
    a = new double [w.n];
    for(int i=0; i<w.n;i++)
    {
        a[i] = w.a[i];
    }
}

wielomian::wielomian(wielomian &&w) //konstruktor przenoszacy
{
    n = w.n;
    a = w.a;
    w.a = nullptr;
}

wielomian::~wielomian() //destruktor
{
    delete []a;
    a = NULL;
}

///operatory przypisania i strumieniowe
wielomian &wielomian::operator=(const wielomian &w) // przypisanie kopiujace
{
    if (&w != this)
    {
        this->~wielomian();
        n = w.n;
        a = new double [n];
        for(int i=0; i < n;i++)
        {
            a[i] = w.a[i];
        }
    }
    return *this;
}

wielomian &wielomian::operator=(wielomian &&w) // przypisanie przenoszace
{
    if (&w != this)
    {
        this->~wielomian();
        n = w.n;
        a = w.a;
    }
    return *this;
}

istream& operator >> (istream &we, wielomian &w)
{
    for(int i = 0; i < w.n; i++)
    we >> w.a[i];
    return we;
}

ostream& operator << (ostream &wy, const wielomian &w)
{
    for(int i = 0; i < w.n; i++)
    wy << w.a[i] << " ";
    return wy;
}

///operatory arytmetyczne
wielomian operator + (const wielomian &u, const wielomian &v)
{
    int max, min;
	if(v.n>u.n)
	{
		max = v.n;
		min = u.n;
	}
	else
	{
		max = u.n;
		min = v.n;
	}
	if(v.n == u.n)
	{
		if(max!=0&&u.a[max]+v.a[max]==0) throw std::invalid_argument("największy współczynnik nie moze byc równy 0");
	}
	double wspolczynniki[max];
	for(int i = 0; i <= min; i++)
	{
		wspolczynniki[i] = u.a[i] + v.a[i];
	}
	for(int i = min + 1; i <= max; i++)
	{
		if(u.n > v.n) wspolczynniki[i] = u.a[i];
		else wspolczynniki[i] = v.a[i];
	}
	wielomian nowy(max,wspolczynniki);
	return nowy;
}

wielomian operator - (const wielomian &u, const wielomian &v)
{
    int max, min;
	if(v.n>u.n)
	{
		max = v.n;
		min = u.n;
	}
	else
	{
		max = u.n;
		min = v.n;
	}
	if(v.n == u.n)
	{
		if(max!=0&&u.a[max]-v.a[max]==0) throw std::invalid_argument("największy współczynnik nie moze byc równy 0");
	}
	double wspolczynniki[max];
	for(int i = 0; i <= min; i++)
	{
		wspolczynniki[i] = u.a[i] - v.a[i];
	}
	for(int i = min + 1; i <= max; i++)
	{
		if(u.n > v.n) wspolczynniki[i] = u.a[i];
		else wspolczynniki[i] = v.a[i];
	}
	wielomian nowy(max,wspolczynniki);
	return nowy;
}

wielomian operator * (const wielomian &u, const wielomian &v)
{
    wielomian temp = wielomian(u);
    for(int i = 0; i < v.n;i++)
    {
        temp.a[i] *= v.a[i];
    }
    return temp;
}

wielomian operator * (const wielomian &w, double c)
{
    if(c==0) throw std::invalid_argument("największy współczynnik byłby równy 0");
	double arr[u.n+1];
	for(int i=0;i<=u.n;i++)
	{
		arr[i]=u.a[i]*c;
	}
	wielomian temp(u.n, arr);
	return temp;
}

wielomian& wielomian::operator += (const wielomian &v)
{
    for(int i = 0; i < this->n;i++)
    {
        this->a[i] += v.a[i];
    }
    return *this;
}

wielomian& wielomian::operator -= (const wielomian &v)
{
    for(int i = 0; i < this->n;i++)
    {
        this->a[i] -= v.a[i];
    }
    return *this;
}

wielomian& wielomian::operator *= (const wielomian &v)
{
    for(int i = 0; i < this->n;i++)
    {
        this->a[i] *= v.a[i];
    }
    return *this;
}

wielomian& wielomian::operator *= (double c)
{
    for(int i = 0; i < this->n;i++)
    {
        this->a[i] *= c;
    }
    return *this;
}

double wielomian::operator () (double x) const // wartosc wielomianu dla x (Schemat Hornera)
{
    double wynik = this->a[0];
    for(int i = 1; i <= this->n; i++)     wynik = wynik*x + this->a[i];
    return wynik;
}

double wielomian::operator [] (int i) const // do odczytu wspolczynnika
{
    if(i<0 || i>= this->n) return 0;
    return this->a[i];
}

double& wielomian::operator [] (int i) // do zapisu wspolczynnika
{
    if(i<0 || i>= this->n) return this->a[0];
    return this->a[i];
}

//funkcje skladowe klasy wielomian

double wielomian::Get_Wspolczynnik(int pozycja)
{
    if(pozycja < 0)
    {
        throw std::invalid_argument("Potega wielomianu nie moze byc ujemna!");
        return 0;
    }
    else if(pozycja >= n)
    {
        throw std::invalid_argument("Potega wielomianu nie moze byc wieksza od zadeklarowanej!");
        return 0;
    }
    else return a[pozycja];
}
void wielomian::Set_Wspolczynnik(int pozycja, double wartosc)
{
    if(pozycja < 0 || pozycja >= n) return;
    else if(wartosc == 0 && pozycja == n - 1)
    {
        throw std::invalid_argument("Wspolczynnik przy najwyzszej potedze nie moze byc 0!");
        return;
    }
    a[pozycja] = wartosc;
}
