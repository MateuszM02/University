namespace oop7
{
    public partial class SmoothProgressBar : Control
    {
        private float min = 0;
        private float max = 100;
        private float value = 0;

        public float Min
        {
            get { return min; }
            set { min = value; Invalidate(); }
        }

        public float Max
        {
            get { return max; }
            set { max = value; Invalidate(); }
        }

        public float Value
        {
            get { return this.value; }
            set { this.value = value; Invalidate(); }
        }

        public SmoothProgressBar()
        {
            InitializeComponent();
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);
            Graphics g = e.Graphics;

            // Rysowanie tła paska postępu
            g.FillRectangle(Brushes.LightGray, 0, 0, Width, Height);

            // Obliczanie długości paska postępu
            float proportion = (value - min) / (max - min);
            float progressBarWidth = Width * proportion;

            // Rysowanie gładkiego paska postępu
            g.FillRectangle(Brushes.Blue, 0, 0, progressBarWidth, Height);

            // //Draw percentage
            //Rectangle rect = this.ClientRectangle;
            //Graphics g = pe.Graphics;
            //ProgressBarRenderer.DrawHorizontalBar(g, rect);
            //if (this.Value > 0)
            //{
            //    Rectangle clip = new Rectangle(rect.X, rect.Y, (int)Math.Round(((float)this.Value / this.Maximum) * rect.Width), rect.Height);
            //    ProgressBarRenderer.DrawHorizontalChunks(g, clip);
            //}
            //using (Font f = new Font(FontFamily.GenericMonospace, 10))
            //{
            //    SizeF size = g.MeasureString(string.Format("{0} %", this.Value), f);
            //    Point location = new Point((int)((rect.Width / 2) - (size.Width / 2)), (int)((rect.Height / 2) - (size.Height / 2) + 2));
            //    g.DrawString(string.Format("{0} %", this.Value), f, Brushes.Black, location);
            //}
        }
    }
}
