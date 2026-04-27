namespace zad1
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
            userTreeView = new TreeView();
            infoPanel = new Panel();
            infoDataGridView = new DataGridView();
            infoPanel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)infoDataGridView).BeginInit();
            SuspendLayout();
            // 
            // userTreeView
            // 
            userTreeView.Dock = DockStyle.Left;
            userTreeView.Location = new Point(0, 0);
            userTreeView.Name = "userTreeView";
            userTreeView.Size = new Size(251, 450);
            userTreeView.TabIndex = 0;
            userTreeView.AfterSelect += treeView1_AfterSelect;
            // 
            // infoPanel
            // 
            infoPanel.Controls.Add(infoDataGridView);
            infoPanel.Location = new Point(257, 0);
            infoPanel.Name = "infoPanel";
            infoPanel.Size = new Size(543, 450);
            infoPanel.TabIndex = 1;
            // 
            // infoDataGridView
            // 
            infoDataGridView.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            infoDataGridView.Location = new Point(0, 3);
            infoDataGridView.Name = "infoDataGridView";
            infoDataGridView.Size = new Size(540, 444);
            infoDataGridView.TabIndex = 0;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(infoPanel);
            Controls.Add(userTreeView);
            Name = "Form1";
            Text = "Kartoteka";
            infoPanel.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)infoDataGridView).EndInit();
            ResumeLayout(false);
        }

        #endregion

        private TreeView userTreeView;
        private Panel infoPanel;
        private DataGridView infoDataGridView;
    }
}
