#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    int licznik;
    int mianownik;
}Ulamek;

Ulamek *NowyUlamek(int num, int denom);
void show(Ulamek *u);

Ulamek *DodajNowy(Ulamek *u1, Ulamek *u2);
Ulamek *OdejmijNowy(Ulamek *u1, Ulamek *u2);
Ulamek *PomnozNowy(Ulamek *u1, Ulamek *u2);
Ulamek *PodzielNowy(Ulamek *u1, Ulamek *u2);

void DodajWsk(Ulamek *u1, Ulamek *u2);
void OdejmijWsk(Ulamek *u1, Ulamek *u2);
void PomnozWsk(Ulamek *u1, Ulamek *u2);
void PodzielWsk(Ulamek *u1, Ulamek *u2);

int main()
{
    Ulamek *u1 = NowyUlamek(1,2);
    Ulamek *u2 = NowyUlamek(2,3);
    PodzielWsk(u1,u2);
    printf("%d %d\n",u2->licznik,u2->mianownik);
    return 0;
}

Ulamek *NowyUlamek(int num, int denom)
{
    Ulamek *u = malloc(sizeof(Ulamek));
    u->licznik = num;
    if(denom != 0)  u->mianownik = denom;
    else
    {
        printf("Mianownik licznika nie moze byc 0!\n");
        u->mianownik = 1;
    }
    return u;
}

void show(Ulamek *u)
{
    printf("%d\n",u->licznik / u->mianownik);
}

//funkcje arytmetyczne

Ulamek *DodajNowy(Ulamek *u1, Ulamek *u2)
{
    Ulamek *ulamek = malloc(sizeof(Ulamek));
    int a = u1->licznik * u2->mianownik;
    int b = u2->licznik * u1->mianownik;
    ulamek->licznik = a + b;
    ulamek->mianownik = u1->mianownik * u2->mianownik;
    return ulamek;
}

Ulamek *OdejmijNowy(Ulamek *u1, Ulamek *u2)
{
    Ulamek *ulamek = malloc(sizeof(Ulamek));
    int a = u1->licznik * u2->mianownik;
    int b = u2->licznik * u1->mianownik;
    ulamek->licznik = a - b;
    ulamek->mianownik = u1->mianownik * u2->mianownik;
    return ulamek;
}

Ulamek *PomnozNowy(Ulamek *u1, Ulamek *u2)
{
    Ulamek *ulamek = malloc(sizeof(Ulamek));
    ulamek->licznik = u1->licznik * u2->licznik;
    ulamek->mianownik = u1->mianownik * u2->mianownik;
    return ulamek;
}

Ulamek *PodzielNowy(Ulamek *u1, Ulamek *u2)
{
    Ulamek *ulamek = malloc(sizeof(Ulamek));
    ulamek->licznik = u1->licznik * u2->mianownik;
    if(u2->licznik != 0)
        ulamek->mianownik = u1->mianownik * u2->licznik;
    else
    {
        printf("Nie mozna dzielic przez 0!\n");
        ulamek->mianownik = 1;
    }
    return ulamek;
}

//

void DodajWsk(Ulamek *u1, Ulamek *u2)
{
    int a = u1->licznik * u2->mianownik;
    int b = u2->licznik * u1->mianownik;
    u2->licznik = a + b;
    u2->mianownik = u1->mianownik * u2->mianownik;
}

void OdejmijWsk(Ulamek *u1, Ulamek *u2)
{
    int a = u1->licznik * u2->mianownik;
    int b = u2->licznik * u1->mianownik;
    u2->licznik = a - b;
    u2->mianownik = u1->mianownik * u2->mianownik;
}

void PomnozWsk(Ulamek *u1, Ulamek *u2)
{
    u2->licznik = u1->licznik * u2->licznik;
    u2->mianownik = u1->mianownik * u2->mianownik;
}

void PodzielWsk(Ulamek *u1, Ulamek *u2)
{
    int pom = u1->licznik * u2->mianownik;
    if(u2->licznik != 0)
        u2->mianownik = u1->mianownik * u2->licznik;
    else
    {
        printf("Nie mozna dzielic przez 0!\n");
        u2->mianownik = 1;
    }
    u2->licznik = pom;
}
