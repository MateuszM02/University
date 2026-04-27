using System.Collections;

namespace lista_3
{
    internal class BinaryTreeNode<T>
        (T value, BinaryTreeNode<T>? left = null, BinaryTreeNode<T>? right = null)
         : IEnumerable<T>
    {
        T value = value;
        BinaryTreeNode<T>? left = left;
        BinaryTreeNode<T>? right = right;

        /// <summary>
        /// domyslny enumerator to przeszukiwanie wgłąb
        /// </summary>
        /// <returns>kolekcja elementów w kolejności DFS</returns>
        public IEnumerator<T> GetEnumerator()
        {
            if (this.left != null)
                foreach (T? item in this.left)
                    yield return item;
            yield return this.value;
            if (this.right != null)
                foreach (T? item in this.right)
                    yield return item;
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        /// <summary>
        /// enumerator do przeszukiwania wszerz
        /// </summary>
        /// <returns>kolekcja elementów w kolejności BFS</returns>
        public IEnumerable<T> BFS()
        {
            List<T> enumerator = [];
            Queue<BinaryTreeNode<T>> queue = new();
            queue.Enqueue(this);
            while (queue.Count > 0) 
            {
                BinaryTreeNode<T>? temp = queue.Dequeue();
                enumerator.Add(temp!.value);
                if (temp.left != null)
                    queue.Enqueue(temp.left);
                if (temp.right != null)
                    queue.Enqueue(temp.right);
            }
            return enumerator;
        }

        public static BinaryTreeNode<int> ExampleTree()
        {
            BinaryTreeNode<int> tree1 = new(1);
            BinaryTreeNode<int> tree3 = new(3);
            BinaryTreeNode<int> tree5 = new(5);
            BinaryTreeNode<int> tree7 = new(7);
            BinaryTreeNode<int> tree2 = new(2, tree1, tree3);
            BinaryTreeNode<int> tree6 = new(6, tree5, tree7);
            BinaryTreeNode<int> tree = new(4, tree2, tree6);
            return tree;
        }
    }
}
