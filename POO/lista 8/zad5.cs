using System.Reflection.PortableExecutable;

namespace oop8
{
    public class Zad5
    {
        public static void Main()
        {
            ;
        }

        public class AtmMachine
        {
            private IState state;

            public AtmMachine(Dictionary<int, double> paymentCards)
            {
                this.state = new IdleState(this, paymentCards);
            }

            public void SetState(IState newState) { this.state = newState; }
            public void InsertCard(int cardNumber) { this.state.InsertCard(cardNumber); }
            public void ShowBalance() { this.state.ShowBalance(); }
            public void WithdrawCash(int amount) { this.state.WithdrawCash(amount); }
            public void EjectCard() { this.state.EjectCard(); }
        }

        public interface IState
        {
            void InsertCard(int cardNumber);
            void ShowBalance();
            void WithdrawCash(int amount);
            void EjectCard();
        }

        public class IdleState
            (AtmMachine machine, Dictionary<int, double> paymentCards) : IState
        {
            private readonly AtmMachine _machine = machine;
            private readonly Dictionary<int, double> _paymentCards = paymentCards;

            public void EjectCard()
            {
                throw new InvalidOperationException("No card to be ejected");
            }

            public void InsertCard(int cardNumber)
            {
                if (!_paymentCards.ContainsKey(cardNumber))
                    throw new InvalidOperationException("Unknown card");
                _machine.SetState(
                    new CardInsertedState(_machine, cardNumber, _paymentCards));
            }

            public void ShowBalance()
            {
                throw new InvalidOperationException("Can't show balance - no card inserted");
            }

            public void WithdrawCash(int amount)
            {
                throw new InvalidOperationException("Can't withdraw - no card inserted");
            }
        }

        public class CardInsertedState
            (AtmMachine machine, int cardNumber, 
            Dictionary<int, double> paymentCards) : IState
        {
            private AtmMachine _machine = machine;
            private int _cardNumber = cardNumber;
            private Dictionary<int, double> _paymentCards = paymentCards;

            public void EjectCard()
            {
                Console.WriteLine("Card successfully ejected");
                _machine.SetState(new IdleState(_machine, _paymentCards));
            }

            public void InsertCard(int cardNumber)
            {
                throw new InvalidOperationException("Card already inserted");
            }

            public void ShowBalance()
            {
                Console.WriteLine(_paymentCards[_cardNumber]);
            }

            public void WithdrawCash(int amount)
            {
                if (_paymentCards[_cardNumber] < amount)
                {
                    Console.WriteLine("Not enough funds on account");
                    return;
                }
                Console.WriteLine($"Succesfully withdrew {amount}");
                _paymentCards[_cardNumber] -= amount;
            }
        }
    }
}
