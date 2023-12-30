using System;

public class PrimeStream : IntStream
{
	bool CzyPierwsza (int n)
    {
		if (n < 2) return false;
		for(int i=2; i<=Math.Sqrt(n); i++)
		{
			if(n%i == 0) return false;
		}
		return true;
    }
	new public int next()
	{
        while (true) 
		{ 
			liczba++;
			if (CzyPierwsza(liczba)) return liczba;
		}
	}
	new public bool eos()
	{
		try
		{this.next();}
		catch(Exception) 
		{ return true; }
		return false; 
	}
}
