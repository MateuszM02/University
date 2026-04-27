namespace lista_4
{
    public class Zad8
    {
        public static void Main()
        {
            List<int> list = [ 1, 2, 3, 4, 5 ];
            list.Select(i =>
            {
                Func<int, int> fib = null;
                fib = n => n > 2 ? fib(n - 1) + fib(n - 2) : 1;
                return fib(i);
            }).ToList().ForEach(Console.WriteLine);
            
            //list.Select(i => {
            //    static int fib(int n) => n > 2 ? fib(n - 1) + fib(n - 2) : 1;
            //    return fib(i);
            //}).ToList().ForEach(Console.WriteLine);
        }
    }
}