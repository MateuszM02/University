using System;

namespace zad4
{
    class Program
    {
        static void Main(string[] args)
        {
            //działanie klasy LazyIntList
            LazyIntList lista = new LazyIntList();
            Console.WriteLine("Początkowy rozmiar: {0}", lista.size()); //0
            Console.WriteLine("Wartość 5 elementu: {0}", lista.element(5)); //4
            Console.WriteLine("Rozmiar listy po dodaniu elementów: {0}", lista.size()); //5

            //działanie klasy LazyPrimeList
            LazyPrimeList lista2 = new LazyPrimeList();
            Console.WriteLine("Początkowy rozmiar: {0}", lista2.size()); //0
            Console.WriteLine("Wartość 5 elementu: {0}", lista2.element(5)); //11
            Console.WriteLine("Rozmiar listy po dodaniu elementów: {0}", lista2.size()); //5
        }
    }
}
