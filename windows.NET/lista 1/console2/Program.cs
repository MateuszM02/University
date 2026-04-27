using Sq = Square.Square;
using Rc = Rectangle.Rectangle;

Sq s = new(2);
Console.WriteLine($"(c2) Area of square with side length {s.x}: {s.GetArea()}");

Rc r = new(4, 5);
Console.WriteLine($"(c2) Area of rectangle with sides {r.a}, {r.b}: {r.GetArea()}");