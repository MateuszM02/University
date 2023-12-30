#ifndef ZMIENNE
#define ZMIENNE

#include "wyrazenie.hpp"
#include <vector>

using namespace std;

class zmienne : public wyrazenie
{
    
private:
    string name;
    static vector<pair<string, double>> zmienna;
    public:
    zmienne(string n, double x) //: zmienna.push_back(n,x) {}
    {
        zmienna.push_back(pair(n,x));
    }
};

#endif
