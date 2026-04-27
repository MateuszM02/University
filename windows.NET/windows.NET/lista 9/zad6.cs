using System.Reflection;

namespace net9
{
    public class Zad6
    {
        public static void Main()
        {
            ResourceExtractor.ExtractResourceToFile("net9.clock.bmp", "clock.bmp");
        }
    }

    public class ResourceExtractor
    {
        public static Stream GetResourceStream(string resourceName)
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            Stream? resourceStream = assembly.GetManifestResourceStream(resourceName);
            return resourceStream ?? throw new InvalidOperationException("Resource not found.");
        }

        public static void ExtractResourceToFile(string resourceName, string outputPath)
        {
            using Stream resourceStream = GetResourceStream(resourceName);
            using FileStream fileStream = new(outputPath, FileMode.Create, FileAccess.Write);
            resourceStream.CopyTo(fileStream);
        }
    }
}
