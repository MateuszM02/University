namespace before4
{
    public class Rectangle
    {
        public virtual int Width { get; set; }
        public virtual int Height { get; set; }
    }

    public class Square : Rectangle
    {
        public override int Width
        {
            get => base.Width;
            set => base.Width = base.Height = value;
        }
        public override int Height
        {
            get => base.Height;
            set => base.Width = base.Height = value;
        }
    }

    public class AreaCalculator
    {
        public int CalculateArea(Rectangle rect)
        {
            return rect.Width * rect.Height;
        }
    }

    public static class ClientCode
    {
        public static void Main()
        {
            int w = 4, h = 5;
            Rectangle rect = new Square() { Width = w, Height = h };
            AreaCalculator calc = new();
            Console.WriteLine("prostokąt o wymiarach {0} na {1} ma pole {2}",
                w, h, calc.CalculateArea(rect));
        }
    }
}

namespace after4
{
    public abstract class Quadrangle
    {
        public abstract int Width { get; set; }
        public abstract int Height { get; set; }
        public abstract int CalculateArea();
    }

    public class Rectangle : Quadrangle
    {
        public override int Width { get; set; }
        public override int Height { get; set; }

        public override int CalculateArea()
        {
            return Width * Height;
        }
    }

    public class Square : Quadrangle
    {
        private int _side;

        public override int Width
        {
            get => _side;
            set => _side = value;
        }

        public override int Height
        {
            get => _side;
            set => _side = value;
        }

        public override int CalculateArea()
        {
            return Width * Height;
        }
    }

    public static class ClientCode
    {
        public static void Main()
        {
            int w = 4, h = 5;
            Quadrangle rect = new Rectangle() { Width = w, Height = h };
            Console.WriteLine("prostokąt o wymiarach {0} na {1} ma pole {2}",
                w, h, rect.CalculateArea());
        }
    }
}