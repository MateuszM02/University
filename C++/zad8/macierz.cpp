#include "macierz.hpp"

using namespace obliczenia;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------
Funkcje i operatory klasy macierz
------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

const macierz & Mnozenie (const macierz &m, double stala) // mnozenie przez stala
{
    for(int i = 0; i < m.w; i++) //dla kazdego wiersza
    {
        for(int j = 0; j < m.k; j++) //dla kazdej kolumny
        {
            m.tab[i][j] *= stala;
        }
    }
    return m;
}

const macierz & Zmiana (const macierz &p, const macierz &q, bool dodawanie) //dodawanie lub odejmowanie macierzy
{
    if(p.w != q.w) //nie mozna dodawac macierzy o roznej ilosci wierszy
        throw "Nie mozna dodawac macierzy o roznej ilosci wierszy!";
    else if(p.k != q.k) //nie mozna dodawac macierzy o roznej ilosci kolumn
        throw "Nie mozna dodawac macierzy o roznej ilosci kolumn!";
    for(int i = 0; i < p.w; i++) //dla kazdego wiersza
    {
        for(int j = 0; j < p.k; j++) //dla kazdej kolumny
        {
            if(p.tab[i][j].k != q.tab[i][j].k) //nie mozna dodawac macierzy o wektorach roznych rozmiarow
                throw "Nie mozna dodawac macierzy o wektorach roznych rozmiarow!";
            else if(dodawanie) p.tab[i][j] += q.tab[i][j]; //dodawanie macierzy
            else p.tab[i][j] -= q.tab[i][j]; //odejmowanie macierzy
        }
    }
    return p;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

macierz::~macierz() //destruktor
{
    delete []tab;
    tab = NULL;
}

macierz operator - (const macierz &m) // zmiana znaku macierzy
{
    return Mnozenie(m, -1);
}

macierz operator * (const macierz &m, double d) //mnozenie macierzy przez stala (z prawej strony)
{
    return Mnozenie(m, d);
}

macierz operator * (double d, const macierz &m) //mnozenie macierzy przez stala (z lewej strony)
{
    return Mnozenie(m, d);
}

macierz operator + (const macierz &p, const macierz &q) // dodawanie macierzy
{
    return Zmiana(p, q, true);
}

macierz operator - (const macierz &p, const macierz &q) // odejmowanie macierzy
{
    return Zmiana(p, q, false);
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

const macierz & macierz::operator += (const macierz &m) // dodawanie macierzy
{
    return Zmiana(*this, m, true);
}

const macierz & macierz::operator -= (const macierz &m) // odejmowanie macierzy
{
    return Zmiana(*this, m, false);
}

const macierz & macierz::operator *= (double d) //mnozenie macierzy przez stala (z prawej strony)
{
    return Mnozenie(*this, d);
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

macierz operator * (const macierz &p, const macierz &q) //iloczyn macierzy (iloczyn skalarny wektorow na danych pozycjach)
{
    if(p.k != q.w) //nie mozna mnozyc macierzy kiedy ilosc kolumn 1 macierzy jest rozna od ilosci wierszy 2 macierzy
        throw "Nie mozna mnozyc macierzy kiedy ilosc kolumn 1 macierzy jest rozna od ilosci wierszy 2 macierzy!";
    for(int i = 0; i < p.w; i++) //dla kazdego wiersza
    {
        for(int j = 0; j < p.k; j++) //dla kazdej kolumny
        {
            if(p.tab[i][j].k != q.tab[i][j].k) //nie mozna mnozyc macierzy o wektorach roznych rozmiarow
                throw "Nie mozna dodawac macierzy o wektorach roznych rozmiarow!";
            else p.tab[i][j] = p.tab[i][j] * q.tab[i][j]; //iloczyn skalarny wektorow
        }
    }
    return p;
}

macierz operator ~ (const macierz &m) //transpozycja macierzy
{
    if(m.k != m.w) //nie mozna transponowac macierzy niekwadratowej
        throw "Nie mozna transponowac macierzy niekwadratowej!";
    for(int i = 0; i < m.w; i++) //dla kazdego wiersza
    {
        for(int j = i; j < m.k; j++) //dla kazdej kolumny o pozycji nie mniejszej od przekatnej
        {
            wektor temp = m.tab[j][i];
            m.tab[j][i] = m.tab[i][j];
            m.tab[i][j] = temp;
        }
    }
    return m;
}

wektor macierz::operator [] (int i) const // do odczytu wspolczynnika
{
    if(i<0 || i>= this->k || i>= this->w) throw "Zly indeks do odczytu";
    return this->tab[i][0];
}

wektor& macierz::operator [] (int i) // do zapisu wspolczynnika
{
    if(i<0 || i>= this->k || i>= this->w) throw "Zly indeks do zapisu";
    return this->tab[i][0];
}

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------
Funkcje i operatory klasy wektor
------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

wektor & MnozenieW (const wektor &v, double stala) // mnozenie przez stala
{
    for(int i = 0; i < v.k; i++) //dla kazdego elementu wektora
    {
        v.tab[i] *= stala;
    }
    return v;
}

wektor & ZmianaW (const wektor &x, const wektor &y, bool dodawanie) //dodawanie lub odejmowanie wektorow
{
    if(x.k != y.k) //nie mozna dodawac wektorow roznej dlugosci
        throw "Nie mozna dodawac wektorow roznej dlugosci!";
    for(int i = 0; i < x.k; i++) //dla kazdego elementu wektora
    {
        if(dodawanie) x.tab[i] += y.tab[i]; //dodawanie macierzy
        else x.tab[i] -= y.tab[i]; //odejmowanie macierzy
    }
    return x;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

wektor &wektor::operator=(wektor &&w) // przypisanie przenoszace
{
    if (&w != this)
    {
        this->~wektor();
        k = w.k;
        tab = w.tab;
    }
    return *this;
}

wektor &wektor::operator=(const wektor &w) // przypisanie kopiujace
{
    if (&w != this)
    {
        this->~wektor();
        k = w.k;
        tab = new double [k];
        for(int i=0; i < w.k;i++)
        {
            tab[i] = w.tab[i];
        }
    }
    return *this;
}

wektor::~wektor() //destruktor
{
    delete []tab;
    tab = NULL;
}

wektor operator - (const wektor &v) // zmiana znaku
{
    return MnozenieW(v, -1);
}

wektor operator + (const wektor &x, const wektor &y)
{
    return ZmianaW(x, y, true);
}

wektor operator - (const wektor &x, const wektor &y)
{
    return ZmianaW(x, y, false);
}

wektor operator * (const wektor &v, double d)
{
    return MnozenieW(v, d);
}

wektor operator * (double d, const wektor &v)
{
    return MnozenieW(v, d);
}

double operator * (const wektor &x, const wektor &y) // iloczyn skalarny x*y
{
    if(x.k != y.k) //nie mozna wyliczyc iloczynu skalarnego wektorow roznej dlugosci
        throw "Nie mozna wyliczyc iloczynu skalarnego wektorow roznej dlugosci!";
    double suma = 0;
    for(int i = 0; i < x.k; i++)
    {
        suma += x.tab[i] * y.tab[i];
    }
    return suma;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

const wektor & wektor::operator += (const wektor &v)
{
    return ZmianaW(*this, v, true);
}

const wektor & wektor::operator -= (const wektor &v)
{
    return ZmianaW(*this, v, false);
}

const wektor & wektor::operator *= (double d)
{
    return MnozenieW(*this, d);
}

double wektor::operator [] (int i) const // do odczytu wspolczynnika
{
    if(i<0 || i>= this->k) return 0;
    return this->tab[i];
}

double& wielomian::operator [] (int i) // do zapisu wspolczynnika
{
    if(i<0 || i>= this->k) return this->tab[0];
    return this->tab[i];
}
