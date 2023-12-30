using System;
using System.Collections.Generic;
using System.Linq;

public class LazyIntList
{
	protected List<int> lista;
	public LazyIntList() { lista = new List<int>(); }
	public int element (int i) //zwraca i-ty element listy liczb pierwszych
	{
		int rozmiar = size();
		if(rozmiar < i)
		{
			for(int n=rozmiar;n<i;n++)		lista.Add(n);
		}
		return lista.ElementAt(i-1); 
	}
	public int size() { return lista.Count; }
}
