namespace lista_2
{
    public class Vector
    {
        public double x;
        public double y;
        public Vector(double x, double y)
        {
            this.x = x;
            this.y = y;
        }

        public static Vector operator +(Vector v1, Vector v2) 
        {
            return new Vector(v1.x + v2.x, v1.y + v2.y);
        }

        /// <summary>
        /// iloczyn skalarny wektorów
        /// </summary>
        /// <param name="v1">wektor pierwszy</param>
        /// <param name="v2">wektor drugi</param>
        /// <returns>iloczyn skalarny v1 * v2</returns>
        public static double operator *(Vector v1, Vector v2)
        {
            return v1.x * v2.x + v1.y * v2.y;
        }
    }
}
