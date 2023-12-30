/******************************************************************************

Zadanie 1, kurs C++
Mateusz Mazur

*******************************************************************************/

#include <iostream>
#include <vector>

using namespace std;

vector<int64_t> rozklad(int n);

int main(int rozmiar, char **strLiczba)
{
    if(rozmiar == 1) return 0;
    try
    {
        int64_t liczba = 0;
        for(int i=1;i<rozmiar;i++)
        {
            liczba = stoll(strLiczba[i]);
            cout<<liczba<<" = ";
            vector <int64_t> czynniki = rozklad(liczba);
            for(auto cz: czynniki)
            {
                cout<<cz<<"*";
            }
            cout<<endl;
        }
    }
    catch(const std::invalid_argument& e)
    {
        cerr<<e.what()<<endl;
    }
    return 0;
}

vector<int64_t> rozklad(int n)
{
    int dzielnik=2;
    vector<int64_t> czynniki;
    if(n < 0)
    {
        n = -n;
        czynniki.push_back(-1);
    }
    
    while(n>1)
    {
        if(n%dzielnik==0)
        {
            czynniki.push_back(dzielnik);
            n = n/dzielnik;
        }
        else dzielnik++;
    }
    return czynniki;
}



