namespace lista_2
{
    public class Grid
    {
        public readonly int rows;
        public readonly int columns;
        private int[][] __values;

        public Grid(int rows, int columns)
        {
            this.rows = rows;
            this.columns = columns;
            this.__values = new int[this.rows][];
            for (int row = 0; row < this.rows; row++)
            {
                this.__values[row] = new int[this.columns];
            }
        }

        public int[] this[int row]
        {
            get => this.__values[row];
        }

        public int this[int row, int col]
        {
            get => this.__values[row][col];
        }
    }
}
