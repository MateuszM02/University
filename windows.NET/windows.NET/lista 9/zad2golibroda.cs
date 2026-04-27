namespace net9
{
    public abstract class IBarberState(Barber barber, CancellationTokenSource barberTokenSource)
    {
        protected readonly Barber _barber = barber;
        protected CancellationTokenSource _barberTokenSource = barberTokenSource;

        public CancellationTokenSource GetTokenSource() => _barberTokenSource;
        public abstract void Sleep();
        public abstract void ShaveClient(Client client);
        public abstract void CheckWaitingRoom();
    }

    public class Barber
    {
        private IBarberState _state;

        public Barber(CancellationTokenSource barberTokenSource)
        {
            this._state = new BarberSleepingState(this, barberTokenSource);
        }

        public bool IsState(Type stateType) { return this._state.GetType() == stateType; }
        public CancellationTokenSource GetTokenSource() { return this._state.GetTokenSource(); }
        public void SetState(IBarberState newState) { this._state = newState; }
        public void Sleep() { this._state.Sleep(); }
        public void ShaveClient(Client client) { this._state.ShaveClient(client); }
        public void CheckWaitingRoom() { this._state.CheckWaitingRoom(); }
    }

    // STATE 1 of 3
    public class BarberSleepingState : IBarberState
    {
        public BarberSleepingState
            (Barber barber, CancellationTokenSource barberTokenSource) : base(barber, barberTokenSource)
        {
            Console.WriteLine("Barber went asleep...");
            if (Manager.IsMutexLocked())
                this.Sleep();
        }

        public override void CheckWaitingRoom()
        {
            throw new InvalidOperationException("Barber cant check waiting room while sleeping");
        }

        public override void ShaveClient(Client client)
        {
            throw new InvalidOperationException("Barber cant shave while sleeping");
        }

        public override void Sleep()
        {
            Manager.ReleaseMutex();
            int waitedTime = 0;
            while (!this._barberTokenSource.IsCancellationRequested)
            {
                Thread.Sleep(100);
                waitedTime += 100;
                if (waitedTime >= 3000 && !Manager.AnyClientInQueue())
                {
                    Console.WriteLine("There are no more clients, time to go home");
                    return;
                }
            }
            try
            {
                Client client = Manager.TakeOneClientFromWaitingRoom();
                this._barberTokenSource = new CancellationTokenSource();
                
                Thread barberThread = new(
                    () => this._barber.SetState(
                            new BarberShavingState(this._barber, client, this._barberTokenSource)));

                Thread clientThread = new(
                    () => client.SetState(
                            new ClientBeingShavedState(client, client.GetTokenSource())));

                barberThread.Start();
                clientThread.Start();
                barberThread.Join();
                clientThread.Join();
            }
            catch (Exception e) // no clients in queue, go back to sleeping
            {
                Console.WriteLine("There are no more clients, time to go home");
                //this._barber.SetState(new BarberSleepingState(
                //                        this._barber, this._barberTokenSource));
            }
        }
    }

    // STATE 2 of 3
    public class BarberShavingState : IBarberState
    {
        public BarberShavingState
            (Barber barber, Client client, CancellationTokenSource barberTokenSource) : base(barber, barberTokenSource)
        {
            Console.WriteLine("Barber started shaving client");
            this.ShaveClient(client);
        }

        public override void CheckWaitingRoom()
        {
            throw new InvalidOperationException("Barber cant check waiting room while shaving");
        }

        public override void ShaveClient(Client client)
        {
            Manager.ReleaseMutex();
            Thread.Sleep(Manager.GetShavingTime());
            this._barber.SetState(new BarberCheckingState(this._barber, this._barberTokenSource));
        }

        public override void Sleep()
        {
            throw new InvalidOperationException("Barber can't sleep while shaving");
        }
    }

    // STATE 3 of 3
    public class BarberCheckingState : IBarberState
    {
        public BarberCheckingState
            (Barber barber, CancellationTokenSource barberTokenSource) : base(barber, barberTokenSource)
        {
            Console.WriteLine("Barber ended shaving client and went to waiting room");
            this.CheckWaitingRoom();
        }

        public override void CheckWaitingRoom()
        {
            Manager.WaitOne();
            if (Manager.AnyClientInQueue())
            {
                Client client = Manager.TakeOneClientFromWaitingRoom();
                this._barber.SetState(new BarberShavingState(
                                        this._barber, client, this._barberTokenSource));
                client.SetState(new ClientBeingShavedState(client, client.GetTokenSource()));
            }
            else // no clients in queue
            {
                this._barber.SetState(new BarberSleepingState(this._barber, new CancellationTokenSource()));
            }
        }

        public override void ShaveClient(Client client)
        {
            throw new InvalidOperationException("Barber can't shave while checking waiting room");
        }

        public override void Sleep()
        {
            throw new InvalidOperationException("Barber can't sleep while checking waiting room");
        }
    }
}
