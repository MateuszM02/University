using System.Text;

namespace poo4
{
    public class TagBuilder
    {
        public TagBuilder() { }

        public TagBuilder(string TagName, TagBuilder Parent)
        {
            this.tagName = TagName;
            this.parent = Parent;
        }

        private string tagName;
        private TagBuilder parent;
        private StringBuilder body = new StringBuilder();
        private Dictionary<string, string> _attributes = new Dictionary<string, string>();

        public uint Indentation {get; set;}
        public bool IsIndented {get; set;}

        public TagBuilder AddContent(string Content)
        {
            body.Append(Content);
            return this;
        }

        public TagBuilder AddContentFormat(string Format, params object[] args)
        {
            body.AppendFormat(Format, args);
            return this;
        }

        public TagBuilder StartTag(string TagName)
        {
            TagBuilder tag = new TagBuilder(TagName, this);

            return tag;
        }

        public TagBuilder EndTag()
        {
            parent.AddContent(this.ToString());
            return parent;
        }

        public TagBuilder AddAttribute(string Name, string Value)
        {
            _attributes.Add(Name, Value);
            return this;
        }

        public override string ToString()
        {
            StringBuilder tag = new StringBuilder();

            // preamble
            if (!string.IsNullOrEmpty(this.tagName))
                tag.AppendFormat("<{0}", tagName);

            if (_attributes.Count > 0)
            {
                tag.Append(" ");
                tag.Append(
                    string.Join(" ",
                        _attributes
                            .Select(
                                kvp => string.Format("{0}='{1}'", kvp.Key, kvp.Value))
                            .ToArray()));
            }

            // body/ending
            if (body.Length > 0)
            {
                if (!string.IsNullOrEmpty(this.tagName) || this._attributes.Count > 0)
                    tag.Append(">");
                tag.Append(body.ToString());
                if (!string.IsNullOrEmpty(this.tagName))
                    tag.AppendFormat("</{0}>", this.tagName);
            }
            else
                if (!string.IsNullOrEmpty(this.tagName))
                tag.Append("/>");

            return tag.ToString();
        }
    }
}
