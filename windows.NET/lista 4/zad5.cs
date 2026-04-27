using System.Text;

namespace lista_4
{
    public static class Zad5
    {
        public static void CreateFile2()
        {
            IEnumerable<string> ogData = File.ReadAllLines("zad5imie.txt")
                .Select(line => $"{line.Split(',')[2]}, {LosowyNumerKonta()}");
            File.WriteAllLines("zad5konto.txt", ogData);
        }

        public static string LosowyNumerKonta()
        {
            Random random = new();
            StringBuilder sb = new("PL");

            // Dodanie losowych cyfr dla numeru kontrolnego IBAN
            sb.Append(random.Next(10, 100));

            // Generowanie losowego numeru konta (bez numeru kontrolnego i kodu kraju)
            for (int i = 0; i < 26; i++)
            {
                sb.Append(random.Next(0, 10));
            }

            return sb.ToString();
        }

        public static IEnumerable<string> MergeData(string path1, string path2)
        {
            //return File.ReadAllLines(path1)
            //    .Join(
            //        File.ReadAllLines(path2),
            //        line1 => line1.Split(',')[2],
            //        line2 => line2.Split(',')[0],
            //        (line1, line2) =>
            //            $"{string.Join(",", line1.Split(',').Take(2))}," +
            //            $"{string.Join(",", line2.Split(',').Skip(1))}");

            return  from line1 in File.ReadAllLines(path1)
                    join line2 in File.ReadAllLines(path2)
                    on line1.Split(',')[2] equals line2.Split(',')[0]
                    select  $"{string.Join(",", line1.Split(',').Take(2))}," +
                            $"{string.Join(",", line2.Split(',').Skip(1))}";
        }
    }
}
