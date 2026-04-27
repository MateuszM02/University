namespace InversionOfControl
{
    // lista 9
    public abstract class ObjectCreator
    {
        private Type? type;
        public Type? Type
        {
            get => type;
            set => type = value;
        }
        protected object? instance = null;

        public ObjectCreator() { }
        public ObjectCreator(Type type)
        {
            this.type = type;
        }

        public abstract object? InstantiateObject();
    }

    public class ObjectCreatorSingleton(Type type) : ObjectCreator(type)
    {
        private static readonly object _lock = new();

        public override object? InstantiateObject()
        {
            if (instance == null)
            {
                lock (_lock)
                {
                    // double checking after acquiring lock
                    instance ??= Activator.CreateInstance(this.Type);
                }
            }
            return instance;
        }
    }

    public class ObjectCreatorSimple(Type type) : ObjectCreator(type)
    {
        public override object? InstantiateObject()
        {
            instance = Activator.CreateInstance(this.Type);
            return instance;
        }
    }

    // lista 10 -------------------------------------------------------------------------

    public class ObjectCreatorInstance : ObjectCreator
    {
        public ObjectCreatorInstance(object instance) : base()
        {
            this.instance = instance;
        }

        public override object? InstantiateObject()
        {
            return this.instance;
        }
    }

    [AttributeUsage(AttributeTargets.Constructor)]
    public class DepedencyConstructorAttribute : Attribute
    {
        public DepedencyConstructorAttribute() { }
    }
}