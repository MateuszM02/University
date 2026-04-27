namespace lista_4
{
    public class Zad3
    {
        public static IEnumerable<string> FirstLetters(string filePath)
        {
            //return File.ReadAllLines(filePath)
            //    .GroupBy(line => line[0].ToString())
            //    .OrderBy(x => x.Key)
            //    .Select(x => x.Key);
            return from line in File.ReadAllLines(filePath)
                   group line
                   by line[0].ToString() into groupedLines
                   orderby groupedLines.Key
                   select groupedLines.Key;
        }
    }
}
