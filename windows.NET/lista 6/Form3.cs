using System.Configuration;

namespace lista_6
{
    public partial class Form3 : Form
    {
        public Form3()
        {
            InitializeComponent();
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            saveFileDialog1 = new SaveFileDialog();
            saveFileDialog1.FileName = "winformslogo.png";
            saveFileDialog1.InitialDirectory = Directory.GetCurrentDirectory();

            folderBrowserDialog1 = new FolderBrowserDialog();
            folderBrowserDialog1.InitialDirectory = Directory.GetCurrentDirectory();

            openFileDialog1 = new OpenFileDialog();
            openFileDialog1.InitialDirectory = Directory.GetCurrentDirectory();

            // zadanie 4.
            label_string.Text = 
                ConfigurationManager.AppSettings["ExampleString"]!.ToString();
            label_int.Text = 
                ConfigurationManager.AppSettings["ExampleInt"]!.ToString();
            label_bool.Text = 
                ConfigurationManager.AppSettings["ExampleBool"]!.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult dr = openFileDialog1.ShowDialog();
            if (dr == DialogResult.OK)
            {
                pictureBox1.Image = Image.FromFile(openFileDialog1.FileName);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DialogResult dr = saveFileDialog1.ShowDialog();
            if (dr == DialogResult.OK)
            {
                pictureBox1.Image.Save(saveFileDialog1.FileName);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult dr = folderBrowserDialog1.ShowDialog();
            if (dr == DialogResult.OK)
            {
                openFileDialog1.InitialDirectory 
                    = folderBrowserDialog1.RootFolder.ToString();
                saveFileDialog1.InitialDirectory
                    = folderBrowserDialog1.RootFolder.ToString();
            }
        }
    }

}
