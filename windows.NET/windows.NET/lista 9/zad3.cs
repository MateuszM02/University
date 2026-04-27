using System.Net;
using System.Net.Mail;
using System.Net.Sockets;

namespace net9
{
    public class Zad3
    {
        public static void Main()
        {
            ;
        }

        private static async Task FtpWebRequestExample()
        {
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://example.com/data.txt");
            request.Method = WebRequestMethods.Ftp.DownloadFile;
            request.Credentials = new NetworkCredential("username", "password");

            using WebResponse response = await request.GetResponseAsync();
            using Stream responseStream = response.GetResponseStream();
            using StreamReader reader = new(responseStream);
            string content = await reader.ReadToEndAsync();
        }

        private static async Task HttpWebRequestExample()
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://example.com");
            request.Method = "GET";

            using WebResponse response = await request.GetResponseAsync();
            using Stream responseStream = response.GetResponseStream();
            using StreamReader reader = new(responseStream);
            string content = await reader.ReadToEndAsync();
        }

        private static async Task WebClientExample()
        {
            using WebClient client = new();
            string content = await client.DownloadStringTaskAsync(new Uri("http://example.com"));
        }

        private static async Task HttpClientExample()
        {
            using HttpClient client = new HttpClient();
            HttpResponseMessage response = await client.GetAsync("http://example.com");
            response.EnsureSuccessStatusCode();
            string content = await response.Content.ReadAsStringAsync();
        }

        private static async Task HttpListenerExample()
        {
            HttpListener listener = new();
            listener.Prefixes.Add("http://localhost:8080/");
            listener.Start();

            HttpListenerContext context = await listener.GetContextAsync();
            HttpListenerRequest request = context.Request;
        }

        private static async Task TcpListenerExample()
        {
            TcpListener listener = new(IPAddress.Any, 8000);
            listener.Start();
            TcpClient client = await listener.AcceptTcpClientAsync();
        }

        private static async Task TcpClientExample()
        {
            TcpClient client = new TcpClient();
            await client.ConnectAsync("hostname", port: 8080);
            NetworkStream stream = client.GetStream();
        }

        private static async Task SmtpClientExample()
        {
            SmtpClient client = new("smtp.example.com")
            {
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("username", "password"),
                EnableSsl = true
            };

            MailMessage mailMessage = new()
            {
                From = new MailAddress("from@example.com"),
                Body = "body",
                Subject = "subject"
            };
            mailMessage.To.Add("to@example.com");

            await client.SendMailAsync(mailMessage);
        }
    }
}
