using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad4
{
    public class Wektor
    {
        int rozmiar;
        float[] wspolrzedna = null;
        //gettery i settery
        public float GetValue(int indeks)
        {
            if (indeks < 0 || indeks >= rozmiar) return 0;
            else return wspolrzedna[indeks];
        }
        public void SetValue(int indeks, float wartosc)
        {
            if(indeks<0 || indeks >= rozmiar) return;
            wspolrzedna[indeks] = wartosc;
        }
        //konstruktor
        public Wektor(int n) 
        {
            rozmiar = n;
            wspolrzedna = new float[rozmiar];
            for (int i = 0; i < rozmiar; i++) wspolrzedna[i] = 0;
        }
        public Wektor(int n, int[] tab)
        {
            rozmiar = n;
            wspolrzedna = new float[rozmiar];
            for (int i = 0; i < rozmiar; i++) wspolrzedna[i] = tab[i];
        }
        //metody
        public Wektor DodajWektory(Wektor w)
        {
            if (rozmiar != w.rozmiar) return this;
            for (int i = 0; i < rozmiar; i++)
            {
                wspolrzedna[i] += w.wspolrzedna[i];
            }
            return this; 
        }
        public Wektor MnozennieWektoraPrzezSkalar(float skalar)
        {
            for (int i = 0; i < rozmiar; i++)
            {
                wspolrzedna[i] *= skalar;
            }
            return this;
        }
        public float IloczynSkalarnyWektorow(Wektor w)
        {
            if (rozmiar != w.rozmiar) return 0;
            float iloczyn = 0;
            for (int i = 0; i < rozmiar; i++)
            {
                iloczyn += wspolrzedna[i] * w.wspolrzedna[i];
            }
            return iloczyn;
        }
        public float norma()
        {
            float dlugosc = 0;
            for (int i = 0; i < rozmiar; i++)
            {
                int[] tab = new int[rozmiar];
                for (int j = 0; j < rozmiar; j++)
                { 
                    if (i == j) tab[j] = 1;
                    else tab[j] = 0; 
                }
                dlugosc += wspolrzedna[i] * IloczynSkalarnyWektorow(new Wektor(rozmiar,tab));
            }
            return dlugosc;
        }
    }
}
