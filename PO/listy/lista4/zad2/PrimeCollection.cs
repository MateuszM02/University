using System;
using System.Collections;
//-------------------------------------------------------------------------------------------------------

public class PrimeCollection : IEnumerable
{
    public PrimeCollection()
    {
        liczba = 2;
    }

    int liczba;
    public int GetValue() { return liczba; }
    
    IEnumerator IEnumerable.GetEnumerator()
    {
        return (IEnumerator)GetEnumerator();
    }

    public PrimeCollectionEnum GetEnumerator()
    {
        return new PrimeCollectionEnum(liczba);
    }
}

public class PrimeCollectionEnum : IEnumerator
{
    int liczba;
    int indeks = -1;
    
    public PrimeCollectionEnum(int liczba)
    {
        this.liczba = liczba;
    }

    bool is_first(int n)
    {
        for (int i = 2; i <= Math.Sqrt(n); i++)
        {
            if (n % i == 0) return false;
        }
        return true;
    }

    public bool MoveNext()
    {
        while (!is_first(liczba))
        {
            liczba++;
        }
        indeks++;
        Console.Read();
        return (indeks < int.MaxValue);
    }

    public void Reset()
    {
        indeks = -1;
    }

    object IEnumerator.Current
    {
        get {return Current;}
    }

    public int Current
    {
        get
        {
            try
            {
                return liczba++;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
