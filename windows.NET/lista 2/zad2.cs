using System.Data.Common;

namespace lista_2
{
    internal class Zad2
    {
        public Zad2()
        {
            using (DisposableClass d = new DisposableClass(null!))
            {
                // d.PrintConnectionString();
            }
        }
    }

    class FinalizeClass
    {
        // Finalizer
        ~FinalizeClass()
        {
            // free arrays, objects instances here
            Console.WriteLine("Finalizer has been called.");
        }
    }

    class DisposableClass : IDisposable
    {
        private bool _disposed = false;
        private readonly DbConnection _connection; // database connection

        public DisposableClass(DbConnection connection) 
        { 
            this._connection = connection;
        }

        // Implement method Dispose from IDisposable
        public void Dispose()
        {
            CleanUp(true);
            // Prevent finalizer call
            GC.SuppressFinalize(this);
        }

        // if disposing = true it means method was called
        // (in)directly by user, otherwise it was called by finalizer
        protected virtual void CleanUp(bool disposing)
        {
            if (!this._disposed)
            {
                if (disposing)
                {
                    // free database, internet connections here
                    this._connection.Dispose();
                }
                // free arrays, objects instances here
                Console.WriteLine("Dispose() method has been called.");
                this._disposed = true;
            }
        }

        // Finalizer
        ~DisposableClass()
        {
            CleanUp(false);
        }

        public void PrintConnectionString()
        {
            Console.WriteLine($"connection string is {this._connection.ConnectionString}");
        }
    }

}
