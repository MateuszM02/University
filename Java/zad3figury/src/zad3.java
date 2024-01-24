import figury.*;

// jar cvf figury.jar figury/*.class // tworzenie pliku .jar
// jar tf figury.jar // uruchomienie pliku .jar

// javac -cp "figury.jar;." zad3.java // kompilacja testow (Windows)
// java -ea -cp "figury.jar;." zad3 // uruchomienie testow (Windows)

public class zad3 // program do testowania funkcji z plik .jar
{
    // #region Dane do testow
    // testowe punkty
    static Punkt punkt0 = new Punkt(0, 0);
    static Punkt punkt1 = new Punkt(1, 0);
    static Punkt punkt2 = new Punkt(0, 1);
    static Punkt punkt3 = new Punkt(2, 5);
    static Punkt punkt4 = new Punkt(3, 7); // wspolliniowe z punkt3 i punkt4
    static Punkt punkt5 = new Punkt(-1, 0); // odbicie punkt3 wzgledem prostej1 y = -x
    static Punkt punkt6 = new Punkt(1, 3);

    // testowe odcinki
    static Odcinek odcinek1 = new Odcinek(punkt6, punkt3); // (1, 3) - (2, 5)
    static Odcinek odcinek2 = new Odcinek(punkt3, punkt4); // (2, 5) - (3, 7)
    static Odcinek odcinek3 = new Odcinek(punkt6, new Punkt(-1, 4)); // (1, 3) - (-1, 4)
    static Odcinek odcinek4 = new Odcinek(new Punkt(-5, -2), new Punkt(-7, -3)); // (-5, -2) - (-7, -3), odbicie o2 wzgledem (y = -x)

    // testowe trojkaty
    static Trojkat trojkat1 = new Trojkat(punkt0, punkt1, punkt2); // (0, 0), (1, 0), (0, 1)
    static Trojkat trojkat2 = new Trojkat(new Punkt(1, 2), new Punkt(2, 2), punkt6); // trojkat1 przesuniety o [1, 2]
    static Trojkat trojkat3 = new Trojkat(new Punkt(1, 2), new Punkt(0, 2), new Punkt(1, 1)); // obrot 180* trojkat2 wzgledem (1, 2)
    static Trojkat trojkat4 = new Trojkat(new Punkt(-2, -1), new Punkt(-2, -2), new Punkt(-3, -1)); // odbicie trojkat2 wzgledem (y = -x)

    // testowe wektory
    static Wektor wektor1 = new Wektor(1, 2); // odc1 + w1 -> odc2
    static Wektor wektor2 = new Wektor(2, 4); // punkt3 + w2 -> punkt4
    static Wektor wektor3 = new Wektor(-3, -6); // w1 + w2 + w3 = (0, 0)

    // testowe proste
    static Prosta prosta1 = new Prosta(0, 1, 0); // y = 0
    static Prosta prosta2 = new Prosta(1, 1, 0); // y = -x
    static Prosta prosta3 = new Prosta(-1, 1, 0); // y = x
    static Prosta prosta4 = new Prosta(0, 1, -2); // y = 2
    // #endregion

    //#region Testy funkcji
    static void testyPunkt()
    {
        // testy Punkt - przesun, obroc, odbij
        assert punkt3.equals(punkt2.przesun(wektor2)); // p3 + w1 = p4
        assert punkt2.equals(punkt1.obroc(punkt0, 90)); // obrot 90* (1, 0) wzgledem (0, 0) -> (0, 1)
        assert punkt6.equals(punkt4.obroc(punkt3, 180)); // obrot 180* (3, 7) wzgledem (2, 5) -> (1, 2)
        assert new Punkt(0, -1).equals(punkt2.odbij(prosta1)); // (0, 1) + (y = 0) -> (0, -1)
        assert punkt5.equals(punkt2.odbij(prosta2)); // (0, 1) + (y = -x) -> (-1, 0)
    }

    static void testyOdcinek()
    {
        // testy Odcinek - error (2 identyczne punkty), przesun, obroc, odbij
        try 
        {
            new Odcinek(punkt0, punkt0); // Jesli nie wywola wyjatku, to cos jest nie tak
            assert false : "Powinien rzucic IllegalArgumentException - 2 equals punkty nie moga tworzyc odcinka";
        } 
        catch (IllegalArgumentException e) // Wyjątek został poprawnie rzucony
        {
            assert e.getMessage().equals(Odcinek.equalError);
        }
        assert odcinek2.equals(odcinek1.przesun(wektor1)); // [(1, 3) - (2, 5)] + [1, 2] -> [(2, 5) - (3, 7)]
        assert odcinek3.equals(odcinek1.obroc(punkt6, 90)); // [(1, 3) - (2, 5)] obrot 90* wzgledem (1, 3) -> [(1, 3) - (-1, 4)]
        assert odcinek4.equals(odcinek2.odbij(prosta2)); // [(2, 5) - (3, 7)] odbicie wzgledem (y = -x) -> [(-5, -2) - (-7, -3)]
    }

    static void testyTrojkat()
    {
        // testy Trojkat - error (3 punkty wspolliniowe), przesun, obroc, odbij
        try 
        {
            new Trojkat(punkt0, punkt1, punkt5); // wszystkie maja y = 0
            assert false : "Powinien rzucic IllegalArgumentException - 3 punkty wspolliniowe nie moga tworzyc trojkata";
        } 
        catch (IllegalArgumentException e) // Wyjątek został poprawnie rzucony
        {
            assert e.getMessage().equals(Trojkat.errorMessage);
        }
        assert trojkat2.equals(trojkat1.przesun(wektor1));
        assert trojkat3.equals(trojkat2.obroc(new Punkt(1, 2), 180));
        assert trojkat4.equals(trojkat2.odbij(prosta2));
    }

    static void testyWektor()
    {
        // testy Wektor - zlozWektory
        Wektor wTest = Wektor.zlozWektory(wektor1, wektor2);
        assert wTest.equals(new Wektor(3, 6)); // (1, 2) + (2, 4) = (3, 6)
        assert Wektor.zlozWektory(wTest, wektor3).equals(new Wektor(0, 0)); // (1, 2) + (2, 4) + (-3, -6) = (0, 0)
    }

    static void testyProsta()
    {
        // testy Prosta - czyRownolegle, czyProstopadle, prostopadla, przesunProsta,
        // punktPrzeciecia
        assert Prosta.CzyProsteRownolegle(prosta1, prosta4); // y = 0, y = 2 sa rownolegle
        assert !Prosta.CzyProsteRownolegle(prosta2, prosta3); // y = -x, y = x nie sa rownolegle
        assert Prosta.CzyProsteProstopadle(prosta2, prosta3); // y = -x, y = x sa prostopadle
        assert !Prosta.CzyProsteProstopadle(prosta1, prosta4); // y = 0, y = 2 nie sa prostopadle
        assert Prosta.punktPrzeciecia(prosta1, prosta2).equals(punkt0); // y = 0, y = -x -> (0, 0)
        assert Prosta.punktPrzeciecia(prosta3, prosta4).equals(new Punkt(2, 2)); // y = x, y = 2 -> (2, 2)
        try 
        {
            Prosta.punktPrzeciecia(prosta1, prosta4); // proste rownolegle, brak punktow wspolnych
            assert false : "Powinien rzucic IllegalArgumentException - 2 proste rownolegle nie maja punktow wspolnych";
        } catch (IllegalArgumentException e) // Wyjątek został poprawnie rzucony
        {
            assert e.getMessage().equals(Prosta.rownolegleError);
        }
        try 
        {
            new Prosta(0, 0, 1); // proste rownolegle, brak punktow wspolnych
            assert false : "Powinien rzucic IllegalArgumentException - prosta nie moze byc postaci C = 0";
        } catch (IllegalArgumentException e) // Wyjątek został poprawnie rzucony
        {
            assert e.getMessage().equals(Prosta.zlaProstaError);
        }
    }
    //#endregion

    public static void main(String[] args) 
    {
        testyPunkt();
        testyOdcinek();
        testyTrojkat();
        testyWektor();
        testyProsta();
    }
}
