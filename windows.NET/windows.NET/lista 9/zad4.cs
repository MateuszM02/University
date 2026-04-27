using System.Globalization;
using System.Text;

namespace net9
{
    public abstract class CultureWriter
    {
        protected void CreateInfo(string cultureInfoAsString)
        {
            CultureInfo cultureInfo = new(cultureInfoAsString);
            StringBuilder sb = new();
            DateTimeFormatInfo dtFormat = cultureInfo.DateTimeFormat;
            DateTime today;
            DayOfWeek dayOfWeek = DayOfWeek.Monday;

            // write full names of months
            for (int month = 1; month <= 12; month++)
            {
                sb.AppendLine(dtFormat.GetMonthName(month));
            }
            sb.AppendLine();

            // write abbreviated names of months
            for (int month = 1; month <= 12; month++)
            {
                sb.AppendLine(dtFormat.GetAbbreviatedMonthName(month));
            }
            sb.AppendLine();

            // write full names of days
            for (int i = 1; i <= 7; i++)
            {
                sb.AppendLine(dtFormat.GetDayName(dayOfWeek));
                dayOfWeek = (DayOfWeek)(((int)dayOfWeek + 1) % 7);
            }
            sb.AppendLine();

            // write abbreviated names of days
            for (int i = 1; i <= 7; i++)
            {
                sb.AppendLine(dtFormat.GetAbbreviatedDayName(dayOfWeek));
                dayOfWeek = (DayOfWeek)(((int)dayOfWeek + 1) % 7);
            }
            sb.AppendLine();

            // write today's date in the long format
            today = DateTime.Now;
            sb.AppendLine(today.ToString("D", cultureInfo));
            sb.AppendLine();

            Write(sb.ToString());
        }

        public abstract void Write();
        protected abstract void Write(string info);
    }

    public class EnglishWriter : CultureWriter
    {
        public override void Write() 
        {
            base.CreateInfo("en");
        }

        protected override void Write(string info)
        {
            Console.Write(info);
        }
    }

    public class GermanWriter : CultureWriter
    {
        public override void Write()
        {
            base.CreateInfo("de");
        }

        protected override void Write(string info)
        {
            Console.Write(info);
        }
    }

    public class FrenchWriter : CultureWriter
    {
        public override void Write()
        {
            base.CreateInfo("fr");
        }

        protected override void Write(string info)
        {
            Console.Write(info);
        }
    }

    public class RussianWriter : CultureWriter
    {
        public override void Write()
        {
            base.CreateInfo("ru");
        }

        protected override void Write(string info)
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.Write(info);
        }
    }

    public class ArabWriter : CultureWriter
    {
        public override void Write()
        {
            base.CreateInfo("ar");
        }

        protected override void Write(string info)
        {
            MessageBox.Show(info, "Info in Arabic");
        }
    }

    public class CzechWriter : CultureWriter
    {
        public override void Write()
        {
            base.CreateInfo("cs");
        }

        protected override void Write(string info)
        {
            Console.Write(info);
        }
    }

    public class PolishWriter : CultureWriter
    {
        public override void Write()
        {
            base.CreateInfo("pl");
        }

        protected override void Write(string info)
        {
            Console.Write(info);
        }
    }

    internal class Zad4
    {
        public static void Main()
        {
            new EnglishWriter().Write();
            new GermanWriter().Write();
            new FrenchWriter().Write();
            new RussianWriter().Write();
            new ArabWriter().Write();
            new CzechWriter().Write();
            new PolishWriter().Write();
        }
    }
}
