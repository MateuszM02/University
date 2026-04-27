using System.Linq.Expressions;

namespace oop6_4
{
    class Zad4
    {
        private static int Identity(int n)
        {
            return n;
        }

        public static void Main()
        {
            Expression<Func<int, int>> f = n => Identity(4 * (7 + n));
            PrintExpressionVisitor v = new();
            v.Visit(f);
        }
    }

    public class PrintExpressionVisitor : ExpressionVisitor
    {
        protected override Expression VisitBinary(BinaryExpression expression)
        {
            Console.WriteLine("{0} {1} {2}",
            expression.Left, expression.NodeType, expression.Right);
            return base.VisitBinary(expression);
        }
        protected override Expression VisitLambda<T>(Expression<T> expression)
        {
            Console.WriteLine("{0} -> {1}",
            expression.Parameters.Aggregate(string.Empty, (a, e) => a += e),
            expression.Body);
            return base.VisitLambda<T>(expression);
        }

        protected override Expression VisitConstant(ConstantExpression node)
        {
            Console.WriteLine("Constant: {0}", node.Value);
            return base.VisitConstant(node);
        }

        protected override Expression VisitParameter(ParameterExpression node)
        {
            Console.WriteLine("Parameter: {0}", node.Name);
            return base.VisitParameter(node);
        }

        protected override Expression VisitMethodCall(MethodCallExpression node)
        {
            Console.WriteLine("Method Call: {0} on type {1} with arguments:",
                node.Method.Name, node.Method.DeclaringType);
            foreach (var arg in node.Arguments)
            {
                Console.WriteLine("  Argument: {0}", arg);
            }
            return base.VisitMethodCall(node);
        }
    }
}
