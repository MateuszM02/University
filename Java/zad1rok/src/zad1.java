// javac src/zad1.java - kompilacja
// java src/zad1 - uruchomienie

import java.util.Scanner;

public class zad1 
{
    // tablica z wybranymi liczbami rzymskimi
    private static String[] rzymskie = {
        "M", "CM", "D", "CD", "C","XC", "L", "XL", "X", "IX", "V", "IV", "I"
        };
    // tablica z wybranymi liczbami arabskimi
    private static int[] arabskie = {
        1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1
        };
    
    // --------------------------------------------------------------------------------------------

    // przeksztalca liczbe w napis oznaczajacy liczbe rzymska    
    public static String rzymska(int n) 
    {
        if (n < 1 || n>= 4000)
            throw new IllegalArgumentException("liczba " + n + " spoza zakresu 1-3999");
        String napis = "";       
        for(int i = 0; i < arabskie.length; i++)
        {
            while(n >= arabskie[i])
            {
                n -= arabskie[i];
                napis += rzymskie[i];
            }
        }
        return napis;
    }

    // zwraca patrona roku chinskiego
    public static String patron(int rok)
    {
        return switch (rok % 12) {
            case 0 -> "małpa";
            case 1 -> "kurczak";
            case 2 -> "pies";
            case 3 -> "świnia";
            case 4 -> "szczur";
            case 5 -> "bawół";
            case 6 -> "tygrys";
            case 7 -> "królik";
            case 8 -> "smok";
            case 9 -> "wąż"; 
            case 10 -> "koń";
            case 11 -> "owca";
            default -> throw new IllegalArgumentException("reszta z dzielenia przez 12 musi byc z przedzialu 0-11");
        };
    }

    public static void main(String[] args)
    {
        System.out.println("Pozbądź się złudzeń i nie złość na próżno!");
        System.out.println("POZBĄDŹ SIĘ ZŁUDZEŃ I NIE ZŁOŚĆ NA PRÓŻNO!");
        /*
        Scanner scanner = new Scanner(System.in); //, "UTF-8");
        String imie = scanner.next();
        int rok = scanner.nextInt();
        scanner.close();
        System.out.println("Witaj " + imie + "! Twoj rok to " + rzymska(rok) + ", patronem twojego roku jest " + patron(rok) + ".");
    */}
}
