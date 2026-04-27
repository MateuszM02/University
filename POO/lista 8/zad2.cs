using System.Collections.Concurrent;

namespace oop8
{
    public class Zad2
    {
        public static void Main()
        {
            new CommandQueue("currentDirectory", 10);
        }
    }

    #region 4 polecenia
    public interface IFileCommand { Task ExecuteAsync(); }

    public class FTPDownloadCommand
        (string connectionAddress, string fileName) : IFileCommand
    {
        string connectionAddress = connectionAddress;
        string fileName = fileName;

        public async Task ExecuteAsync()
        {
            using (var client = new HttpClient())
            {
                var response = await client.GetAsync(this.connectionAddress);
                using (var fs = new FileStream(this.fileName, FileMode.CreateNew))
                {
                    await response.Content.CopyToAsync(fs);
                }
            }
        }

    }

    public class HTTPDownloadCommand
        (string connectionAddress, string fileName) : IFileCommand
    {
        string connectionAddress = connectionAddress;
        string fileName = fileName;

        public async Task ExecuteAsync()
        {
            using (var client = new HttpClient())
            {
                var response = await client.GetAsync(this.connectionAddress);
                using (var fs = new FileStream(this.fileName, FileMode.CreateNew))
                {
                    await response.Content.CopyToAsync(fs);
                }
            }
        }

    }

    public class CreateFileCommand
        (string fileName, int fileSize) : IFileCommand
    {
        string fileName = fileName;
        int fileSize = fileSize;

        public async Task ExecuteAsync()
        {
            Random random = new();
            byte[] bytes = new byte[this.fileSize];

            await Task.Run(() => random.NextBytes(bytes));
            await File.WriteAllBytesAsync(this.fileName, bytes);
        }
    }

    public class CopyFileCommand
        (string fileNameSrc, string fileNameDst) : IFileCommand
    {
        string fileNameSrc = fileNameSrc;
        string fileNameDst = fileNameDst;

        public async Task ExecuteAsync()
        {
            await Task.Run(() => File.Copy(fileNameSrc, fileNameDst));
        }
    }
    #endregion

    public class CommandQueue
    {
        private ConcurrentQueue<IFileCommand> queue;
        private string currentDirectory;
        private int fileName = 1;

        private IFileCommand ExecuteRandom()
        {
            Random random = new();
            int cmdNumber = random.Next(0, 4);
            string outputFile = currentDirectory + "/" + fileName++;

            switch (cmdNumber)
            {
                case 1: 
                    return new CreateFileCommand(outputFile, 4096);
                case 2:
                    string sourceFile = currentDirectory + "/" + random.Next(0, fileName);
                    return new CopyFileCommand(sourceFile, outputFile);
                case 3:
                    return new FTPDownloadCommand("https://example.org/", outputFile);
                default:
                    return new HTTPDownloadCommand("https://example.org/", outputFile);
            }
        }

        private void Consume(CancellationToken token)
        {
            while (!token.IsCancellationRequested)
            {
                if (this.queue.TryDequeue(out IFileCommand? command))
                {
                    command.ExecuteAsync();
                    Thread.Sleep(500);
                }
            }
        }

        public CommandQueue(string currentDirectory, int? commandCount = null)
        {
            this.queue = new ConcurrentQueue<IFileCommand>();
            this.currentDirectory = currentDirectory;
            CancellationTokenSource cts = new();

            if (!Directory.Exists(currentDirectory))
            {
                Directory.CreateDirectory(currentDirectory);
                CreateFileCommand cfc = new(currentDirectory + "/0", 1024);
                Task.Run(cfc.ExecuteAsync);
            }

            Thread consumer1 = new(() => Consume(cts.Token));
            Thread consumer2 = new(() => Consume(cts.Token));

            consumer1.Start();
            consumer2.Start();

            while (commandCount == null || commandCount > 0)
            {
                if (cts.Token.IsCancellationRequested)
                    break;
                
                var command = ExecuteRandom();
                this.queue.Enqueue(command);
                Thread.Sleep(100);

                if (commandCount is not null)
                    commandCount--;
            }

            while (!this.queue.IsEmpty)
                Thread.Sleep(100);
            cts.Cancel();
            
            consumer1.Join();
            consumer2.Join();
        }
    }
}