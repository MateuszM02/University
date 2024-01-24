package code;

import java.util.LinkedList;

public final class LiczbyPierwsze 
{
    private final static int POTEGA2 = 21;
    private final static int ROZMIAR = 1 << POTEGA2;
    private final static int[] SITO = new int[ROZMIAR];
    
    // potrzebny jest statyczny blok inicjalizacyjny dla sita -------------------------------------
    static 
    {
        for (int i = 2; i < ROZMIAR; i++) 
        {
            if (SITO[i] == 0) // i jest liczba pierwsza
            {
                for (int j = i; j < ROZMIAR; j += i) // dla kazdej wielokrotnosci i
                {
                    if (SITO[j] == 0) // i to jest najmniejszy pierwszy dzielnik j
                    {
                        SITO[j] = i;
                    }
                }
            }
        }
    }

    // sprawdza czy liczba > ROZMIAR jest pierwsza ------------------------------------------------
    public static boolean czyDuzaPierwsza (long x)
    {
        if (x % 2 == 0 || x % 3 == 0)
        {    
            return false;
        }
        for (long i = 5; i < (long)Math.sqrt(x); i+=6) 
        {
            if (x % i == 0 || x % (i+2) == 0) 
            {  
                return false;                         
            }
        } 
        return true;
    }

    // sprawdza, czy wartosc x jest liczba pierwsza -----------------------------------------------
    public static boolean czyPierwsza (long x) 
    { 
        if (x < 2)
            return false;
        else if (x < ROZMIAR)
            return SITO[(int)x] == x;
        else
            return czyDuzaPierwsza(x);
    }

    // zwraca liste czynnikow pierwszych liczby x -------------------------------------------------
    public static long[] naCzynnikiPierwsze (long x) 
    {
        if (x == -1 || x == 0 || x == 1)
        {
            return new long[]{x};
        }
        LinkedList<Long> czynniki = new LinkedList<Long>();// lista czynnikow pierwszych

        if (x < 0)
        {
            if (x != Long.MIN_VALUE)
            {
                x *= -1;
                czynniki.addLast(-1L);
            }
            else // nie mozna zrobic *(-1) dla Long.MIN_VALUE bo bedzie overflow
            {
                x /= -2;
                czynniki.addLast(-1L);
                czynniki.addLast(2L);
            }
        }
        
        // szukanie kolejnych czynnikow pierwszych
        while (x % 2 == 0)
        {
            czynniki.addLast(2L);
            x /= 2;
        }
        while (x % 3 == 0)
        {
            czynniki.addLast(3L);
            x /= 3;
        }
        long aktDzielnik = 5L;
        long maxDzielnik = (long)Math.sqrt(x);

        // optymalizacja - w kazdym kroku sprawdzamy, 
        // czy zmniejszylismy juz liczbe do rozmiaru, dla ktorego mozna korzystac z sita
        while (x > 1 && aktDzielnik <= maxDzielnik)
        {
            if (x < ROZMIAR) // korzystamy z sita
            {
                while (x > 1)
                {
                    czynniki.addLast((long)SITO[(int)x]);
                    x /= SITO[(int)x];
                }
            }
            else // za duze dla sita, musimy najpierw zmniejszyc
            {
                while(x % aktDzielnik == 0)
                {
                    czynniki.addLast(aktDzielnik);
                    x /= aktDzielnik;
                }
                while(x % (aktDzielnik + 2) == 0)
                {
                    czynniki.addLast(aktDzielnik + 2);
                    x /= (aktDzielnik + 2);
                }
                aktDzielnik += 6;
            }
        }
        if (x > 1) // liczba byla pierwsza, zatem dodaj ja sama do listy czynnikow
            czynniki.addLast(x);
        
        // przerob na tablice statyczna
        int ilosc = czynniki.size();
        long[] tab = new long[ilosc];
        for (int i = 0; i < ilosc; i++) 
        {
            tab[i] = czynniki.removeFirst();
        }
        return tab;
    }
}