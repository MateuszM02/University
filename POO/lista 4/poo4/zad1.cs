namespace oop4
{
    public class OneSingleton<T>
    {
        private static OneSingleton<T>? instance;
        public T? Value { get; private set; }

        private OneSingleton(T? defaultValue) 
        {
            Value = defaultValue;
        }

        public static OneSingleton<T> GetInstance(T? defaultValue = default)
        {
            return instance ??= new OneSingleton<T>(defaultValue);
        }

        public static void Test()
        {
            var processSingleton1 = OneSingleton<int>.GetInstance(1);
            Console.WriteLine($"Singleton dla procesu 1: {processSingleton1.Value}");
            var processSingleton2 = OneSingleton<int>.GetInstance(2);
            Console.WriteLine($"Singleton dla procesu 2: {processSingleton2.Value}");
            var processSingleton3 = OneSingleton<int>.GetInstance(3);
            Console.WriteLine($"Singleton dla procesu 3: {processSingleton3.Value}");
        }
    }

    public class SingletonThreadLazy<T>
    {
        private static ThreadLocal<SingletonThreadLazy<T>>? _threadLocalInstance;

        public T? Value2 { get; private set; }

        private SingletonThreadLazy(T? defaultValue)
        {
            Value2 = defaultValue;
        }

        public static SingletonThreadLazy<T> GetInstance(T? defaultValue = default)
        {
            if (_threadLocalInstance == null || _threadLocalInstance.Value == null)
            {
                SingletonThreadLazy<T> val = new(defaultValue);
                _threadLocalInstance = new(() => val)
                {
                    Value = val
                };
            }
            return _threadLocalInstance.Value;
        }

        public static void Test()
        {
            var processSingleton1 = SingletonThreadLazy<int>.GetInstance(1);
            Console.WriteLine($"Singleton dla procesu 1: {processSingleton1.Value2}");
            var processSingleton2 = SingletonThreadLazy<int>.GetInstance(2);
            Console.WriteLine($"Singleton dla procesu 2: {processSingleton2.Value2}");
            var processSingleton3 = SingletonThreadLazy<int>.GetInstance(3);
            Console.WriteLine($"Singleton dla procesu 3: {processSingleton3.Value2}");
        }
    }

    public class SingletonProcessLazyExpiring<T>
    {
        private static SingletonProcessLazyExpiring<T>? _instance;
        private DateTime _expirationTime;

        public T? Value { get; private set; }

        private SingletonProcessLazyExpiring(T? defaultValue)
        {
            Value = defaultValue;
        }

        public static SingletonProcessLazyExpiring<T> GetInstance(T? defaultValue = default)
        {
            if (_instance == null || DateTime.Now > _instance._expirationTime)
            {
                _instance = new(defaultValue)
                {
                    _expirationTime = DateTime.Now.AddSeconds(5) // Wygaśniecie po 5 sekundach
                };
            }
            return _instance;
        }

        public static void Test()
        {
            // Przykład użycia
            var processSingleton1 = SingletonProcessLazyExpiring<string>.GetInstance();
            Console.WriteLine($"Singleton dla procesu 1: {processSingleton1.Value}");
            Thread.Sleep(2000); // Symulacja pracy
            var processSingleton2 = SingletonProcessLazyExpiring<string>.GetInstance();
            Console.WriteLine($"Singleton dla procesu 2: {processSingleton2.Value}");
            Thread.Sleep(4000); // Poczekaj 4 sekundy (łącznie 6 sekund od utworzenia)
            var processSingleton3 = SingletonProcessLazyExpiring<string>.GetInstance();
            Console.WriteLine($"Singleton dla procesu 3: {processSingleton3.Value}");
        }
    }
}
