import java.util.*;

public class Merge<E extends Comparable>
{
    ArrayList<E> tablica;
    public Merge(ArrayList<E> tab)
	{
	    tablica = tab;
	}
	public ArrayList<E> MergeSort(ArrayList<E> tab) 
	{
	    int dlugosc = tab.size();
	    if(dlugosc <= 1) return tab;
	    //tabele tymczasowe
	    int x1 = dlugosc/2;
	    ArrayList<E> tab1 = new ArrayList<E>();
	    ArrayList<E> tab2 = new ArrayList<E>();
	    //dodawanie elementow do tabel tymczasowych
	    for(int i = 0; i < x1; i++)
	        tab1.add(tab.get(i));
	    for(int i = x1; i < dlugosc; i++)
	        tab2.add(tab.get(i));
	    //wywolanie rekurencyjne na obu podtablicach, a potem zlaczenie ich
	    return Join(MergeSort(tab1), MergeSort(tab2));
	}
	
	public ArrayList<E> Join(ArrayList<E> tab1, ArrayList<E> tab2)
	{
	    int dlugosc = tab1.size() + tab2.size();
	    ArrayList<E> tab = new ArrayList<E>();
	    int indeks1 = 0;
	    int indeks2 = 0;
	    for(int i = 0; i < dlugosc; i++)
	    {
	        try 
	        {
	            if(indeks1 >= tab1.size()) //tab1 wypisana
	            {
	                while( indeks2 < tab2.size() )
	                {
	                    tab.add(tab2.get(indeks2));
	                    indeks2++;
	                }
	            }
	            else if(indeks2 >= tab2.size()) //tab2 wypisana
	            {
	                while( indeks1 < tab1.size() )
	                {   
	                    tab.add(tab1.get(indeks1));
	                    indeks1++;
	                }
	            }
	            else if(tab1.get(indeks1).compareTo(tab2.get(indeks2)) < 0) //jesli tab1.first < tab2.first
	            {
	                tab.add(tab1.get(indeks1));
	                indeks1++;
	            }
	            else if(tab1.get(indeks1).compareTo(tab2.get(indeks2)) > 0) //jesli tab1.first > tab2.first
	            {
	                tab.add(tab2.get(indeks2));
	                indeks2++;
	            }
	            else if(tab1.get(indeks1).compareTo(tab2.get(indeks2)) == 0) //jesli tab1.first = tab2.first
	            {
	                tab.add(tab1.get(indeks1));
	                tab.add(tab2.get(indeks2));
	                indeks1++;
	                indeks2++;
	            }
	        } 
	        catch(Exception e) 
	        {
	            System.out.println("Error during table joining: ");
	            throw e;
	        }
	        
	    }
	    return tab;
	}
	public void PrintAll()
	{
	   for(E i: tablica)
	        System.out.print(i+" ");
	}
}
