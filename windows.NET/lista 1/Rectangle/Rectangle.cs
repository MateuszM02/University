namespace Rectangle
{
    public class Rectangle(float a, float b)
    {
        public float a = a;
        public float b = b;
        internal string intx = "this is internal variable";
        public float GetArea()
        {
            return a * b;
        }
    }
}
