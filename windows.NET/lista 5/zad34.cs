using System.Runtime.CompilerServices;

namespace lista_5
{
    public static class Zad3
    {
        public static TaskAwaiter GetAwaiter(this int milliseconds)
        {
            return Task.Delay(milliseconds).GetAwaiter();
        }

        public static async Task Main()
        {
            Console.WriteLine("1");
            await 2000; // (1)
            Console.WriteLine("2");
        }
    }

    public static class Zad4 
    {
        private static readonly HttpClient client = new();

        public static TaskAwaiter<string> GetAwaiter(this string url)
        {
            return GetUrlContentAsync(url).GetAwaiter();
        }

        private static async Task<string> GetUrlContentAsync(string url)
        {
            HttpResponseMessage response = await client.GetAsync(url);
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }

        public static async Task Main()
        {
            string content = await "https://www.google.com";
            Console.WriteLine(content);
        }
    }
}