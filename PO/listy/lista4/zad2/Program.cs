using System;

namespace zad2
{
    class Program
    {
        static void Main()
        {
            PrimeCollection pc = new PrimeCollection();

            foreach (int p in pc) // uwaga - petla nieskonczona!
                Console.WriteLine(p);
        }
    }
}
