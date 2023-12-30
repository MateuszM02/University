/******************************************************************************

Zadanie 2, Lista 5
Programowanie Obiektowe
Mateusz Mazur

*******************************************************************************/

class Main
{
	public static void main(String[] args)
	{
	    int rozmiar = 5;
	    Expression[] exp = new Expression[rozmiar];
	    exp[0] = new Multiply(new Const(-2),new Add(new Const(3), new Const(7)));
	    exp[1] = new Multiply(new Add(new Const(5), new Subtract(new Const(8), new Const(2))), new Variable("x"));
		exp[2] = new Add(new Const(4), new Variable("x"));
		exp[3] = new Variable("x");
		exp[4] = new Subtract(new Const(51),new Const(20));
		
		for(int i = 0; i < rozmiar; i++)
		{
		    System.out.println(exp[i].toString()); //wypisuje wyrazenie w postaci ciagu
		    ObliczWyrazenie(exp[i]); //oblicza wyrazenie, o ile nie zawiera ono zmiennych (wtedy rzuca wyjatek)
		}
    }
	public static void ObliczWyrazenie(Expression wyr)
	{
	    try {System.out.println(wyr.evaluate());}
		catch(ArithmeticException e)    {System.out.println("obliczanie wartości wyrażenia nie powiodlo sie.");}
	}
}
