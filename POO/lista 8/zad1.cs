
using System.Data;
using System.Data.SqlClient;

namespace oop8
{
    public static class Zad1
    {
        public static void Main() 
        {
            AbstractHandler classifier = new ClassifierHandler();
            // ArchivingHandler.InjectConnection(new SqlConnection("connectionstring"));

            classifier.AttachHandler(new CommendatoryHandler());
            classifier.AttachHandler(new ComplaintHandler());
            classifier.AttachHandler(new OrderHandler());
            classifier.AttachHandler(new OtherHandler());
            classifier.AttachHandler(new InvalidHandler());
            
            //Message comMessage = new("What a product", "Very good value-price ratio too");
            //classifier.DispatchRequest(new Request(comMessage));

            Message invMessage = new("Invalid message with no content", "");
            classifier.DispatchRequest(new Request(invMessage));

            MessageStats.PrintStats();
        }
    }

    public enum MessageType
    {
        Commendatory,
        Complaint,
        Order,
        Other,
        Invalid,
    }

    public class Message(string title, string content)
    {
        public readonly string _title = title;
        public readonly string _content = content;
    }

    public class Request(Message message)
    {
        public readonly Message _message = message;
        public MessageType _messageType;
    }

    public static class MessageStats
    {
        public static int CommendatoryCount = 0;
        public static int ComplaintCount = 0;
        public static int OrderCount = 0;
        public static int OtherCount = 0;
        public static int InvalidCount = 0;

        public static void PrintStats()
        {
            Console.WriteLine($"Commendatory messages: {CommendatoryCount}");
            Console.WriteLine($"Complaint messages: {ComplaintCount}");
            Console.WriteLine($"Order messages: {OrderCount}");
            Console.WriteLine($"Other messages: {OtherCount}");
            Console.WriteLine($"Invalid messages: {InvalidCount}");
        }
    }

    public abstract class AbstractHandler
    {
        protected AbstractHandler? _nextHandler = null;

        public abstract bool ProcessRequest(Request request);
        public void DispatchRequest(Request request)
        {
            //bool result = this.ProcessRequest(request);
            //if (!result && _nextHandler != null)
            //    _nextHandler.ProcessRequest(request);
            
            AbstractHandler? current = this;
            while (current != null && !current.ProcessRequest(request)) 
                current = current._nextHandler;

            AbstractHandler handler = new ArchivingHandler();
            handler.ProcessRequest(request);
        }

        public void AttachHandler(AbstractHandler Handler)
        {
            if (_nextHandler != null)
                _nextHandler.AttachHandler(Handler);
            else
                _nextHandler = Handler;
        }
    }

    public class ClassifierHandler : AbstractHandler
    {
        public override bool ProcessRequest(Request request)
        {
            if (request._message._content.Length == 0 ||
                    request._message._title.Length == 0)
            {
                request._messageType = MessageType.Invalid;
            }
            else if (request._message._content.Contains("good"))
                request._messageType = MessageType.Commendatory;
            else if (request._message._content.Length > 20)
                request._messageType = MessageType.Complaint;
            else if (request._message._content.Contains("want"))
                request._messageType = MessageType.Order;
            else
                request._messageType = MessageType.Other;
            return false;
        }
    }

    #region 4 handlers
    public class CommendatoryHandler : AbstractHandler
    {
        public override bool ProcessRequest(Request request)
        {
            if (request._messageType == MessageType.Commendatory)
            {
                MessageStats.CommendatoryCount++;
            }
            return false;
        }
    }

    public class ComplaintHandler : AbstractHandler
    {
        public override bool ProcessRequest(Request request)
        {
            if (request._messageType == MessageType.Complaint)
            {
                MessageStats.ComplaintCount++;
            }
            return false;
        }
    }

    public class OrderHandler : AbstractHandler
    {
        public override bool ProcessRequest(Request request)
        {
            if (request._messageType == MessageType.Order)
            {
                MessageStats.OrderCount++;
            }
            return false;
        }
    }

    public class OtherHandler : AbstractHandler
    {
        public override bool ProcessRequest(Request request)
        {
            if (request._messageType == MessageType.Other)
            {
                MessageStats.OtherCount++;
            }
            return false;
        }
    }
    #endregion

    public class InvalidHandler : AbstractHandler
    {
        public override bool ProcessRequest(Request request)
        {
            if (request._messageType == MessageType.Invalid)
            {
                MessageStats.InvalidCount++;
                Console.WriteLine(
                    $"A message with title \"{request._message._title}\" is invalid!");
            }
            return false;
        }
    }

    #region Archiving handler
    public class ArchivingHandler : AbstractHandler
    {
        private static SqlConnection _sqlConnection;

        public static void InjectConnection(SqlConnection sqlConnection)
        {
            _sqlConnection = sqlConnection;
        }

        public override bool ProcessRequest(Request request)
        {
            // Przygotuj polecenie SQL do zapisania danych z obiektu request.
            /*
            string commandText = "INSERT INTO TableName (Title, Content) VALUES (@Value1, @Value2)";
            using (SqlCommand cmd = new(commandText, _sqlConnection))
            {
                // Dodaj parametry do polecenia SQL.
                cmd.Parameters.AddWithValue("@Value1", request._message._title);
                cmd.Parameters.AddWithValue("@Value2", request._message._content);

                if (_sqlConnection.State != ConnectionState.Open)
                    _sqlConnection.Open();

                cmd.ExecuteNonQuery();

                if (_sqlConnection.State == ConnectionState.Open)
                    _sqlConnection.Close();
            }
            */
            return true;
        }
    }

    #endregion
}
