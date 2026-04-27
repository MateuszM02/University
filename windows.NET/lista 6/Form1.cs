using System.Text;

namespace lista_6
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            ;
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox1.Checked)
                checkBox2.Checked = false;
        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox2.Checked)
                checkBox1.Checked = false;
        }


        private void button1_Click(object sender, EventArgs e)
        {
            // Akceptuj, pokaz inne okno
            string chbox = checkBox1.Checked ? checkBox1.Text : checkBox2.Text;
            StringBuilder sb = new();
            sb.Append($"{TextBox1.Text}\n");
            sb.Append($"{TextBox2.Text}\n");
            sb.Append($"Studia {comboBox1.Text}\n");
            sb.Append($"{chbox}\n");
            MessageBox.Show(sb.ToString(), "Uczelnia");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
