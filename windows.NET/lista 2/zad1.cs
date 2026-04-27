namespace lista_2
{
    /// <summary>
    /// klasa do obliczeń matematycznych
    /// </summary>
    partial class Zad1
    {
        private Expression e1;
        private Expression e2;

        public Zad1(Expression e1, Expression e2)
        {
            this.e1 = e1;
            this.e2 = e2;
            PrintCopyVariable(10);
            PrintRefVariable(10);
        }
    }

    partial class Zad1
    {
        /// <summary>
        /// pass by copy, value is still the same after leaving function
        /// </summary>
        /// <param name="x">some number</param>
        private static void Increment(int x)
        {
            x++;
            Console.WriteLine($"Inside COPY function after incrementing: {x}");
        }

        /// <summary>
        /// pass by reference, value is incremented after leaving function
        /// </summary>
        /// <param name="x"></param>
        private static void Increment(ref int x)
        {
            x++;
            Console.WriteLine($"Inside REF function after incrementing: {x}");
        }

        // IN
        private static void Display(in int x)
        {
            // x++; // illegal with IN parameters
            Console.WriteLine($"We can't modify IN parameters");
        }

        // OUT
        private static void InitializeExp2(bool value1, bool value2, out Exp2 e)
        {
            e = new Exp2(value1, value2);
        }

        public static void PrintCopyVariable(int x)
        {
            Console.WriteLine($"Before calling function: {x}");
            Increment(x);
            Console.WriteLine($"After calling function: {x}");
        }

        public static void PrintRefVariable(int x)
        {
            Console.WriteLine($"Before calling function: {x}");
            Increment(ref x);
            Console.WriteLine($"After calling function: {x}");
        }
    }

    static class Constant
    {
        public static readonly double Pi = Math.PI;
        public static readonly double E = Math.E;
        public static readonly double Tau = Math.Tau;
    }

    sealed class Variable
    {
        public readonly string name;
        public double value;

        public Variable(string name, double value)
        {
            this.name = name;
            this.value = value;
        }

        public static bool Exists(string name, params Variable[] variables) 
        {
            return variables.FirstOrDefault(v => v.name == name) != default;
        }
    }

    abstract class Expression
    {
        public bool value;

        public Expression(bool value)
        {
            this.value = value;
        }

        public virtual bool And()
        {
            return value;
        }

        public virtual bool Or()
        {
            return value;
        }

        public abstract int VariableCount();
    }

    class Exp2 : Expression
    {
        public bool value2;

        public Exp2(bool value1, bool value2) : base(value1)
        {
            this.value2 = value2;
        }

        public override bool And()
        {
            return value && value2;
        }

        public override bool Or()
        {
            return value || value2;
        }

        public override int VariableCount()
        {
            return 2;
        }
    }
}
