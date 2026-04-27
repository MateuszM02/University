namespace zad1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            TreeNode studenci = new("studenci");
            TreeNode wykladowcy = new("wykladowcy");
            userTreeView.Nodes.Add(studenci);
            userTreeView.Nodes.Add(wykladowcy);

            studenci.Nodes.Add("MM");
            studenci.Nodes.Add("ML");
            
            wykladowcy.Nodes.Add("WZ");

            //infoDataGridView.Rows.Add(userTreeView.Nodes);
        }

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {

        }
    }
}
