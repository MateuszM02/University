using System.Net;
using System.Runtime.CompilerServices;
using System.Security.Policy;

namespace oop7
{
    public partial class Form4 : Form
    {
        private HttpClient httpClient = new();
        private WebClient webClient = new();
        private Button asyncButton;
        private Button syncButton;
        private Button clearButton;
        private TextBox resultTextBox;
        private TextBox userTextBox;

        private System.Windows.Forms.Timer timer;
        private string URL = "https://pl.wikipedia.org/wiki/Polska";
        private bool isRed = true;

        public Form4()
        {
            asyncButton = new Button 
            { 
                Text = "Async Download" 
            };
            syncButton = new Button 
            { 
                Text = "Sync Download", 
                Left = asyncButton.Width 
            };
            clearButton = new Button 
            { 
                Text = "Clear TextBox", 
                Left = asyncButton.Width + syncButton.Width ,
                ForeColor = Color.Red,
            };
            resultTextBox = new TextBox 
            { 
                Multiline = true, 
                Width = 200, 
                Height = 200, 
                Top = asyncButton.Height + 10 
            };
            userTextBox = new TextBox
            {
                Multiline = true,
                Width = 200,
                Height = 100,
                Top = asyncButton.Height + 220
            };
            timer = new()
            {
                Interval = 1000,
            };

            asyncButton.Click += async (sender, e) => await DownloadContentAsync();
            syncButton.Click += (sender, e) => DownloadContentSync();
            clearButton.Click += (sender, e) => resultTextBox.Text = "";
            timer.Tick += (sender, e) => ChangeColor();

            Controls.Add(asyncButton);
            Controls.Add(syncButton);
            Controls.Add(clearButton);
            Controls.Add(resultTextBox);
            Controls.Add(userTextBox);
            timer.Start();
            // InitializeComponent();
        }

        private async Task DownloadContentAsync()
        {
            try
            {
                string content = await httpClient.GetStringAsync(URL);
                resultTextBox.Text = content;
            }
            catch (Exception ex)
            {
                resultTextBox.Text = $"Error: {ex.Message}";
            }
        }

        private void DownloadContentSync()
        {
            try
            {
                string content = webClient.DownloadString(URL);
                resultTextBox.Text = content;
            }
            catch (Exception ex)
            {
                resultTextBox.Text = $"Error: {ex.Message}";
            }
        }

        private void ChangeColor()
        {
            if (isRed)
                clearButton.ForeColor = Color.GreenYellow;
            else
                clearButton.ForeColor = Color.Red;
            isRed = !isRed;
        }
    }
}
