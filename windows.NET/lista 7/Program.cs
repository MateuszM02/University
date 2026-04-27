namespace oop7
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();
            // Application.Run(new Form1());
            // Application.Run(new Form2());
            Application.Run(new Form4());
        }
    }
}