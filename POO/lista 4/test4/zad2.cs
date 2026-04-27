using System;
using System.Collections.Generic;
using System.Linq;

namespace oop4
{
    /// <summary>
    /// interfejs do tworzenia figur
    /// </summary>
    public interface IShape
    {
        double GetArea();
    }

    /// <summary>
    /// interfejs fabryki tworzącej figury
    /// </summary>
    public interface IShapeFactoryWorker
    {
        bool CorrectParameters(string parameter);
        IShape Create(params object[] parameter);
    }

    // 1. Kwadrat ---------------------------------------------------------------------------------

    public class Square : IShape
    {
        private double edgeSize;

        public Square(double edgeSize) => this.edgeSize = edgeSize;

        public static string Name => "square";

        public double GetArea()
        {
            return edgeSize * edgeSize;
        }
    }

    public class SquareWorker : IShapeFactoryWorker
    {
        public bool CorrectParameters(string parameter)
        {
            return parameter.ToLower().Equals(Square.Name);
        }

        public IShape Create(params object[] parameters)
        {
            if (parameters.Length != 1)
                throw new ArgumentException("Square must have exactly 1 number parameter");

            bool success = double.TryParse(parameters[0].ToString(), out double edgeSize);
            if (success)
                return new Square(edgeSize);
            throw new ArgumentException("Incorrect square parameter - must be a number");
        }
    }

    // 2. Trójkąt ---------------------------------------------------------------------------------

    public class Triangle : IShape
    {
        private double a;
        private double b;
        private double c;

        public static string Name => "triangle";

        public Triangle(double a, double b, double c) 
        { 
            this.a = a;
            this.b = b;
            this.c = c; 
        }

        public double GetArea()
        {
            double p = (a + b + c) / 3;
            return Math.Sqrt(p * (p - a) * (p - b) * (p - c));
        }
    }

    public class TriangleWorker : IShapeFactoryWorker
    {
        public bool CorrectParameters(string parameter)
        {
            return parameter.ToLower().Equals(Triangle.Name);
        }

        public IShape Create(params object[] parameters)
        {
            if (parameters.Length != 3)
                throw new ArgumentException("Triangle must have exactly 3 number parameters");

            bool success1 = double.TryParse(parameters[0].ToString(), out double a);
            bool success2 = double.TryParse(parameters[1].ToString(), out double b);
            bool success3 = double.TryParse(parameters[2].ToString(), out double c);
            if (success1 && success2 && success3)
                return new Triangle(a, b, c);
            throw new ArgumentException("Incorrect triangle parameters - must be 3 numbers");
        }
    }

    // tu dodaj inne kształty i ich fabryki, np. Rectangle, RectangleFactory

    // 3. Fabryka tworząca wszystkie kształty -----------------------------------------------------

    public class ShapeFactory
    {
        List<IShapeFactoryWorker> workers = new List<IShapeFactoryWorker>();

        public void RegisterWorker(IShapeFactoryWorker worker)
        {
            workers.Add(worker);
        }

        public IShape CreateShape(string shapeName, params object[] parameters)
        {
            IShapeFactoryWorker worker = workers.FirstOrDefault(w => w.CorrectParameters(shapeName));
            if (worker != null)
            {
                return worker.Create(parameters);
            }
            else if (shapeName.ToLower().Equals(Square.Name))
            {
                SquareWorker newWorker = new SquareWorker();
                workers.Add(newWorker);
                return newWorker.Create(parameters);
            }
            else if (shapeName.ToLower().Equals(Triangle.Name))
            {
                TriangleWorker newWorker = new TriangleWorker();
                workers.Add(newWorker);
                return newWorker.Create(parameters);
            }
            // tu dodaj else if dla innych kształtów, np. prostokąt albo koło
            throw new ArgumentException($"Don't know how to create given shape: {shapeName}");
        }
    }
}