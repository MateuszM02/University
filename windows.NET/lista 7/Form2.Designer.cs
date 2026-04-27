namespace oop7
{
    partial class Form2 : Form
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            smoothProgressBar1 = new SmoothProgressBar();
            button1 = new Button();
            button2 = new Button();
            SuspendLayout();
            // 
            // smoothProgressBar1
            // 
            smoothProgressBar1.Location = new Point(40, 40);
            smoothProgressBar1.Max = 100F;
            smoothProgressBar1.Min = 0F;
            smoothProgressBar1.Name = "smoothProgressBar1";
            smoothProgressBar1.Size = new Size(600, 25);
            smoothProgressBar1.TabIndex = 0;
            smoothProgressBar1.Text = "smoothProgressBar1";
            smoothProgressBar1.Value = 0F;
            // 
            // button1
            // 
            button1.Font = new Font("Segoe UI", 16F);
            button1.Location = new Point(40, 140);
            button1.Name = "button1";
            button1.Size = new Size(200, 50);
            button1.TabIndex = 1;
            button1.Text = "backgroundWorker";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // button2
            // 
            button2.Font = new Font("Segoe UI", 16F);
            button2.Location = new Point(440, 140);
            button2.Name = "button2";
            button2.Size = new Size(200, 50);
            button2.TabIndex = 2;
            button2.Text = "Thread";
            button2.UseVisualStyleBackColor = true;
            button2.Click += button2_Click;
            // 
            // Form2
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(685, 202);
            Controls.Add(button2);
            Controls.Add(button1);
            Controls.Add(smoothProgressBar1);
            Name = "Form2";
            Text = "Form2";
            ResumeLayout(false);
        }

        #endregion

        private SmoothProgressBar smoothProgressBar1;
        private Button button1;
        private Button button2;
    }
}