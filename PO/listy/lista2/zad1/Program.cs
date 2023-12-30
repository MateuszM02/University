using System;

namespace zad1
{
    class Program
    {
        static void Main()
        {
            //działanie PrimeStream
            IntStream intstr = new PrimeStream();
            for (int i = 0; i < 10; i++)
                Console.WriteLine("{0} liczba naturalna: {1} ", i+1, intstr.next());

            //działanie PrimeStream
            PrimeStream ps = new PrimeStream();
            for(int i=0; i<10; i++)
                Console.WriteLine("{0} liczba pierwsza: {1} ", i+1, ps.next());

            //działanie RandomStream
            RandomStream rs = new RandomStream(1,10);
            Console.WriteLine("Wylosowano liczbę: {0}", rs.next());
            Console.WriteLine("Wylosowano liczbę: {0}", rs.next());

            //działanie RandomWordStream
            RandomWordStream rws = new RandomWordStream();
            Console.WriteLine("Wylosowano ciąg: {0}", rws.next());
            Console.WriteLine("Wylosowano ciąg: {0}", rws.next());
        }
    }
}
