using System;
using System.Collections.Generic;
using System.Linq;

public class LazyPrimeList : LazyIntList
{
	new public int element(int i) //zwraca i-ty element listy liczb pierwszych
	{
		int rozmiar = size();
		if (rozmiar < i)
		{
			int last = 1;
			for (int n = rozmiar; n < i; n++)
			{
				last = max(last, KolejnaPierwsza(last));
				lista.Add(last);
			}
		}
		return lista.ElementAt(i - 1);
	}
	public int KolejnaPierwsza(int n) //zwraca najmniejszą liczbę pierwszą większą od n
	{
        do
        {
			n++;
        } while (!CzyPierwsza(n));
		return n; 
	}
	public bool CzyPierwsza(int n) //zwraca true jeśli n jest liczbą pierwszą lub false w p.p.
	{
		if (n < 2) return false;
        for (int i = 2; i <= Math.Sqrt(n); i++)
        {
			if (n % i == 0) return false;
        }
		return true; 
	}
	public int max(int a, int b) { return a >= b ? a : b; }
}
