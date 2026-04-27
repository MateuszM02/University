namespace net9
{
    public class Zad2
    {
        public static void Main()
        {
            Thread barberThread = new(CreateBarber);
            List<Thread> clientThreads = [];
            for (int i = 0; i < 10; i++)
            {
                clientThreads.Add(new(CreateClient));
            }

            barberThread.Start();
            for (int i = 0; i < 10; i++) 
            { 
                clientThreads[i].Start();
            }

            barberThread.Join();
            for (int i = 0; i < 10; i++)
            {
                clientThreads[i].Join();
            }
        }

        private static void CreateBarber()
        {
            BarberInstance = new(new CancellationTokenSource());
            BarberInstance.Sleep();
        }

        private static void CreateClient()
        {
            while (BarberInstance == null)
            {
                Thread.Sleep(100);
            }

            Client client = new(BarberInstance, new CancellationTokenSource());
        }
        public static Barber? BarberInstance { get; private set; }
    }



    public static class Manager
    {
        private static Mutex mutex = new();
        private static Queue<Client> _clients = [];
        private static bool _mutexLocked = false;
        
        public static bool IsMutexLocked() => _mutexLocked;
        public static int GetShavingTime() => 500;

        public static bool WaitOne()
        {
            if (_mutexLocked)
                return false;
            _mutexLocked = true;
            return mutex.WaitOne();
        }

        public static void ReleaseMutex()
        {
            if (!_mutexLocked)
                return;
            _mutexLocked = false;
            mutex.ReleaseMutex();
        }

        /// <summary>
        /// initializes client instance and starts its thread
        /// </summary>
        public static void NewClientInWaitingRoom(Client client)
        {
            _clients.Enqueue(client);
        }

        public static Client TakeOneClientFromWaitingRoom()
        {
            return _clients.Dequeue();
        }

        public static bool AnyClientInQueue()
        {
            return _clients.Count > 0;
        }
    }
}
