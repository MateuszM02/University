namespace zad1
{
    #region EventAggregator
    public interface IEventAggregator
    {
        void AddSubscriber<T>(ISubscriber<T> Subscriber);
        void RemoveSubscriber<T>(ISubscriber<T> Subscriber);
        void Publish<T>(T Event);
    }


    public class EventAggregator : IEventAggregator
    {
        Dictionary<Type, List<object>> _subscribers = [];

        public void AddSubscriber<T>(ISubscriber<T> Subscriber)
        {
            if (!_subscribers.ContainsKey(typeof(T)))
                _subscribers.Add(typeof(T), []);
            _subscribers[typeof(T)].Add(Subscriber);
        }
        public void RemoveSubscriber<T>(ISubscriber<T> Subscriber)
        {
            if (_subscribers.ContainsKey(typeof(T)))
                _subscribers[typeof(T)].Remove(Subscriber);
        }

        public void Publish<T>(T Event)
        {
            if (_subscribers.ContainsKey(typeof(T)))
               foreach (ISubscriber<T> subscriber in
                        _subscribers[typeof(T)].OfType<ISubscriber<T>>())
                    subscriber.Handle(Event);
        }
    }
    #endregion

    #region Notifications
    public interface ISubscriber<T>
    {
        void Handle(T Notification);
    }

    public class CategorySelectedNotification : ISubscriber<string>
    {
        private string _selectedCategory;
        public void Handle(string Notification)
        {
            _selectedCategory = Notification;
            throw new NotImplementedException();
        }
    }
    #endregion
}