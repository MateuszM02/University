namespace lista_6
{
    partial class Form1
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
            GroupBox1 = new GroupBox();
            label2 = new Label();
            label1 = new Label();
            TextBox2 = new TextBox();
            TextBox1 = new TextBox();
            GroupBox2 = new GroupBox();
            checkBox2 = new CheckBox();
            checkBox1 = new CheckBox();
            label3 = new Label();
            comboBox1 = new ComboBox();
            button1 = new Button();
            button2 = new Button();
            toolTip1 = new ToolTip(components);
            GroupBox1.SuspendLayout();
            GroupBox2.SuspendLayout();
            SuspendLayout();
            // 
            // GroupBox1
            // 
            GroupBox1.Controls.Add(label2);
            GroupBox1.Controls.Add(label1);
            GroupBox1.Controls.Add(TextBox2);
            GroupBox1.Controls.Add(TextBox1);
            GroupBox1.Location = new Point(20, 15);
            GroupBox1.Name = "GroupBox1";
            GroupBox1.Size = new Size(540, 100);
            GroupBox1.TabIndex = 0;
            GroupBox1.TabStop = false;
            GroupBox1.Text = "Uczelnia";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(5, 65);
            label2.Name = "label2";
            label2.Size = new Size(40, 15);
            label2.TabIndex = 3;
            label2.Text = "Adres:";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(5, 30);
            label1.Name = "label1";
            label1.Size = new Size(45, 15);
            label1.TabIndex = 2;
            label1.Text = "Nazwa:";
            // 
            // TextBox2
            // 
            TextBox2.Location = new Point(70, 60);
            TextBox2.Name = "TextBox2";
            TextBox2.Size = new Size(460, 23);
            TextBox2.TabIndex = 1;
            // 
            // TextBox1
            // 
            TextBox1.Location = new Point(70, 25);
            TextBox1.Name = "TextBox1";
            TextBox1.Size = new Size(460, 23);
            TextBox1.TabIndex = 0;
            // 
            // GroupBox2
            // 
            GroupBox2.Controls.Add(checkBox2);
            GroupBox2.Controls.Add(checkBox1);
            GroupBox2.Controls.Add(label3);
            GroupBox2.Controls.Add(comboBox1);
            GroupBox2.Location = new Point(20, 125);
            GroupBox2.Name = "GroupBox2";
            GroupBox2.Size = new Size(540, 100);
            GroupBox2.TabIndex = 1;
            GroupBox2.TabStop = false;
            GroupBox2.Text = "Rodzaj studiów";
            // 
            // checkBox2
            // 
            checkBox2.AutoSize = true;
            checkBox2.Location = new Point(140, 70);
            checkBox2.Name = "checkBox2";
            checkBox2.Size = new Size(98, 19);
            checkBox2.TabIndex = 6;
            checkBox2.Text = "uzupełniające";
            checkBox2.UseVisualStyleBackColor = true;
            checkBox2.CheckedChanged += checkBox2_CheckedChanged;
            // 
            // checkBox1
            // 
            checkBox1.AutoSize = true;
            checkBox1.Checked = true;
            checkBox1.CheckState = CheckState.Checked;
            checkBox1.Location = new Point(70, 70);
            checkBox1.Name = "checkBox1";
            checkBox1.Size = new Size(67, 19);
            checkBox1.TabIndex = 5;
            checkBox1.Text = "dzienne";
            checkBox1.UseVisualStyleBackColor = true;
            checkBox1.CheckedChanged += checkBox1_CheckedChanged;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(3, 45);
            label3.Name = "label3";
            label3.Size = new Size(65, 15);
            label3.TabIndex = 4;
            label3.Text = "Cykl nauki:";
            // 
            // comboBox1
            // 
            comboBox1.AllowDrop = true;
            comboBox1.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBox1.FormattingEnabled = true;
            comboBox1.Items.AddRange(new object[] { "3-letnie", "3,5-letnie" });
            comboBox1.Location = new Point(70, 40);
            comboBox1.Name = "comboBox1";
            comboBox1.Size = new Size(460, 23);
            comboBox1.TabIndex = 0;
            // 
            // button1
            // 
            button1.Location = new Point(20, 230);
            button1.Name = "button1";
            button1.Size = new Size(75, 23);
            button1.TabIndex = 2;
            button1.Text = "Akceptuj";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // button2
            // 
            button2.Location = new Point(485, 230);
            button2.Name = "button2";
            button2.Size = new Size(75, 23);
            button2.TabIndex = 3;
            button2.Text = "Anuluj";
            button2.UseVisualStyleBackColor = true;
            button2.Click += button2_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(239, 235, 223);
            ClientSize = new Size(584, 261);
            Controls.Add(button2);
            Controls.Add(button1);
            Controls.Add(GroupBox2);
            Controls.Add(GroupBox1);
            Name = "Form1";
            Text = "Wybór uczelni";
            Load += Form1_Load;
            GroupBox1.ResumeLayout(false);
            GroupBox1.PerformLayout();
            GroupBox2.ResumeLayout(false);
            GroupBox2.PerformLayout();
            ResumeLayout(false);
        }

        private void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        #endregion

        private GroupBox GroupBox1;
        private GroupBox GroupBox2;
        private TextBox TextBox1;
        private Label label1;
        private TextBox TextBox2;
        private Label label2;
        private ComboBox comboBox1;
        private Label label3;
        private CheckBox checkBox2;
        private CheckBox checkBox1;
        private Button button1;
        private Button button2;
        private ToolTip toolTip1;
    }
}
