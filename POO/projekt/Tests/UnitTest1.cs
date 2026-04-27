using InversionOfControl;

namespace Tests
{
    // lista 9
    public interface IEmpty
    { }

    public class EmptyClass : IEmpty
    {
        public EmptyClass() { }
    }

    public class EmptyClass2 : IEmpty
    {
        public EmptyClass2() { }
    }

    public class EmptyStringClass : IEmpty 
    { 
        public EmptyStringClass(string _) { }
    }

    public class EmptyIntClass : IEmpty
    {
        public EmptyIntClass(int _) { }
    }

    [TestClass]
    public class SimpleContainerTests
    {
        [TestMethod]
        public void ShouldHaveEmptyTypeDictOnInitialization()
        {
            SimpleContainer container = new();
            Assert.AreEqual(0, container.typeDict.Count);
        }

        [TestMethod]
        public void ShouldHaveOneTypeInDictAfterOneRegister()
        {
            SimpleContainer container = new();
            container.RegisterType<EmptyClass>(false);

            Assert.AreEqual(1, container.typeDict.Count);
            Assert.IsFalse(container.typeDict.TryGetValue(typeof(IEmpty), out _));
            Assert.IsTrue(container.typeDict.TryGetValue(typeof(EmptyClass), out _));
            Assert.IsFalse(container.typeDict.TryGetValue(typeof(EmptyClass2), out _));
        }

        [TestMethod]
        public void ShouldReturnDifferentObjectsIfNotUsedSingleton()
        {
            SimpleContainer container = new();
            container.RegisterType<EmptyClass>(false);
            EmptyClass? e1 = container.Resolve<EmptyClass>();
            EmptyClass? e2 = container.Resolve<EmptyClass>();

            Assert.IsNotNull(e1);
            Assert.IsNotNull(e2);
            Assert.AreNotEqual(e1, e2);
        }

        [TestMethod]
        public void ShouldReturnSameObjectTwiceIfUsedSingleton()
        {
            SimpleContainer container = new();
            container.RegisterType<EmptyClass>(true);
            EmptyClass? e1 = container.Resolve<EmptyClass>();
            EmptyClass? e2 = container.Resolve<EmptyClass>();

            Assert.IsNotNull(e1);
            Assert.AreEqual(e1, e2);
        }

        [TestMethod]
        public void ShouldAddTwoTypesToDictIfUsedRegisterMethodWith2Parameters()
        {
            SimpleContainer container = new();
            container.RegisterType<IEmpty, EmptyClass>(true);

            EmptyClass? e = container.Resolve<EmptyClass>();

            Assert.IsNotNull(e);
            Assert.AreEqual(2, container.typeDict.Count);
            Assert.IsTrue(container.typeDict.TryGetValue(typeof(IEmpty), out _));
            Assert.IsTrue(container.typeDict.TryGetValue(typeof(EmptyClass), out _));
            Assert.IsFalse(container.typeDict.TryGetValue(typeof(EmptyClass2), out _));
        }

        [TestMethod]
        public void ShouldReturnDifferentObjectsIfUsedDifferentRegisterMethods()
        {
            SimpleContainer container = new();
            container.RegisterType<IEmpty, EmptyClass>(true);
            container.RegisterType<IEmpty, EmptyClass2>(true);

            EmptyClass? e1 = container.Resolve<EmptyClass>();
            EmptyClass2? e2 = container.Resolve<EmptyClass2>();

            Assert.IsNotNull(e1);
            Assert.IsNotNull(e2);
            Assert.AreEqual(3, container.typeDict.Count);
            Assert.IsTrue(container.typeDict.TryGetValue(typeof(IEmpty), out _));
            Assert.IsTrue(container.typeDict.TryGetValue(typeof(EmptyClass), out _));
            Assert.IsTrue(container.typeDict.TryGetValue(typeof(EmptyClass2), out _));
        }
    }

    // lista 10 -------------------------------------------------------------------------

    [TestClass]
    public class SimpleContainerTests10
    {
        [TestMethod]
        public void ShouldRegisterOneInstanceOfEmptyClass()
        {
            SimpleContainer container = new();
            EmptyStringClass es = new("string param");
            container.RegisterInstance(es);

            Assert.IsTrue(container.typeDict.TryGetValue(typeof(EmptyClass), out _));
            Assert.AreEqual(1, container.typeDict.Count);
            Assert.IsTrue(container.typeDict.ContainsKey(typeof(EmptyClass)));
        }

        [TestMethod]
        public void ShouldRegisterOneInstanceOfStringClassWithPossibleEmptyStringResolve()
        {
            SimpleContainer container = new();
            container.RegisterInstance("string param");
            EmptyStringClass? es = container.Resolve<EmptyStringClass>();

            Assert.AreEqual(1, container.typeDict.Count);
            Assert.IsTrue(container.typeDict.ContainsKey(typeof(string)));
            Assert.IsFalse(container.typeDict.ContainsKey(typeof(EmptyStringClass)));
            Assert.IsNotNull(es);
        }

        [TestMethod]
        public void ShouldFailToRegisterOneInstanceOfEmptyStringClass()
        {
            SimpleContainer container = new();
            // container.RegisterInstance("string param");

            Assert.ThrowsException<InvalidOperationException>(container.Resolve<EmptyIntClass>);
            Assert.AreEqual(0, container.typeDict.Count);
        }
    }
}