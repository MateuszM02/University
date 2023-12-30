using System;

public class RandomStream : IntStream
{
	int minimum;
	int maximum;
	public RandomStream()
	{
		minimum = 0;
		maximum = 100;
	}
	public RandomStream(int max)
	{
		minimum = 0;
		maximum = max;
	}
	public RandomStream(int min, int max)
	{
        minimum = min;
		maximum = max;
	}
	new public int next()
	{
		Random los = new Random();
		return los.Next(minimum, maximum);
	}
	new public bool eos()
	{
		return false;
	}
}
