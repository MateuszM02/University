using System.Xml;
using System.Data.SqlClient; // this needs NuGet packed to be installed

namespace oop8
{
    public class Zad3
    {
        public static void Main()
        {
        }
    }

    public abstract class DataAccessHandler
    {
        public abstract void Connect();
        public abstract void GetData();
        public abstract void Process();
        public abstract void Close();

        public void Execute()
        {
            Connect();
            GetData();
            Process();
            Close();
        }
    }

    public class SqlDataAccessHandler
        (string connectionString, string column, string table) : DataAccessHandler
    {
        public string ConnectionString { get; } = connectionString;
        public string Table { get; } = table;
        public string Column { get; } = column;
        SqlConnection? connection = null;
        int sum;

        public override void Connect()
        {
            connection = new SqlConnection(this.ConnectionString);
        }

        public override void GetData()
        {
            var command = new SqlCommand(
                string.Format("SELECT SUM({0}) FROM {1}", Column, Table),
                connection
            );

            sum = (int)command.ExecuteScalar();
        }

        public override void Process()
        {
            Console.WriteLine("SUM {0}.{1} is {2}", Table, Column, sum);
        }

        public override void Close()
        {
            connection?.Close();
        }
    }

    public class XmlDataAccessHandler(string fileName) : DataAccessHandler
    {
        public string FilePath { get; } = fileName;
        private XmlDocument? doc = null;

        public override void Connect() { /* nothing to be done */ }

        public override void GetData()
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

        public override void Process()
        {
            var root = this.doc.DocumentElement;
            var longest = LongestNodeName(root.ChildNodes);
            Console.WriteLine("Longest node is \"{0}\"", longest);
        }

        public override void Close() { }
    }
}