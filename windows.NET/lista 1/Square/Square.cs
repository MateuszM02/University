namespace Square
{
    public class Square(float x)
    {
        public float x = x;
        public float GetArea()
        {
            return x * x;
        }
    }
}
