namespace lista_3
{
    class Zad4
    {
        public static void Main()
        {
            // Przykład ConvertAll
            List<int> numbers = [1, 2, 3, 4, 5];
            List<string> strings = numbers.ConvertAll(delegate (int i) { return $"Liczba: {i}"; });

            // Przykład FindAll
            List<int> evenNumbers = numbers.FindAll(delegate (int i) { return i % 2 == 0; });

            // Przykład ForEach
            strings.ForEach(delegate (string s) { Console.WriteLine(s.Length); });

            // Przykład RemoveAll
            numbers.RemoveAll(delegate (int i) { return i % 2 == 0; }); // Usuwa wszystkie parzyste liczby

            // Przykład Sort
            numbers.Sort(delegate (int x, int y) { return y.CompareTo(x); }); // Sortowanie malejące

            // Wyświetlenie wyników
            Console.WriteLine("Konwersja na stringi:");
            strings.ForEach(s => Console.WriteLine(s));

            Console.WriteLine("\nLiczby parzyste:");
            evenNumbers.ForEach(i => Console.WriteLine(i));

            Console.WriteLine("\nLiczby po usunięciu parzystych:");
            numbers.ForEach(i => Console.WriteLine(i));

            Console.WriteLine("\nLiczby posortowane malejąco:");
            numbers.ForEach(i => Console.WriteLine(i));
        }
    }

}
