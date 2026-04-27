namespace lista_4
{
    public static class Zad6
    {
        public static IEnumerable<string> TopIPAddresses(string filePath)
        {
            //return File.ReadAllLines(filePath)
            //        .Select(line => line.Split(' ')[1])
            //        .GroupBy(ip => ip)
            //        .Select(group => new { IP = group.Key, Count = group.Count() })
            //        .OrderByDescending(g => g.Count)
            //        .Take(3)
            //        .Select(x => $"{x.IP}: {x.Count}");

            return (from line in File.ReadAllLines(filePath)
                    let ip = line.Split(' ')[1]
                    group ip by ip into ipGroup
                    orderby ipGroup.Count() descending
                    select $"{ipGroup.Key}: {ipGroup.Count()}").Take(3);
        }
    }
}
