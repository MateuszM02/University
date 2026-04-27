namespace oop7
{
    partial class Form1 : Form
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            panel1 = new Panel();
            SecondBox = new PictureBox();
            MinuteBox = new PictureBox();
            HourBox = new PictureBox();
            ClockBox = new PictureBox();
            timer = new System.Windows.Forms.Timer(components);
            panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)SecondBox).BeginInit();
            ((System.ComponentModel.ISupportInitialize)MinuteBox).BeginInit();
            ((System.ComponentModel.ISupportInitialize)HourBox).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ClockBox).BeginInit();
            SuspendLayout();
            // 
            // panel1
            // 
            panel1.BackColor = Color.Transparent;
            panel1.BackgroundImage = Properties.Resources.wall;
            panel1.Controls.Add(SecondBox);
            panel1.Controls.Add(MinuteBox);
            panel1.Controls.Add(HourBox);
            panel1.Controls.Add(ClockBox);
            panel1.Location = new Point(0, 0);
            panel1.Name = "panel1";
            panel1.Size = new Size(784, 462);
            panel1.TabIndex = 3;
            // 
            // SecondBox
            // 
            SecondBox.Image = Properties.Resources.arrowSEC;
            SecondBox.Location = new Point(634, 285);
            SecondBox.Name = "SecondBox";
            SecondBox.Size = new Size(50, 140);
            SecondBox.SizeMode = PictureBoxSizeMode.StretchImage;
            SecondBox.TabIndex = 3;
            SecondBox.TabStop = false;
            // 
            // MinuteBox
            // 
            MinuteBox.Image = Properties.Resources.arrowMIN;
            MinuteBox.Location = new Point(634, 131);
            MinuteBox.Name = "MinuteBox";
            MinuteBox.Size = new Size(50, 140);
            MinuteBox.SizeMode = PictureBoxSizeMode.StretchImage;
            MinuteBox.TabIndex = 2;
            MinuteBox.TabStop = false;
            // 
            // HourBox
            // 
            HourBox.Image = Properties.Resources.arrowHR;
            HourBox.Location = new Point(634, 25);
            HourBox.Name = "HourBox";
            HourBox.Size = new Size(50, 100);
            HourBox.SizeMode = PictureBoxSizeMode.StretchImage;
            HourBox.TabIndex = 1;
            HourBox.TabStop = false;
            // 
            // ClockBox
            // 
            ClockBox.Image = Properties.Resources.clock;
            ClockBox.Location = new Point(200, 25);
            ClockBox.Name = "ClockBox";
            ClockBox.Size = new Size(400, 400);
            ClockBox.SizeMode = PictureBoxSizeMode.StretchImage;
            ClockBox.TabIndex = 0;
            ClockBox.TabStop = false;
            // 
            // timer
            // 
            timer.Enabled = true;
            timer.Tick += TimerClick;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(784, 461);
            Controls.Add(panel1);
            DoubleBuffered = true;
            Name = "Form1";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Form1";
            Load += Form1_Load;
            panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)SecondBox).EndInit();
            ((System.ComponentModel.ISupportInitialize)MinuteBox).EndInit();
            ((System.ComponentModel.ISupportInitialize)HourBox).EndInit();
            ((System.ComponentModel.ISupportInitialize)ClockBox).EndInit();
            ResumeLayout(false);
        }

        #endregion
        private Panel panel1;
        private PictureBox ClockBox;
        private PictureBox SecondBox;
        private PictureBox MinuteBox;
        private PictureBox HourBox;
        private System.Windows.Forms.Timer timer;
    }
}
