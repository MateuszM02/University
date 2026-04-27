namespace lista_4
{
    public class Zad4
    {
        public static long SumOfFilesLength(string dirPath)
        {
            // .Sum() ?
            //return Directory.EnumerateFiles(dirPath)
            //    .Select(file => new FileInfo(file).Length)
            //    .Aggregate((total, nextLength) => total + nextLength);
            return (from file in Directory.EnumerateFiles(dirPath)
                   select file.Length)
                   .Aggregate((total, nextLength) => total + nextLength);
        }
    }
}
