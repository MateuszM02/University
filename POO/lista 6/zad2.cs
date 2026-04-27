namespace oop6
{
    public enum UnaryOperator { NEGATE }
    public enum BinaryOperator { AND, OR }

    public class Context
    {
        private Dictionary<string, bool> variables = [];

        public bool GetValue(string VariableName)
        {
            bool exists = variables.TryGetValue(VariableName, out bool value);
            if (exists)
                return value;
            throw new ArgumentException("No such variable");
        }

        public bool SetValue(string VariableName, bool Value) 
        {
            variables.Remove(VariableName);
            variables.Add(VariableName, Value);
            return true;
        }
    }

    public abstract class AbstractExpression
    {
        public abstract bool Interpret(Context context);
    }

    public class ConstExpression : AbstractExpression
    {
        private string _expr;

        public ConstExpression(string expr)
        {
            _expr = expr;
        }

        public override bool Interpret(Context context)
        {
            return context.GetValue(_expr);
        }
    }
    public class BinaryExpression : AbstractExpression
    {
        private AbstractExpression _left;
        private AbstractExpression _right;
        private BinaryOperator _op;

        public BinaryExpression(BinaryOperator op, 
                                AbstractExpression left,
                                AbstractExpression right)
        {
            _left = left;
            _right = right;
            _op = op;
        }

        public override bool Interpret(Context context)
        {
            return _op switch
            {
                BinaryOperator.AND => _left.Interpret(context) &&
                                            _right.Interpret(context),
                BinaryOperator.OR => _left.Interpret(context) ||
                                            _right.Interpret(context),
                _ => throw new ArgumentException("Bad operator"),
            };
        }
    }
    public class UnaryExpression : AbstractExpression
    {
        private AbstractExpression _expr;
        private UnaryOperator _op;

        public UnaryExpression(UnaryOperator op,
                                AbstractExpression expr)
        {
            _expr = expr;
            _op = op;
        }
        public override bool Interpret(Context context)
        {
            return _op switch
            {
                UnaryOperator.NEGATE => !_expr.Interpret(context),
                _ => throw new ArgumentException("Bad operator"),
            };
        }
    }

    class Zad2
    {
        public static void Main()
        {
            // klient
            Context ctx = new();
            ctx.SetValue("x", false);
            ctx.SetValue("y", true);
            AbstractExpression exp = new BinaryExpression(
                BinaryOperator.AND,
                new ConstExpression("x"),
                new UnaryExpression(
                    UnaryOperator.NEGATE, 
                    new ConstExpression("y")
                )); // jakieś wyrażenie logiczne ze stałymi i zmiennymi
            bool Value = exp.Interpret(ctx);
            Console.WriteLine(Value);
        }
    }

}
