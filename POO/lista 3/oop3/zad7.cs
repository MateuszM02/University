#pragma warning disable CA1822 // Mark members as static
namespace zad7
{
    public class Printer
    {
        public void Print(string x)
        {
            Console.WriteLine(x);
        }
    }

    public abstract class ReportComposer
    {
        public IDataGetter _dataGetter;
        public IReportPrinter _reportPrinter;
        public IDocumentFormatter _documentFormatter;

        public ReportComposer(IDataGetter dataGetter, IReportPrinter reportPrinter, IDocumentFormatter documentFormatter)
        {
            _dataGetter = dataGetter;
            _reportPrinter = reportPrinter;
            _documentFormatter = documentFormatter;
        }

        public void ComposeReport()
        {
            string data = _documentFormatter.FormatDocument(_dataGetter.GetData());
            _reportPrinter.PrintReport(data);
        }
    }

    public interface IReportPrinter
    {
        public void PrintReport(string data);
    }

    public interface IDataGetter
    {
        public string GetData();
    }

    public interface IDocumentFormatter
    {
        public string FormatDocument(string data);
    }

    public class ReportPrinter : IReportPrinter
    {
        private Printer printer;

        private void CreatePrinter()
        {
            printer = new Printer();
        }

        public void PrintReport(string data)
        {
            printer.Print(data);
        }
    }

    public class DataGetter : IDataGetter
    {
        private string data;

        private void AddData(string x)
        {
            data += x;
        }

        public string GetData()
        {
            return data;
        }
    }

    public class DocumentFormatter : IDocumentFormatter
    {
        public string FormatDocument(string data)
        {
            return data = null;
        }
    }
}
#pragma warning restore CA1822 // Mark members as static