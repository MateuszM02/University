using Zad4;

Animal horse = new("horse", 3);
horse.ReverseName();
Console.WriteLine(horse.type);
Console.WriteLine(horse.IsOld());

namespace Zad4
{
    /// <summary>
    /// Class that allows you to create animal objects with their name and age
    /// </summary>
    /// <param name="type">type of animal</param>
    /// <param name="age">age of animal</param>
    public class Animal(string type, int age)
    {
        /// <summary>
        /// type of animal
        /// </summary>
        public string type = type;
        private int age = age;
        /// <summary>
        /// property getting/setting animal's age
        /// </summary>
        public int Age { get { return age; } set { age = value; } }

        /// <summary>
        /// indekser - suma liczb i + j
        /// </summary>
        /// <param name="i">pierwsza liczba do sumowania</param>
        /// <param name="j">druga liczba do sumowania</param>
        /// <returns>suma i + j</returns>
        public int this[int i, int j]
        {
            get { return i + j; }
        }

        /// <summary>
        /// creates default animal of "unknown" type and age 0
        /// </summary>
        public Animal() : this("unknown", 0) { }

        /// <summary>
        /// delegat of type bool()
        /// </summary>
        /// <returns>whether some condition is met or not </returns>
        public delegate bool IsValidDelegate();

        /// <summary>
        /// Checks whether some condition is met or not
        /// </summary>
        /// <param name="validDelegate">validator to check condition</param>
        /// <returns>true if condition is met, false otherwise</returns>
        public bool IsValid(IsValidDelegate validDelegate)
        {
            return validDelegate();
        }

        // methods

        /// <summary>
        /// checks whether animal has valid age (assume max age for animal is 30)
        /// </summary>
        /// <returns>true if animal has valid age, false otherwise</returns>
        public bool IsAgeValid()
        {
            return this.Age >= 0 && this.Age < 30;
        }

        /// <summary>
        /// checks whether animal has non-empty type
        /// </summary>
        /// <returns>true if animal has non-empty type, false otherwise</returns>
        public bool IsNameOfTypeValid()
        {
            return !string.IsNullOrEmpty(this.type);
        }

        /// <summary>
        /// Odwraca napis zawarty w this.name
        /// </summary>
        public void ReverseName()
        {
            if (this.type != null)
            {
                char[] nameChars = this.type.ToCharArray();
                for (int i = 0; i < nameChars.Length / 2; i++)
                {
                    (nameChars[nameChars.Length - 1 - i], nameChars[i]) 
                        = (nameChars[i], nameChars[nameChars.Length - 1 - i]);
                }
                this.type = new string(nameChars);
            }
        }

        /// <summary>
        /// assigns age category of this animal object
        /// </summary>
        /// <returns>string describing animal's age: "young", "middle age" or "old"</returns>
        public string IsOld()
        {
            return this.Age switch
            {
                >=0 and <4 => "young",
                >=4 and <8 => "middle age",
                >=8 => "old",
                _ => "invalid age!",
            };
        }
    }

    /// <summary>
    /// delegate
    /// </summary>
    /// <typeparam name="T">type of information</typeparam>
    /// <param name="e">argument of event call</param>
    public delegate void EventDelegate<T>(EventArgsClass<T> e);

    /// <summary>
    /// Argumens of event
    /// </summary>
    /// <typeparam name="T">type of information</typeparam>
    public class EventArgsClass<T>
    {
        /// <summary>
        /// information to show
        /// </summary>
        public T? informacja = default;
        private EventArgsClass() { }
        /// <summary>
        /// constructor creating object and assigning info to it
        /// </summary>
        /// <param name="informacja">info to assign</param>
        public EventArgsClass(T informacja)
        {
            this.informacja = informacja;
        }
    }

    /// <summary>
    /// Event sender
    /// </summary>
    /// <typeparam name="T">type of event</typeparam>
    public class EventSender<T>
    {
        /// <summary>
        /// arguments of event
        /// </summary>
        public event EventDelegate<T>? EventArgs;

        /// <summary>
        /// called to trigger event
        /// </summary>
        /// <param name="e">arguments of event</param>
        public void TriggerEvent(EventArgsClass<T> e)
        {
            this.EventArgs!(e);
        }
    }
}