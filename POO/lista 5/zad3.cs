using System.Collections;

namespace oop5
{
    public class IntSorter : IComparer
    {
        #region IComparer Members
     
        public int Compare(object x, object y)
        {
            return ((int) x ).CompareTo((int) y);
        }
  
        #endregion
    }

    public class ComparisonToIComparerAdapter : IComparer
    {
        private Comparison<int> _comparison;

        public ComparisonToIComparerAdapter(Comparison<int> comparison) 
        { 
            this._comparison = comparison;
        }

        public int Compare(object? x, object? y)
        {
            return _comparison((int)x, (int)y);
        }
    }

    public class Zad3
    {
        public static void Main()
        {
            // IComparer -> Comparison<int>
            Comparison<int> comparison = 
                (x, y) => new IntSorter().Compare(x, y);
            // Comparison<int> -> IComparer
            IComparer comparer = new ComparisonToIComparerAdapter(comparison);
        }
    }
}
