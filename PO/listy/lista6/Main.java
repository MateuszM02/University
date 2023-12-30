/******************************************************************************

Zadanie 4, Lista 6
Programowanie Obiektowe
Mateusz Mazur

*******************************************************************************/
import java.util.*;

public class Main
{
	public static void main(String[] args) 
	{
	    ArrayList<Integer> tab = new ArrayList<Integer>();
	    for(int i = 0; i < 10; i=Val(i))
	        tab.add(i*i%10);
	    Merge<Integer> m = new Merge<Integer>(tab);
		
		System.out.print("przed sortowaniem liczb: ");
		m.PrintAll();
		tab = m.MergeSort(tab);
		System.out.print("\n    po sortowaniu liczb: ");
		
		for(Integer i : tab)
		    System.out.print(i+" ");
		
		System.out.println();
		System.out.println();
		
		//---------------------------------------------------
		
		ArrayList<Rzadzacy> tab2 = new ArrayList<Rzadzacy>();
	    for(int i = 0; i < 10; i=Val(i))
	        tab2.add(new Rzadzacy("imie"+(i%10),"nazwisko"+(i%12),"narodowosc"+(i%8)));
	    Merge<Rzadzacy> m2 = new Merge<Rzadzacy>(tab2);
		
		System.out.print("przed sortowaniem rzadzacych (wg nazwisk): ");
		for(Rzadzacy i : tab2)
		System.out.print(i.GetNazwisko()+" ");
		tab2 = m2.MergeSort(tab2);
		System.out.print("\n    po sortowaniu rzadzacych (wg nazwisk): ");
		
		for(Rzadzacy i : tab2)
		System.out.print(i.GetNazwisko()+" ");
	}
	
	public static int Val(int i)
	{if(i%2==0) return i+=3; return i-=1;}
}
