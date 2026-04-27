using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace test4
{
    [TestClass]
    public class ShapeFactoryTests
    {
        [TestMethod]
        public void RegisterWorkerTest()
        {
            oop4.ShapeFactory factory = new oop4.ShapeFactory();
            factory.RegisterWorker(new oop4.SquareWorker());
            oop4.IShape squareWorker = factory.CreateShape("sQuaRe", 4.76);
            oop4.IShape triangleWorker = factory.CreateShape("Triangle", 3, 4, 5);

            Assert.IsNotNull(squareWorker);
            Assert.IsNotNull(triangleWorker);
            Assert.ThrowsException<ArgumentException>(
               () =>
               {
                   factory.CreateShape("ShapeThatDoesntExist", 42);
               });
            Assert.IsFalse(squareWorker.Equals(triangleWorker));
            Assert.AreEqual(squareWorker.GetArea(), 4.76 * 4.76);
        }
    }
}
