using System.Text;

namespace lista_4
{
    public class Zad2
    {
        /// <summary>
        /// Creates n random numbers from range [min, max] and saves them to given file
        /// </summary>
        /// <param name="min">smallest number to be possible to generate</param>
        /// <param name="max">biggest number to be possible to generate</param>
        /// <param name="n">how many numbers to generate</param>
        /// <param name="filePath">path to file where list of numbers will be saved</param>
        public static void SaveRandomNumbersToFile(int min, int max, int n, string filePath)
        {
            Random random = new();
            StringBuilder stringBuilder = new();

            for (int i = 0; i < n; i++)
            {
                int randomNumber = random.Next(min, max + 1);
                stringBuilder.AppendLine(randomNumber.ToString());
            }

            File.WriteAllText(filePath, stringBuilder.ToString());
        }

        public static void PrintBiggerThan100(string filePath)
        {
            var query = from line in File.ReadAllLines(filePath)
                        where !string.IsNullOrWhiteSpace(line)
                        let number = int.Parse(line)
                        where number > 100
                        orderby number descending
                        select number;

            foreach (int number in query)
            {
                Console.WriteLine(number);
            }
        }

        public static void PrintBiggerThan100Methods(string filePath)
        {
            File.ReadAllLines(filePath)
                .Where(line => !string.IsNullOrWhiteSpace(line))
                .Select(int.Parse)
                .Where(x => x > 100)
                .OrderByDescending(x => x)
                .ToList().ForEach(Console.WriteLine);
        }
    }
}
