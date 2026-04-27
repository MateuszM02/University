namespace oop6
{
    public abstract class Tree
    {
        public int Value { get; set; }
    }
    public class TreeNode : Tree
    {
        public Tree? Left { get; set; }
        public Tree? Right { get; set; }
    }
    public class TreeLeaf : Tree
    {
        
    }

    public abstract class TreeVisitor
    {
        public abstract int Visit(Tree? tree);
        protected abstract int VisitLeaf(TreeLeaf leaf);
        protected abstract int VisitNode(TreeNode node);
    }

    public class DepthTreeVisitor : TreeVisitor
    {
        public override int Visit(Tree? tree) 
        {
            return tree switch
            {
                TreeNode node => VisitNode(node),
                TreeLeaf leaf => VisitLeaf(leaf),
                _ => throw new ArgumentException("Wrong type of tree"),
            };
        }

        protected override int VisitLeaf(TreeLeaf _) 
        {
            return 1;
        }

        protected override int VisitNode(TreeNode node)
        {
            if (node == null)
                return 0;
            int depthL = Visit(node.Left);
            int depthR = Visit(node.Right);
            return Math.Max(depthL, depthR);
        }
    }
}