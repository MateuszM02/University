namespace before2
{
    public class ReportPrinter
    {
        private string? data;

        public string GetData()
        {
            string data = "Jakieś dane...";
            return data;
        }

        public void FormatDocument()
        {
            this.data = data?.Replace(". ", ".\n");
        }

        public void PrintReport()
        {
            this.data = this.GetData();
            this.FormatDocument();
            Console.Write(this.data);
        }
    }

    public class Program
    {
        static void Main()
        {
            ReportPrinter printer = new();
            printer.PrintReport();
        }
    }
}

namespace after2
{
    public class DataProvider
    {
        public string GetData()
        {
            string data = "Jakieś dane..."; 
            return data;
        }
    }

    public class DataFormatter
    {
        public string FormatData(string data)
        {
            return data.Replace(". ", ".\n");
        }
    }

    public class ReportPrinter
    {
        public void PrintReport(string data)
        {
            Console.Write(data);
        }
    }

    public class Program
    {
        public static void Main()
        {
            string data = new DataProvider().GetData();
            data = new DataFormatter().FormatData(data);
            new ReportPrinter().PrintReport(data);
        }
    }
}