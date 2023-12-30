using System;

public class IntStream
{
	protected int liczba;
	public IntStream()
	{
		liczba = 0;
	}
	public int next() { liczba++; return liczba; }
	public bool eos() 
	{
		if (liczba == int.MaxValue) return true;
		else return false;
	}
	public void reset() { liczba = 0; }
}
