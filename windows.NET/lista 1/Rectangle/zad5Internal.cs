namespace Rectangle
{
    public class Zad5Internal
    {
        // zad 5
        public static void PrintIntx(Rectangle r)
        {
            Console.WriteLine(r.intx);
        }
    }

    public class Zad6Base
    {
        protected double x1;
        protected double x2;

        public Zad6Base() : this(0, 0)
        { }

        public Zad6Base(double x1, double x2)
        {
            this.x1 = x1;
            this.x2 = x2;
        }

        public double Add(double x1, double x2) 
        { 
            return x1 + x2; 
        }
        public double Add(double x1, double x2, double x3)
        {
            return x1 + x2 + x3;
        }

        public string Add(string s1, string s2)
        {
            return s1 + s2;
        }

        public double Add(params double[] xs)
        {
            return xs.Sum();
        }

        public double Add(double x1, double x2, double x3, double x4)
        {
            return Add(x1, x2, x3, x4);
        }
    }

    public class Zad6Subclass : Zad6Base
    {
        public new double Add(double x1, double x2)
        {
            return base.Add(x1, x2);
        }

        public Zad6Subclass() : base(1, 2) // base()
        { }
    }
}
