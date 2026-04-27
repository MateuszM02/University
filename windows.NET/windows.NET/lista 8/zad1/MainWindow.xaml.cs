using System.Text;
using System.Windows;
using System.Windows.Media;

namespace lista_8
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void DzienneChbox_Checked(object sender, RoutedEventArgs e)
        {
            if (UzupChbox != null)
                UzupChbox.IsChecked = !DzienneChbox.IsChecked;
        }

        private void UzupChbox_Checked(object sender, RoutedEventArgs e)
        {
            if (DzienneChbox != null)
                DzienneChbox.IsChecked = !UzupChbox.IsChecked;
        }

        private void AkceptujBtn_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder sb = new();
            sb.AppendLine(NazwaTxtbox.Text);
            sb.AppendLine(AdresTxtbox.Text);
            sb.AppendLine("Studia " + CyklCmbox.Text);
            string typ = (bool)DzienneChbox.IsChecked! ? "dzienne" : "uzupełniające";
            sb.AppendLine(typ);
            MessageBox.Show(sb.ToString(), "Uczelnia");
        }

        private void AnulujBtn_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
    }
}