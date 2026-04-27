namespace net9
{
    public abstract class IClientState(Client client, CancellationTokenSource clientTokenSource)
    {
        protected readonly Client _client = client;
        public readonly CancellationTokenSource _clientTokenSource = clientTokenSource;
    
        public abstract void CheckBarberState();
        public abstract void GetShaved();
        public abstract void WaitForShaving();
    }

    public class Client
    {
        private IClientState _state;

        public Client(Barber barber, CancellationTokenSource clientToken)
        {
            this._state = new ClientCheckingBarberState(this, barber, clientToken);
        }

        public CancellationTokenSource GetTokenSource() { return this._state._clientTokenSource; }
        public void CancelToken() { this._state._clientTokenSource.Cancel(); }
        public void SetState(IClientState newState) { this._state = newState; }
        public void CheckBarberState() { this._state.CheckBarberState(); }
        public void GetShaved() { this._state.GetShaved(); }
        public void WaitForShaving() { this._state.WaitForShaving(); }
    }

    // STATE 1 of 3
    public class ClientCheckingBarberState : IClientState
    {
        private readonly Barber _barber;

        public ClientCheckingBarberState
            (Client client, Barber barber, CancellationTokenSource clientToken) : base(client, clientToken)
        {
            Console.WriteLine("Client checks barber state");
            _barber = barber;
            this.CheckBarberState();
        }

        public override void CheckBarberState()
        {
            Manager.NewClientInWaitingRoom(this._client);
            Manager.WaitOne();
            if (this._barber.IsState(typeof(BarberShavingState)))
            {
                Manager.ReleaseMutex();
                this._client.SetState(new ClientWaitingState(
                                        this._client, this._barber, this._clientTokenSource));
            }
            else if (this._barber.IsState(typeof(BarberSleepingState)))
            {
                Manager.ReleaseMutex();
                var barberTokenSource = this._barber.GetTokenSource();
                barberTokenSource.Cancel(); // wake up barber

                //this._barber.SetState(new BarberShavingState(
                //                        this._barber, this._client, barberTokenSource));
                //this._client.SetState(new ClientBeingShavedState(this._client, this._clientTokenSource));
            }
        }

        public override void GetShaved()
        {
            throw new InvalidOperationException("Can't get shaved in check barber state");
        }

        public override void WaitForShaving()
        {
            throw new InvalidOperationException("Can't go waiting in check barber state");
        }
    }

    // STATE 2 of 3
    public class ClientWaitingState : IClientState
    {
        private readonly Barber _barber;

        public ClientWaitingState
            (Client client, Barber barber, CancellationTokenSource clientToken) : base(client, clientToken)
        {
            Console.WriteLine("Client went to waiting room");
            this._barber = barber;
            this.WaitForShaving();
        }

        public override void CheckBarberState()
        {
            throw new InvalidOperationException("Can't check barber state while waiting");
        }

        public override void GetShaved()
        {
            throw new InvalidOperationException("Can't get shaved while in waiting room");
        }

        public override void WaitForShaving()
        {
            //Manager.ReleaseMutex();
            while (!this._clientTokenSource.Token.IsCancellationRequested)
            {
                Thread.Sleep(100);
            }
            //this._barber.SetState(new BarberShavingState(
              //                          this._barber, this._client, this._barber.GetTokenSource()));
            //this._client.SetState(new ClientBeingShavedState(this._client, this._clientTokenSource));
        }
    }

    // STATE 3 of 3
    public class ClientBeingShavedState : IClientState
    {
        public ClientBeingShavedState
            (Client client, CancellationTokenSource clientToken) : base(client, clientToken)
        {
            //Console.WriteLine("Client started being shaved");
            this.GetShaved();
        }

        public override void CheckBarberState()
        {
            throw new InvalidOperationException("Can't check barber state while being shaved");
        }

        public override void GetShaved()
        {
            //Thread.Sleep(Manager.GetShavingTime());
        }

        public override void WaitForShaving()
        {
            throw new InvalidOperationException("Can't wait for shaving while being shaved");
        }
    }
}
