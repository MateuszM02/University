namespace oop7
{
    public partial class Form1 : Form
    {
        Bitmap clockBMP, hourBMP, minuteBMP, secondBMP;

        public Form1()
        {
            InitializeComponent();
            clockBMP = new("clock.png");
            hourBMP = new("arrowHR.png");
            minuteBMP = new("arrowMIN.png");
            secondBMP = new("arrowSEC.png");
        }

        private void Form1_Load(object sender, EventArgs e)
        {
        }

        private void TimerClick(object sender, EventArgs e)
        {
            DateTime now = DateTime.Now;
            int hour = now.Hour;
            int minute = now.Minute;
            int second = now.Second;

            float angleS = second * 6;
            float angleM = minute * 6 + angleS / 60;
            float angleH = hour * 30 + angleM / 12;

            ClockBox.Image = clockBMP;
            ClockBox.Controls.Add(HourBox);

            HourBox.Location = new(130, 109);
            HourBox.Image = RotateImage(hourBMP, angleH);
            HourBox.Controls.Add(MinuteBox);

            MinuteBox.Location = new(4, 5);
            MinuteBox.Image = RotateImage(minuteBMP, angleM);
            MinuteBox.Controls.Add(SecondBox);

            SecondBox.Location = new(-30, -18);
            SecondBox.Image = RotateImage(secondBMP, angleH);
        }

        private static Bitmap RotateImage(Bitmap bmp, float angle)
        {
            Bitmap rotatedBmp = new(bmp.Width, bmp.Height);
            using (Graphics g = Graphics.FromImage(rotatedBmp))
            {
                g.TranslateTransform(bmp.Width / 2, bmp.Height / 2);
                g.RotateTransform(angle);
                g.TranslateTransform(-bmp.Width / 2, -bmp.Height / 2);
                g.DrawImage(rotatedBmp, new Point(0, 0));
            }
            return rotatedBmp;
        }
    }
}