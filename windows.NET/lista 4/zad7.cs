namespace lista_4
{
    public static class Zad7
    {
        public static void Main()
        {
            var item1 = new { Field1 = "The value1", Field2 = 1 };
            var item2 = new { Field1 = "The value2", Field2 = 2 };
            var list = new[] { item1, item2 }.ToList();
            list.Add(new { Field1 = "The value3", Field2 = 3 });
            foreach (var v in list)
            {
                Console.WriteLine("Field1={0}, Field2={1}", v.Field1, v.Field2);
            }
        }
    }
}
