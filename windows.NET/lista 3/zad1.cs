using System.Text;

namespace lista_3
{
    public interface IClassInfo
    {
        string[] GetFieldNames();
        object GetFieldValue(string fieldName);
    }

    public class XMLGenerator
    {
        public string GenerateXML(IClassInfo dataObject)
        {
            StringBuilder xml = new("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
            xml.Append("<Object>\n");
            
            foreach (var fieldName in dataObject.GetFieldNames())
            {
                var fieldValue = dataObject.GetFieldValue(fieldName);
                xml.Append($"  <{fieldName}>{fieldValue}</{fieldName}>\n");
            }
            
            xml.Append("</Object>");
            return xml.ToString();
        }
    }

    public class Person : IClassInfo
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        [IgnoreInXML]
        public int Age {  get; set; }

        public string[] GetFieldNames()
        {
            return ["Name", "Surname", "Age"];
        }

        public object GetFieldValue(string fieldName)
        {
            return fieldName switch
            {
                "Name" => this.Name,
                "Surname" => this.Surname,
                "Age" => this.Age,
                _ => null!,
            };
            throw new NotImplementedException();
        }
    }
}
