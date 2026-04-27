namespace oop3
{
    // 2.9 Protected variations - użycie stabilnego interfejsu
    interface IProductInfo
    {
        public double Price { get; protected set; }
        public double CalculateTax();
        public void PrintInfo();
    }

    public class Apple : IProductInfo
    {
        private double price;
        private readonly string type;
        public double Price
        {
            get => price;
            set => price = value;
        }

        public Apple(double price, string type)
        {
            this.price = price;
            this.type = type;
        }

        public string GetAppleType()
        {
            return this.type;
        }

        public double CalculateTax()
        {
            return 0;
        }

        public void PrintInfo()
        {
            Console.WriteLine($"This is {type} apple. It costs {price}.");
        }
    }

    public class AppleJam : IProductInfo
    {
        private double jamPrice;
        private readonly Apple appleUsed;
        public double Price
        {
            get => jamPrice;
            set => jamPrice = value;
        }

        // 2.1 creator - klasa B posiada dane inicjalizacyjne do stworzenia obiektu A
        public AppleJam(double jamPrice, double applePrice, string appleType)
        {
            this.jamPrice = jamPrice;
            this.appleUsed = new Apple(applePrice, appleType);
        }

        // 2.2 information expert - ma informacje konieczne do wyliczenia wartości
        public double JamProfit()
        {
            return jamPrice - appleUsed.Price;
        }

        public double CalculateTax()
        {
            return 0.05 * jamPrice;
        }

        public void PrintInfo()
        {
            Console.WriteLine($"This is {appleUsed.GetAppleType()} " +
                $"apple jam. It costs {jamPrice}.");
        }
    }

    public class Smartphone : IProductInfo
    {
        private double price;
        private readonly int yearOfProduction;
        public double Price
        {
            get => price;
            set => price = value;
        }

        public Smartphone(double price, int yearOfProduction)
        {
            this.price = price;
            this.yearOfProduction = yearOfProduction;
        }

        public double CalculateTax()
        {
            return 0.23 * price;
        }

        public void PrintInfo()
        {
            Console.WriteLine($"This is smartphone. " +
                $"It was produced in {yearOfProduction} and costs {price}.");
        }
    }
}
