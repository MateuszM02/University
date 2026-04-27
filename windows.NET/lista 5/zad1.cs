using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

namespace lista_5
{
    // wymagany BenchmarkDotNet
    [SimpleJob(launchCount: 1, warmupCount: 1, iterationCount: 1)]
    public class Zad1
    {
        [Params(2, 12, 123456789)]
        public double X { get; set; }

        [Params(2, 21, 987654321)]
        public double Y { get; set; }

        [Benchmark]
        public double TestAdd1() => Add1(X, Y);

        [Benchmark]
        public dynamic TestAdd2() => Add2(X, Y);

        // porównanie łatwych metod - dodawanie 2 liczb
        private static double Add1(double x, double y)
        {
            return x + y;
        }

        private static dynamic Add2(dynamic x, dynamic y)
        {
            return x + y;
        }

        // porównanie trudniejszej metody - mnożenie macierzy
        private readonly Random random = new();

        public double[,] Matrix3x3A { get; private set; }
        public double[,] Matrix3x3B { get; private set; }
        public double[,] Matrix5x20A { get; private set; }
        public double[,] Matrix20x5B { get; private set; }
        public double[,] Matrix20x5A { get; private set; }
        public double[,] Matrix5x20B { get; private set; }

        [GlobalSetup]
        public void Setup()
        {
            Matrix3x3A = GenerateRandomMatrix(3, 3);
            Matrix3x3B = GenerateRandomMatrix(3, 3);
            Matrix5x20A = GenerateRandomMatrix(5, 20);
            Matrix20x5B = GenerateRandomMatrix(20, 5);
            Matrix20x5A = GenerateRandomMatrix(20, 5);
            Matrix5x20B = GenerateRandomMatrix(5, 20);
        }

        private double[,] GenerateRandomMatrix(int rows, int columns)
        {
            double[,] matrix = new double[rows, columns];
            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < columns; j++)
                {
                    matrix[i, j] = random.NextDouble() * 200 - 100;
                }
            }
            return matrix;
        }

        [Benchmark]
        public double[,] TestMM1_3x3() => MM1(Matrix3x3A, Matrix3x3B);

        [Benchmark]
        public double[,] TestMM1_5x20_20x5() => MM1(Matrix5x20A, Matrix20x5B);

        [Benchmark]
        public double[,] TestMM1_20x5_5x20() => MM1(Matrix20x5A, Matrix5x20B);

        [Benchmark]
        public double[,] TestMM2_3x3() => MM2(Matrix3x3A, Matrix3x3B);

        [Benchmark]
        public double[,] TestMM2_5x20_20x5() => MM2(Matrix5x20A, Matrix20x5B);

        [Benchmark]
        public double[,] TestMM2_20x5_5x20() => MM2(Matrix20x5A, Matrix5x20B);

        private static double[,] MM1(double[,] A, double[,] B)
        {
            int aRows = A.GetLength(0);
            int aCols = A.GetLength(1);
            int bRows = B.GetLength(0);
            int bCols = B.GetLength(1);
            if (aCols != bRows)
                throw new ArgumentException("Nieprawidłowe wymiary macierzy");

            double[,] result = new double[aRows, bCols];
            for (int i = 0; i < aRows; i++)
            {
                for (int j = 0; j < bCols; j++)
                {
                    for (int k = 0; k < aCols; k++)
                    {
                        result[i, j] += A[i, k] * B[k, j];
                    }
                }
            }
            return result;
        }

        private static dynamic MM2(dynamic A, dynamic B)
        {
            int aRows = A.GetLength(0);
            int aCols = A.GetLength(1);
            int bRows = B.GetLength(0);
            int bCols = B.GetLength(1);
            if (aCols != bRows)
                throw new ArgumentException("Nieprawidłowe wymiary macierzy");

            dynamic result = new double[aRows, bCols];
            for (int i = 0; i < aRows; i++)
            {
                for (int j = 0; j < bCols; j++)
                {
                    for (int k = 0; k < aCols; k++)
                    {
                        result[i, j] += A[i, k] * B[k, j];
                    }
                }
            }
            return result;
        }

        // odpal testy
        public static void CompareAdd()
        {
            BenchmarkRunner.Run<Zad1>();
        }
    }
}
