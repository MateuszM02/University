package code;
// java -ea code.testy

import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;

public final class testy 
{
    // uruchamia wszystkie testy
    public static void main(String[] args) throws NoSuchMethodException, SecurityException, IllegalAccessException, InvocationTargetException
    {
        uruchom();
    }

    public static void uruchom() throws NoSuchMethodException, SecurityException, IllegalAccessException, InvocationTargetException
    {
        for(int i = 0; i <= 11; i++)
        {
            testy.class.getMethod("testCzyPierwsza"+i).invoke(null);
        }
        for(int i = 0; i <= 7; i++)
        {
            testy.class.getMethod("testNaCzynnikiPierwsze"+i).invoke(null);
        }
    }

    // testy metody czyPierwsza -------------------------------------------------------------------
    
    public static void testCzyPierwsza0()
    {
        assert !LiczbyPierwsze.czyPierwsza(0);
    }
    public static void testCzyPierwsza1()
    {
        assert !LiczbyPierwsze.czyPierwsza(1);
    }
    public static void testCzyPierwsza2()
    {
        assert LiczbyPierwsze.czyPierwsza(2);
    }
    public static void testCzyPierwsza3()
    {
        assert !LiczbyPierwsze.czyPierwsza(4); // 2 * 2
    }
    public static void testCzyPierwsza4()
    {
        assert LiczbyPierwsze.czyPierwsza(5);
    }
    public static void testCzyPierwsza5()
    {
        assert LiczbyPierwsze.czyPierwsza(29);
    }
    public static void testCzyPierwsza6()
    {
        assert !LiczbyPierwsze.czyPierwsza(529); // 23 * 23
    }
    public static void testCzyPierwsza7()
    {
        assert LiczbyPierwsze.czyPierwsza(2137);
    }
    public static void testCzyPierwsza8()
    {
        assert !LiczbyPierwsze.czyPierwsza(3721); // 61 * 61
    }
    public static void testCzyPierwsza9()
    {
        assert LiczbyPierwsze.czyPierwsza(10007);
    }
    public static void testCzyPierwsza10()
    {
        assert !LiczbyPierwsze.czyPierwsza(-5); // ujemne nigdy nie sa pierwsze
    }
    public static void testCzyPierwsza11()
    {
        assert LiczbyPierwsze.czyPierwsza(9223372036854775783L); // najwieksza liczba pierwsza w long
    }

    // testy metody naCzynnikiPierwsze ------------------------------------------------------------
    
    public static void testNaCzynnikiPierwsze0()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(0), new long[]{0});
    }
    public static void testNaCzynnikiPierwsze1()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(-1), new long[]{-1});
    }
    public static void testNaCzynnikiPierwsze2()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(-60), new long[]{-1, 2, 2, 3, 5});
    }
    public static void testNaCzynnikiPierwsze3()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(8), new long[]{2, 2, 2});
    }
    public static void testNaCzynnikiPierwsze4()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(10), new long[]{2, 5});
    }
    public static void testNaCzynnikiPierwsze5()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(169), new long[]{13, 13});
    }
    public static void testNaCzynnikiPierwsze6()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(770), new long[]{2, 5, 7, 11});
    }
    public static void testNaCzynnikiPierwsze7()
    {
        assert Arrays.equals(LiczbyPierwsze.naCzynnikiPierwsze(-770), new long[]{-1, 2, 5, 7, 11});
    }
}
