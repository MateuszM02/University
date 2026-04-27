namespace oop6
{
    public interface ILogger
    {
        void Log(string Message);
    }

    public enum LogType { None, Console, File }
    
    public class LoggerFactory
    {
        private static LoggerFactory _logger;

        public static ILogger GetLogger
            (LogType LogType, string? Parameters = null)
        {
            return LogType switch
            {
                LogType.None => new NullLogger(),
                LogType.Console => new ConsoleLogger(),
                LogType.File => new FileLogger(Parameters!),
                _ => throw new ArgumentException("Wrong LogType"),
            };
        }
        public static LoggerFactory Instance()
        { 
            return _logger ??= new();
        }
    }

    // Logger types ------------------------------------------------------

    class NullLogger : ILogger
    {
        public void Log(string Message) { }
    }

    class ConsoleLogger : ILogger
    {
        public void Log(string Message) => Console.WriteLine(Message);
    }

    class FileLogger : ILogger
    {
        private string _path;

        public FileLogger(string path)
        {
            _path = path;
        }

        public void Log(string Message) 
        {
            if (_path == null)
                throw new Exception("Wrong file path");
            using (StreamWriter streamWriter = File.AppendText(_path))
                streamWriter.WriteLine(Message);
        }
    }

    // Test --------------------------------------------------------------

    class Zad1
    {
        public static void Main()
        {
            // klient:
            ILogger logger1 = LoggerFactory.GetLogger(LogType.File, "C:\\foo.txt");
            logger1.Log("foo bar"); // logowanie do pliku
            ILogger logger2 = LoggerFactory.GetLogger(LogType.None);
            logger2.Log("qux"); // brak logowania
        }
    }
}
