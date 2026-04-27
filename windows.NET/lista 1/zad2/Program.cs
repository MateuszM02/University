using Sq = Square.Square;
using Rc = Rectangle.Rectangle;
using RI = Rectangle.Zad5Internal;

Sq s = new(5);
Console.WriteLine($"(c1) Area of square with side length {s.x}: {s.GetArea()}");

Rc r = new(6, 8);
Console.WriteLine($"(c1) Area of rectangle with sides {r.a}, {r.b}: {r.GetArea()}");
RI.PrintIntx(r);
// r.intx; error: Rectangle.intx is inaccessible due to its protection level