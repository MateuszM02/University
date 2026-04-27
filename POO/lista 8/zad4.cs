using System.Xml;
using System.Data.SqlClient;

namespace oop8
{
    public class Zad4
    {
        public static void Main()
        {
        }
    }

    public interface IDataAccessHandler
    {
        void Connect();
        void GetData();
        void Process();
        void Close();
    }

    public class TemplateClass(IDataAccessHandler dataAccessHandler)
    {
        private readonly IDataAccessHandler _handler = dataAccessHandler;
        public void Execute()
        {
            _handler.Connect();
            _handler.GetData();
            _handler.Process();
            _handler.Close();
        }
    }

    public class SqlDataAccessHandler4
        (string connectionString, string column, string table) : IDataAccessHandler
    {
        public string ConnectionString { get; } = connectionString;
        public string Table { get; } = table;
        public string Column { get; } = column;
        SqlConnection? connection = null;
        int sum;

        public void Connect()
        {
            connection = new SqlConnection(this.ConnectionString);
        }

        public void GetData()
        {
            var command = new SqlCommand(
                string.Format("SELECT SUM({0}) FROM {1}", Column, Table),
                connection
            );

            sum = (int)command.ExecuteScalar();
        }

        public void Process()
        {
            Console.WriteLine("SUM {0}.{1} is {2}", Table, Column, sum);
        }

        public void Close()
        {
            connection?.Close();
        }
    }

    public class XmlDataAccessHandler4(string fileName) : IDataAccessHandler
    {
        public string FilePath { get; } = fileName;
        private XmlDocument? doc = null;

        public void Connect() { /* nothing to be done */ }

        public void GetData()
        {
            this.doc = new XmlDocument();
            this.doc.Load(this.FilePath);
        }

        private static string LongestNodeName(XmlNodeList nodes)
        {
            var longest = "";

            foreach (XmlNode node in nodes)
            {
                if (longest.Length < node.Name.Length)
                {
                    longest = node.Name;
                }

                var childLongest = LongestNodeName(node.ChildNodes);
                if (childLongest.Length > longest.Length)
                {
                    longest = childLongest;
                }
            }

            return longest;
        }

        public void Process()
        {
            var root = this.doc.DocumentElement;
            var longest = LongestNodeName(root.ChildNodes);
            Console.WriteLine("Longest node is \"{0}\"", longest);
        }

        public void Close() { }
    }
}