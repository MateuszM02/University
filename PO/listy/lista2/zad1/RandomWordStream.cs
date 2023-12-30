using System;

public class RandomWordStream : IntStream
{
	PrimeStream ps = new PrimeStream();
	new public string next() 
	{
		string los = new string("");
		int val = ps.next();
		//
		RandomStream rs = new RandomStream(26);
		//
        for (int i = 0; i < val; i++)
        {
			int index = rs.next() + 65;
			los = los.Insert(i,Char.ToString((char)index));
        }
		return los; 
	}
}
