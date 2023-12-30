/******************************************************************************

Zadanie 1, Lista 5
Programowanie Obiektowe
Mateusz Mazur

*******************************************************************************/

public class Main
{
	public static void main(String[] args) 
	{
	    //lista liczb
		OrderedList<Integer> lista = new OrderedList<Integer>(5);
		lista.add_element(8);
		lista.add_element(4);
		lista.add_element(5);
		lista.add_element(7);
		lista.add_element(9);
		System.out.println("Lista liczb zapisana jako ciag: " + lista.toString());
		//lista liczb
		OrderedList<Rzadzacy> lista2 = new OrderedList<Rzadzacy>(new Cesarz("Romulus","Augustus","Rzymianin"));
		lista2.add_element(new Krol("Kazimierz","Wielki","Polak"));
		lista2.add_element(new Prezydent("Barack","Obama","Amerykanin"));
		lista2.add_element(new Premier("Boris","Johnson","Anglik"));
		System.out.println(lista2.get_first().Dane()); //zwraca cesarza
		System.out.println(lista2.get_n(lista2.first,1).Dane()); //zwraca krola
		System.out.println(lista2.get_n(lista2.first,2).Dane()); //zwraca prezydenta
		System.out.println(lista2.get_n(lista2.first,3).Dane()); //zwraca premiera
		System.out.println("Roznica w rangach miedzy cesarzem a premierem: " + lista2.get_first().compareTo(lista2.get_n(lista2.first,3))); //zwraca -3
		System.out.println("Cesarz jest wazniejszy od premiera? " + lista2.get_first().czy_wazniejszy_od(lista2.get_n(lista2.first,3))); //zwraca true, bo cesarz jest wazniejszy od premiera
		System.out.println("Krol jest wazniejszy od cesarza? " + lista2.get_n(lista2.first,1).czy_wazniejszy_od(lista2.get_first())); //zwraca false, bo krol nie jest wazniejszy od cesarza
		//System.out.println(lista2.get_n(lista2.first,4).Dane()); //rzuca wyjatek, bo lista nie zawiera elementu na tym indeksie
	}
}
