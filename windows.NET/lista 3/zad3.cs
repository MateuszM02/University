using System.Text;

namespace lista_3
{
    public class XMLGenerator3
    {
        public string GenerateXML(object dataObject)
        {
            StringBuilder xml = new("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
            xml.Append("<Object>\n");
            
            Type type = dataObject.GetType();
            foreach (var property in type.GetProperties())
            {
                if (Attribute.IsDefined(property, typeof(IgnoreInXMLAttribute)))
                {
                    continue;
                }
                var propertyValue = property.GetValue(dataObject);
                xml.Append($"  <{property.Name}>{propertyValue}</{property.Name}>\n");
            }
            
            xml.Append("</Object>");
            return xml.ToString();
        }
    }

    [AttributeUsage(AttributeTargets.Property)]
    public class IgnoreInXMLAttribute : Attribute
    { }
}
