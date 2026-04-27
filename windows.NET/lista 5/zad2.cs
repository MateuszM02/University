using System.Collections.Generic;
using System.Dynamic;
using System.Linq.Expressions;
using System.Reflection;

namespace Zad2
{
    // The class derived from DynamicObject.
    public class DynamicDictionary : DynamicObject
    {
        Dictionary<string, object> fieldDictionary = [];

        public int Count => fieldDictionary.Count;

        public static string MyConvert(int x)
        {
            return x.ToString();
        }

        public static string MyConvert(double x)
        {
            return x.ToString();
        }

        // If you try to get a value of a property
        // not defined in the class, this method is called.
        public override bool TryGetMember(
            GetMemberBinder binder, out object? result)
        {
            string name = binder.Name.ToLower();

            // If the property name is found in a dictionary,
            // set the result parameter to the property value and return true.
            // Otherwise, return false.
            return fieldDictionary.TryGetValue(name, out result);
        }

        // If you try to set a value of a property that is
        // not defined in the class, this method is called.
        public override bool TrySetMember(
            SetMemberBinder binder, object value)
        {
            fieldDictionary[binder.Name.ToLower()] = value;
            return true;
        }

        // used when called like: x = dynamic['prop1'] or xy = dynamic['prop1', 'prop2']
        // indexes must be strings - keys of dictionary
        public override bool TryGetIndex(
            GetIndexBinder binder, object[] indexes, out object? result)
        {
            if (indexes.Length == 1)
            {
                return fieldDictionary.TryGetValue(indexes[0].ToString().ToLower(), out result);
            }
            else
            {
                object[] results = new object[indexes.Length];
                for (int i = 0; i < indexes.Length; i++)
                {
                    if (!fieldDictionary.TryGetValue(
                        indexes[i].ToString().ToLower(), out results[i]))
                    {
                        result = null;
                        return false;
                    }
                }
                result = results;
                return true;
            }
        }

        // use case 1:
        // x['propname'] = value;
        // use case 2:
        // xy['prop1', 'prop2'] = [value1, value2];
        public override bool TrySetIndex(
            SetIndexBinder binder, object[] indexes, object value)
        {
            // use case 1
            if (value is not object[] && indexes.Length == 1)
            {
                fieldDictionary[indexes[0].ToString().ToLower()] = value;
                return true;
            }
            // use case 2
            else if (value is object[] values && 
                indexes.Length == values.Length)
            {
                for (int i = 0; i < indexes.Length; i++)
                {
                    fieldDictionary[indexes[i].ToString().ToLower()] = 
                        values.ElementAt(i);
                }
                return true;
            }
            return false;
        }

        // invoke only if method exists
        public override bool TryInvoke(
            InvokeBinder binder, object?[]? args, out object? result)
        {
            result = null;
            var methods = typeof(DynamicDictionary).GetMethods();

            // find correct method to call
            foreach (var method in methods)
            {
                // Check if the method parameters match the arguments
                var parameters = method.GetParameters();
                if (parameters.Length == args.Length &&
                    parameters.Select(p => p.ParameterType)
                    .SequenceEqual(args.Select(a => a.GetType())))
                {
                    // Invoke the method if the parameters match
                    result = method.Invoke(null, args);
                    return true;
                }
            }

            return false;
        }

        // Calling a method.
        public override bool TryInvokeMember(
            InvokeMemberBinder binder, object[] args, out object? result)
        {
            Type dictType = typeof(DynamicDictionary);
            try
            {
                result = dictType.InvokeMember(
                             binder.Name,
                             BindingFlags.InvokeMethod | BindingFlags.Public
                             | BindingFlags.Static | BindingFlags.NonPublic,
                             null, null, args);
                return true;
            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
                result = null;
                return false;
            }
        }

        // negate value in dictionary field "number"
        public override bool TryUnaryOperation(
            UnaryOperationBinder binder, out object? result)
        {
            if (binder.Operation == ExpressionType.Negate)
            {
                if (fieldDictionary.TryGetValue("number", out object? number)
                    && number is IConvertible)
                {
                    result = -Convert.ToDouble(number);
                    return true;
                }
            }

            result = null;
            return false;
        }

        // add value to dictionary field "number"
        public override bool TryBinaryOperation(
            BinaryOperationBinder binder, object arg, out object? result)
        {
            if (binder.Operation == ExpressionType.Add)
            {
                if (fieldDictionary.TryGetValue("number", out object? number) 
                    && arg is IConvertible)
            {
                    result = Convert.ToDouble(number) + Convert.ToDouble(arg);
                    return true;
                }
            }

            result = null;
            return false;
        }
    }

    public class Program
    {
        private static void TestMember()
        {
            dynamic person = new DynamicDictionary();

            // Adding new dynamic properties.
            // The TrySetMember method is called.
            person.FirstName = "Ellen";
            person.LastName = "Adams";

            // Getting values of the dynamic properties.
            // The TryGetMember method is called.
            Console.WriteLine(person.firstname + " " + person.lastname);
        }

        private static void TestIndexerSingle()
        {
            dynamic person = new DynamicDictionary();

            // Adding new dynamic properties - 1st way.
            // The TrySetIndex method is called.
            person["FirstName"] = "Ellen";
            person["LastName"] = "Adams1";

            // Getting values of the dynamic properties - 1st way.
            // The TryGetIndex method is called.
            Console.WriteLine(person["firstname"] + " " + person["lastname"]);
        }

        private static void TestIndexerMany()
        {
            dynamic person = new DynamicDictionary();

            // Adding new dynamic properties - 2nd way.
            // The TrySetIndex method is called.
            person["FirstName", "LastName"] = new[] { "Ellen", "Adams2" };

            // Getting values of the dynamic properties - 2nd way.
            // The TryGetIndex method is called.
            dynamic values = person["firstname", "lastname"];
            Console.WriteLine(values[0] + " " + values[1]);
        }

        private static void TestInvoke()
        {
            dynamic person = new DynamicDictionary();
            person.FirstName = "Ellen";
            person.LastName = "Adams3";
            string s1 = person(1); // call TryInvoke
            string s2_5 = person.MyConvert(2.5); // call TryInvokeMember
        }

        private static void TestUnary()
        {
            dynamic dict = new DynamicDictionary();
            dict.number = 10; // Ustawienie wartości
            Console.WriteLine(-dict); // Wywołanie TryUnaryOperation
        }

        private static void TestBinary()
        {
            dynamic dict = new DynamicDictionary();
            dict.number = 10; // Ustawienie wartości
            Console.WriteLine(dict + 5); // Wywołanie TryBinaryOperation
        }


        public static void Main()
        {
            TestMember();
            TestIndexerSingle();
            TestIndexerMany();
            TestInvoke();
            TestUnary();
            TestBinary();
        }
    }
}
