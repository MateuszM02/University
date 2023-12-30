class Add extends Expression
{
    public Expression lewe;
    public Expression prawe;
	Add(Expression l, Expression p) 
	{
	    lewe = l;
	    prawe = p;
	}
	//moze wyrzucac ArithmeticException, jesli dostanie zmienna
	public int evaluate()   {return lewe.evaluate() + prawe.evaluate();}
    public String toString()    {return '(' + lewe.toString() + "+" + prawe.toString() + ')';}
}
class Subtract extends Expression
{
    public Expression lewe;
    public Expression prawe;
	Subtract(Expression l, Expression p)
	{
	    lewe = l;
	    prawe = p;
	}
	//moze wyrzucac ArithmeticException, jesli dostanie zmienna
	public int evaluate()   {return lewe.evaluate() - prawe.evaluate();}
    public String toString()    {return '(' + lewe.toString() + "-" + prawe.toString() + ')';}
}
class Multiply extends Expression
{
    public Expression lewe;
    public Expression prawe;
    Multiply(Expression l, Expression p)
    {
	    lewe = l;
	    prawe = p;
	}
	//moze wyrzucac ArithmeticException, jesli dostanie zmienna
	public int evaluate()   {return lewe.evaluate() * prawe.evaluate();}
    public String toString()    {return '(' + lewe.toString() + "*" + prawe.toString() + ')';}
}
