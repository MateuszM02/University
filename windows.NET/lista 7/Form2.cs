using System.ComponentModel;

namespace oop7
{
    public partial class Form2 : Form
    {
        private BackgroundWorker sortNumberWorker;
        private Thread sortThread;

        public Form2()
        {
            InitializeComponent();
            InitializeBackgroundWorker();
        }

        // ---------------------------------------------------------------

        private void InitializeBackgroundWorker()
        {
            sortNumberWorker = new()
            {
                WorkerReportsProgress = true
            };
            sortNumberWorker.DoWork += new(SortNumberWorker_DoWork);
            sortNumberWorker.ProgressChanged += new(SortNumberWorker_ProgressChanged);
            sortNumberWorker.RunWorkerCompleted += new(SortNumberWorker_RunWorkerCompleted);
        }

        // ---------------------------------------------------------------

        private static bool IsPrime(int number)
        {
            if (number < 2)
                return false;
            else if (number % 2 == 0)
                return number == 2;
            for (int i = 3; i <= Math.Sqrt(number); i += 2)
            {
                if (number % i == 0)
                    return false;
            }
            return true;
        }

        private void PerformCalculations()
        {
            PerformCalculations(false);
        }

        private void PerformCalculations(bool useWorker)
        {
            int max = 5_000_000;
            for (int i = 1; i <= max; i++)
            {
                if (IsPrime(i))
                {
                    // Próba aktualizacji paska postępu z innego wątku
                    float progressPercentage = (float)(100 * i) / (float)(max);

                    if (useWorker)
                    {
                        sortNumberWorker.ReportProgress((int)progressPercentage);
                    }
                    else // To może spowodować wyjątek
                        smoothProgressBar1.Value = progressPercentage;
                }
            }
        }

        // ---------------------------------------------------------------

        private void SortNumberWorker_DoWork(object? sender, DoWorkEventArgs e)
        {
            PerformCalculations(true);
        }

        private void SortNumberWorker_RunWorkerCompleted(object? sender, RunWorkerCompletedEventArgs e)
        {
            // Ta metoda zostanie wywołana, gdy BackgroundWorker zakończy pracę
        }

        private void SortNumberWorker_ProgressChanged(object? sender, ProgressChangedEventArgs e)
        {
            smoothProgressBar1.Value = e.ProgressPercentage;
        }

        // ---------------------------------------------------------------

        private void SortInBackground(bool useWorker)
        {
            smoothProgressBar1.Min = 0f;
            smoothProgressBar1.Max = 100f;
            smoothProgressBar1.Value = 0f;

            if (useWorker)
            {
                // Uruchomienie BackgroundWorkera do sortowania
                if (!sortNumberWorker.IsBusy)
                {
                    sortNumberWorker.RunWorkerAsync();
                }
            }
            else
            {
                // Uruchomienie wątku do sortowania
                if (sortThread == null || !sortThread.IsAlive)
                {
                    sortThread = new Thread(PerformCalculations);
                    sortThread.Start();
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SortInBackground(true);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SortInBackground(false);
        }
    }
}
