using System;

namespace zad1
{
    class Program
    {
        static void Main()
        {
            Drzewo d = new Drzewo(5);
            d.Dodaj(2);
            d.Dodaj(2);
            d.Dodaj(3);
            d.Dodaj(8);
            Console.WriteLine("suma: {0}, ilosc: {1}, wysokosc: {2}, min: {3}, max: {4}",
                d.Suma(), d.Ilosc(), d.Wysokosc(), d.MinWartosc(), d.MaxWartosc());
            Console.WriteLine("zawiera 2? {0}, zawiera 10? {1}", d.CzyZawiera(2), d.CzyZawiera(10));
            d.Wypisz();
            //lista
            Lista L = new Lista(5);
            L.Dodaj(2);
            L.Dodaj(2);
            L.Dodaj(3);
            L.Dodaj(8);
            Console.WriteLine("suma: {0}, ilosc: {1}, min: {2}, max: {3}",
                L.Suma(), L.Ilosc(), L.MinWartosc(), L.MaxWartosc());
            Console.WriteLine("zawiera 2? {0}, zawiera 10? {1}", L.CzyZawiera(2), L.CzyZawiera(10));
            L.Wypisz();
            Console.WriteLine("Lista jako ciag (metoda ToString): {0}",L.ToString());
        }
    }
}
