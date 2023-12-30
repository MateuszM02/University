class Expression
{
    public int evaluate()   {return 0;}
    public String toString()    {return "";}
}

class Variable extends Expression
{
	String name;
	Variable(String s)  {name = s;}
	public int evaluate()   {throw new ArithmeticException();}
    public String toString()    {return name;}
}

class Const extends Expression
{
	int stala;
	Const(int c)    {stala = c;}
	public int evaluate()   {return stala;}
    public String toString()    {return stala + "";}
}
