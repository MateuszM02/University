#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//--------------------------------------------------------

typedef enum
{
    trojkat, kolo, kwadrat,
}typfig;

typedef struct
{
    typfig typ;
    int dlugosc; //dla trojkata i kwadratu to dlugosc boku,
    //dla kola to dlugosc promienia
    int x;
    int y;
}Figura;

Figura *Nowy_Trojkat(int dl, int x, int y);
Figura *Nowy_Kolo(int dl, int x, int y);
Figura *Nowy_Kwadrat(int dl,int x, int y);

float pole(Figura *f);
void przesun(Figura *f, float x, float y);
void show(Figura *f);
float sumapol(Figura* f[], int size);

//--------------------------------------------------------

int main()
{
    Figura *f = Nowy_Kwadrat(5,1,1);
    /*pole
    float pole1 = pole(f);
    printf("pole: %f\n",pole1);*/
    /*przesun
    printf("%d %d %d\n",f->dlugosc, f->x,f->y);
    przesun(f,2,3);
    printf("%d %d %d\n",f->dlugosc, f->x,f->y);*/
    /*pokaz
    show(f);*/
    /*suma pol figur
    float suma = sumapol(Tablica,Rozmiar_Tablicy);
    printf("%f\n,suma")*/
    return 0;
}

//--------------------------------------------------------

Figura *Nowy_Trojkat(int dl, int x, int y)
{
    Figura *f = malloc(sizeof(Figura));
    f->typ = trojkat;
    if(dl >= 0)    f->dlugosc = dl;
    else {printf("Podaj dodatnia dlugosc\n"); f->dlugosc = 0;}
    f->x = x;
    f->y = y;
    return f;
}

Figura *Nowy_Kolo(int dl, int x, int y)
{
    Figura *f = malloc(sizeof(Figura));
    f->typ = kolo;
    if(dl >= 0)    f->dlugosc = dl;
    else {printf("Podaj dodatnia dlugosc\n"); f->dlugosc = 0;}
    f->x = x;
    f->y = y;
    return f;
}

Figura *Nowy_Kwadrat(int dl, int x, int y)
{
    Figura *f = malloc(sizeof(Figura));
    f->typ = kwadrat;
    if(dl >= 0)    f->dlugosc = dl;
    else {printf("Podaj dodatnia dlugosc\n"); f->dlugosc = 0;}
    f->x = x;
    f->y = y;
    return f;
}

float pole(Figura *f)
{
    switch(f->typ)
    {
        case trojkat: return f->dlugosc*f->dlugosc*sqrt(3)/4;
        case kolo: return M_PI*f->dlugosc*f->dlugosc;
        case kwadrat: return f->dlugosc*f->dlugosc;
        default: return 0;
    }
}

void przesun(Figura *f, float x, float y)
{
    f->x += x;
    f->y += y;
}

void show(Figura *f)
{
    switch(f->typ)
    {
        case trojkat: printf("Trojkat, "); break;
        case kwadrat: printf("Kwadrat, "); break;
        case kolo: printf("Kolo, "); break;
        default: printf("Inna figura, "); break;
    }
    printf("%d %d\n",f->x,f->y);
}

float sumapol(Figura* f[], int size)
{
    float suma = 0;
    for(int i=0;i<size;i++)
    {
        suma += pole(f[i]);
    }
    return suma;
}

//--------------------------------------------------------
