using System.Reflection;

namespace InversionOfControl
{
    // lista 9
    public class SimpleContainer
    {
        // bind Type to class instantiating objects
        public readonly Dictionary<Type, ObjectCreator> typeDict = [];

        public void RegisterType<T>(bool Singleton) where T : class
        {
            if (Singleton)
            {
                typeDict[typeof(T)] = new ObjectCreatorSingleton(typeof(T));
            }
            else
            {
                typeDict[typeof(T)] = new ObjectCreatorSimple(typeof(T));
            }
        }
        public void RegisterType<From, To>(bool Singleton) where To : From
        {
            if (Singleton)
            {
                typeDict[typeof(From)] = new ObjectCreatorSingleton(typeof(To));
            }
            else
            {
                typeDict[typeof(From)] = new ObjectCreatorSimple(typeof(To));
            }
        }

        //public T? Resolve<T>() where T : class
        //{
        //    Type t = typeof(T);
        //    if (typeDict.TryGetValue(t, out ObjectCreator? value))
        //        return (T?)value.InstantiateObject();

        //    if (t.IsAbstract)
        //        throw new InvalidCastException("Can't resolve abstract class. Register related type.");

        //    if (t.IsInterface)
        //        throw new InvalidCastException("Can't resolve interface. Register related type.");

        //    // T is not yet registered -> register as simple object and resolve
        //    this.RegisterType<T>(false);
        //    return this.Resolve<T>();
        //}

        // lista 10 ---------------------------------------------------------------------

        public void RegisterInstance<T>(T instance)
        {
            if (this.typeDict.ContainsKey(instance.GetType()))
            {
                typeDict[typeof(T)] = new ObjectCreatorInstance(instance);
            }
            else
            {
                typeDict.Add(typeof(T), new ObjectCreatorInstance(instance));
            }
        }

        public T? Resolve<T>() where T : class
        {
            return this.RecursiveResolve<T>([]);
        }

        private T BasicResolve<T>() where T : class
        {
            Type type = typeof(T);
            if (type.IsInterface || type.IsAbstract)
            {
                if (typeDict.TryGetValue(type, out ObjectCreator? value))
                {
                    ObjectCreator creator = value;
                    return (T)creator.InstantiateObject();
                }
                else
                {
                    throw new InvalidOperationException("Given class is not registred!");
                }
            }
            else
            {
                if (typeDict.TryGetValue(type, out ObjectCreator? value))
                {
                    ObjectCreator creator = value;
                    return (T)creator.InstantiateObject();
                }
                else
                {
                    // T is not yet registered -> register as simple object and resolve
                    T instance = (T)Activator.CreateInstance(type);
                    this.RegisterInstance<T>(instance);
                    return instance;
                }
            }
        }

        private T RecursiveResolve<T>(List<Type> list) where T : class
        {
            Type type = typeof(T);
            if (list.Contains(type))
            {
                throw new InvalidOperationException("Dependency cycle detected.");
            }

            ConstructorInfo? info = FindLongestConstructor(typeof(T));
            if (info == null || info.GetParameters().Length == 0)
            {
                return BasicResolve<T>();
            }
            ParameterInfo[] paramInfo = info.GetParameters();
            object[] arguments = new object[paramInfo.Length];
            int argCounter = 0;

            if (type.IsPrimitive)
            {
                return default;
            }

            if (paramInfo.Length == 0)
            {
                return BasicResolve<T>();
            }

            if (typeDict.TryGetValue(type, out ObjectCreator? value))
            {
                if (value.GetType() == typeof(ObjectCreatorInstance))
                {
                    return (T)value.InstantiateObject();
                }
            }

            for (int i = 0; i < paramInfo.Length; i++)
            {
                List<Type> tmp = [];
                foreach (var item in list)
                {
                    tmp.Add(item);
                }
                Type paramType = paramInfo[i].ParameterType;
                tmp.Add(type);
                
                MethodInfo method = typeof(SimpleContainer)
                    .GetMethod("RecursiveResolve", 
                        BindingFlags.NonPublic | BindingFlags.Instance) 
                    ?? throw new InvalidDataException("Can't find given method");
                MethodInfo? generic = method.MakeGenericMethod(paramType);

                arguments[argCounter] = generic.Invoke(this, [tmp]);
                
                argCounter++;
            }
            return (T)info.Invoke(arguments);
        }

        private ConstructorInfo? FindLongestConstructor(Type type)
        {
            int longestParametersNumber = 0;
            int howManyLongestConstructors = 0;
            int howManyDependencyConstructors = 0;
            ConstructorInfo? longestInfo = null;
            ConstructorInfo? dependencyInfo = null;
            ConstructorInfo[] ci = type.GetConstructors();

            for (int i = 0; i < ci.Length; i++)
            {
                ParameterInfo[] paramInfo = ci[i].GetParameters();
                if (paramInfo.Length > longestParametersNumber)
                {
                    longestParametersNumber = paramInfo.Length;
                    longestInfo = ci[i];
                    howManyLongestConstructors = 1;
                }
                else if (paramInfo.Length == longestParametersNumber)
                {
                    howManyLongestConstructors++;
                }
                foreach (CustomAttributeData a in ci[i].CustomAttributes)
                {
                    if (a.AttributeType == typeof(DepedencyConstructorAttribute))
                    {
                        howManyDependencyConstructors++;
                        dependencyInfo = ci[i];
                    }
                }
            }

            if (howManyDependencyConstructors > 1)
            {
                throw new InvalidDataException("More than 1 dependency constructor!");
            }
            if (howManyDependencyConstructors == 1)
            {
                return dependencyInfo;
            }
            if (howManyLongestConstructors > 1)
            {
                throw new InvalidDataException("More than 1 constructor with most amount of arguments!");
            }
            if (howManyLongestConstructors == 1)
            {
                return longestInfo;
            }

            return null;
        }

            public static void Main()
        {
            ;
        }
    }
}
