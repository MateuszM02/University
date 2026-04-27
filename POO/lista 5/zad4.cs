namespace oop5
{
    #region Original PersonRegistry
    public class PersonRegistryOG
    {
        /// <summary>
        /// Pierwszy stopień swobody - różne wczytywanie
        /// </summary>
        public List<Person> GetPersons()
        {
            return [ new(), new()];
        }

        /// <summary>
        /// Drugi stopień swobody - różne użycie
        /// </summary>
        public void NotifyPersons()
        {
            foreach (Person person in GetPersons())
                Console.WriteLine(person);
        }
    }
    public class Person { }
    #endregion

    #region Bridge I - abstract notify
    public abstract class PersonRegistry1
    {
        protected PersonNotifier1 notifier;

        public PersonRegistry1(PersonNotifier1 notifier) 
        { 
            this.notifier = notifier;
        }

        public abstract IEnumerable<Person> GetPersons();

        public void NotifyPersons()
        {
            this.notifier.NotifyPersons(this.GetPersons());
        }
    }

    public abstract class PersonNotifier1
    {
        public abstract void NotifyPersons(IEnumerable<Person> persons);
    }

    public class SmtpPersonNotifier1 : PersonNotifier1
    {
        public override void NotifyPersons(IEnumerable<Person> persons)
        {
            // implementacja notify przez smtp
            Console.WriteLine("Notify SMTP");
        }
    }
    #endregion

    #region Bridge II - abstract registry
    public abstract class PersonRegistry2
    {
        public abstract IEnumerable<Person> GetPersons();
    }

    public abstract class PersonNotifier2
    {
        protected PersonRegistry2 registry;

        public PersonNotifier2(PersonRegistry2 registry)
        {
            this.registry = registry;
        }

        public IEnumerable<Person> GetPersons()
        {
            return this.registry.GetPersons();
        }

        public abstract void NotifyPersons(IEnumerable<Person> persons);
    }

    public class SqlPersonRegistry2 : PersonRegistry2
    {
        public override IEnumerable<Person> GetPersons()
        {
            return []; // implementacja SQL query
        }
    }
    #endregion
}
