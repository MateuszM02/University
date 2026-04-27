using before3;

namespace before3
{
    public class TaxCalculator
    {
        private decimal _tax;

        public decimal Tax
        {
            get => _tax;
            set => _tax = value;
        }

        public decimal CalculateTax(decimal Price) => Price * _tax; 
    }
    public class Item
    {
        private decimal _price;
        public decimal Price
        {
            get => _price;
            set => _price = value;
        }

        private string _name;
        public string Name
        {
            get => _name;
            set => _name = value;
        }

        public Item(decimal price, string name)
        {
            this._price = price;
            this._name = name;
        }
    }
    public class CashRegister
    {
        public TaxCalculator taxCalc = new();
        public decimal CalculatePrice(Item[] Items)
        {
            decimal _price = 0;
            foreach (Item item in Items)
            {
                _price += item.Price + taxCalc.CalculateTax(item.Price);
            }
            return _price;
        }
        public void PrintBill(Item[] Items)
        {
            foreach (Item item in Items)
                Console.WriteLine("towar {0} : cena {1} + podatek {2}",
                    item.Name, item.Price, taxCalc.CalculateTax(item.Price));
        }
    }
}

namespace after3
{
    public interface ITaxCalculator
    {
        public decimal CalculateTax(decimal Price);
    }

    public class TaxCalculator_Vat8 : ITaxCalculator
    {
        public decimal CalculateTax(decimal Price) => Price * 0.08m;
    }

    public class TaxCalculator_Vat23 : ITaxCalculator
    {
        public decimal CalculateTax(decimal Price) => Price * 0.23m;
    }

    public interface ISortItem
    {
        Item[] Sort(Item[] items);
    }

    class SortItemPrice : ISortItem
    {
        public Item[] Sort(Item[] items)
        {
            Array.Sort(items, (x, y) => y.Price.CompareTo(x.Price));
            return items;
        }
    }

    public class Item
    {
        private decimal _price;
        public decimal Price
        {
            get => _price;
            set => _price = value;
        }

        private string _name;
        public string Name
        {
            get => _name;
            set => _name = value;
        }

        public Item(decimal price, string name)
        {
            this._price = price;
            this._name = name;
        }
    }

    public class CashRegister
    {
        public ITaxCalculator taxCalc;

        public CashRegister(ITaxCalculator taxCalc)
        {
            this.taxCalc = taxCalc;
        }

        public void SetTaxCalculator(ITaxCalculator newTaxCalc)
        {
            taxCalc = newTaxCalc;
        }

        public decimal CalculatePrice(Item[] Items)
        {
            decimal _price = 0;
            foreach (Item item in Items)
            {
                _price += item.Price + taxCalc.CalculateTax(item.Price);
            }
            return _price;
        }

        public void PrintBill(Item[] Items)
        {
            foreach (Item item in Items)
                Console.WriteLine("towar {0} : cena {1} + podatek {2}",
                    item.Name, item.Price, taxCalc.CalculateTax(item.Price));
        }
    }
}
