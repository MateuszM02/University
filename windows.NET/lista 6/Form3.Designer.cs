namespace lista_6
{
    partial class Form3
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form3));
            openFileDialog1 = new OpenFileDialog();
            button1 = new Button();
            saveFileDialog1 = new SaveFileDialog();
            button2 = new Button();
            pictureBox1 = new PictureBox();
            button3 = new Button();
            folderBrowserDialog1 = new FolderBrowserDialog();
            label_string = new Label();
            label_int = new Label();
            label_bool = new Label();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            SuspendLayout();
            // 
            // openFileDialog1
            // 
            openFileDialog1.FileName = "openFileDialog1";
            openFileDialog1.InitialDirectory = "C:\\Users\\USER\\AppData\\Local\\Microsoft\\VisualStudio\\17.0_157249a5\\WinFormsDesigner\\hr4asplz.w5j";
            openFileDialog1.Title = "Open";
            // 
            // button1
            // 
            button1.Location = new Point(417, 12);
            button1.Name = "button1";
            button1.Size = new Size(143, 58);
            button1.TabIndex = 0;
            button1.Text = "OpenFileDialog";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // saveFileDialog1
            // 
            saveFileDialog1.InitialDirectory = "C:\\Users\\USER\\AppData\\Local\\Microsoft\\VisualStudio\\17.0_157249a5\\WinFormsDesigner\\hr4asplz.w5j";
            // 
            // button2
            // 
            button2.Location = new Point(417, 106);
            button2.Name = "button2";
            button2.Size = new Size(143, 58);
            button2.TabIndex = 1;
            button2.Text = "SaveFileDialog";
            button2.UseVisualStyleBackColor = true;
            button2.Click += button2_Click;
            // 
            // pictureBox1
            // 
            pictureBox1.Image = (Image)resources.GetObject("pictureBox1.Image");
            pictureBox1.Location = new Point(12, 12);
            pictureBox1.MaximumSize = new Size(329, 244);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new Size(329, 244);
            pictureBox1.SizeMode = PictureBoxSizeMode.StretchImage;
            pictureBox1.TabIndex = 2;
            pictureBox1.TabStop = false;
            // 
            // button3
            // 
            button3.Location = new Point(417, 198);
            button3.Name = "button3";
            button3.Size = new Size(143, 58);
            button3.TabIndex = 3;
            button3.Text = "FolderBrowserDialog";
            button3.UseVisualStyleBackColor = true;
            button3.Click += button3_Click;
            // 
            // label_string
            // 
            label_string.AutoSize = true;
            label_string.Font = new Font("Segoe UI", 24F);
            label_string.Location = new Point(233, 282);
            label_string.Name = "label_string";
            label_string.Size = new Size(182, 45);
            label_string.TabIndex = 4;
            label_string.Text = "label_string";
            // 
            // label_int
            // 
            label_int.AutoSize = true;
            label_int.Font = new Font("Segoe UI", 24F);
            label_int.Location = new Point(233, 336);
            label_int.Name = "label_int";
            label_int.Size = new Size(138, 45);
            label_int.TabIndex = 5;
            label_int.Text = "label_int";
            // 
            // label_bool
            // 
            label_bool.AutoSize = true;
            label_bool.Font = new Font("Segoe UI", 24F);
            label_bool.Location = new Point(233, 390);
            label_bool.Name = "label_bool";
            label_bool.Size = new Size(166, 45);
            label_bool.TabIndex = 6;
            label_bool.Text = "label_bool";
            // 
            // Form3
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(label_bool);
            Controls.Add(label_int);
            Controls.Add(label_string);
            Controls.Add(button3);
            Controls.Add(pictureBox1);
            Controls.Add(button2);
            Controls.Add(button1);
            Name = "Form3";
            Text = "Form3";
            Load += Form3_Load;
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private OpenFileDialog openFileDialog1;
        private Button button1;
        private SaveFileDialog saveFileDialog1;
        private Button button2;
        private PictureBox pictureBox1;
        private Button button3;
        private FolderBrowserDialog folderBrowserDialog1;
        private Label label_string;
        private Label label_int;
        private Label label_bool;
    }
}