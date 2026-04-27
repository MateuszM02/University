namespace lista_2
{
    internal class Zad34
    {
        private int backingField;
        public int PropertyWithBackingField
        {
            get => backingField;
            set => backingField = value >= 0 ? value : 0; // assign only non-negative values 
        }

        public int AutoImplementedProperty { get; private set; }
    }

    public class Person
    {
        private string? name;
        public string? Name
        {
            get => name;
            set
            {
                if (name != value)
                {
                    name = value;
                    OnValueChanged(nameof(Name));
                }
            }
        }

        private string? surname;
        public string? Surname
        {
            get => surname;
            set
            {
                if (surname != value)
                {
                    surname = value;
                    OnValueChanged(nameof(Surname));
                }
            }
        }

        public delegate void PersonEventHandler(object sender, PropertyChangedEventArgs e);
        public event PersonEventHandler? ValueChanged;

        protected virtual void OnValueChanged(string propertyName)
        {
            ValueChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    /// <summary>
    /// Class that informs event subscriber which property was changed before event call
    /// </summary>
    public class PropertyChangedEventArgs : EventArgs
    {
        public string PropertyName { get; }

        public PropertyChangedEventArgs(string propertyName)
        {
            PropertyName = propertyName;
        }
    }
}
