using lista_3;

// // zadania 1,2,3
//Person person = new()
//{
//    Name = "Jan",
//    Surname = "Kowalski",
//    Age = 42
//};

//XMLGenerator3 generator = new XMLGenerator3();
//string xml = generator.GenerateXML(person);
//Console.WriteLine(xml);

// // zadanie 4
//Zad4.Main();

// // zadanie 5
//List<double> xs = [6,5,4,3,2,1];
//ListHelper.Sort(xs, (x, y) => x.CompareTo(y));

//foreach (double x in xs)
//{
//    Console.WriteLine(x);
//}

// // zadanie 6
var t = BinaryTreeNode<int>.ExampleTree();
foreach (int item in t.BFS())
{
    Console.WriteLine(item);
}