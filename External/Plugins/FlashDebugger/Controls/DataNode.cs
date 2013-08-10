using System;
using Aga.Controls.Tree;
using flash.tools.debugger;
using PluginCore.Utilities;

namespace FlashDebugger.Controls
{
	public class DataNode : Node, IComparable<DataNode>
    {
        public override string Text
        {
            get
			{
				return base.Text;
			}
        }

		private int m_ChildrenShowLimit = 500;
		public int ChildrenShowLimit
		{
			get { return m_ChildrenShowLimit; }
			set { m_ChildrenShowLimit = value; }
		}

		private bool m_bEditing = false;

		public int CompareTo(DataNode otherNode)
		{
			String thisName = Text;
			String otherName = otherNode.Text;
			if (thisName == otherName)
			{
				return 0;
			}
			if (thisName.Length>0 && thisName[0] == '_')
			{
				thisName = thisName.Substring(1);
			}
			if (otherName.Length>0 && otherName[0] == '_')
			{
				otherName = otherName.Substring(1);
			}
			int result = LogicalComparer.Compare(thisName, otherName);
			if (result != 0)
			{
				return result;
			}
			return Text.StartsWith("_") ? 1 : -1;
		}

        public virtual string Value
        {
            get
            {
                return "";
            }
            set
            {
            }
        }

        protected string escape(string text)
        {
            text = text.Replace("\\", "\\\\");
            text = text.Replace("\"", "\\\"");
            text = text.Replace("\0", "\\0");
            text = text.Replace("\a", "\\a");
            text = text.Replace("\b", "\\b");
            text = text.Replace("\f", "\\f");
            text = text.Replace("\n", "\\n");
            text = text.Replace("\r", "\\r");
            text = text.Replace("\t", "\\t");
            text = text.Replace("\v", "\\v");
            if (text.Length > 65535)
                text = text.Substring(0, 65535 - 5) + "[...]";
            return text;
        }

        public override bool IsLeaf
        {
            get
            {
                return (this.Nodes.Count == 0);
            }
        }

		public bool IsEditing
		{
			get
			{
				return m_bEditing;
			}
			set
			{
				m_bEditing = value;
			}
		}

        public virtual bool EditEnabled
        {
            get
            {
                return false;
            }
        }

        public virtual bool HasValueChanged
        {
            get 
            {
                return false;
            }
        }

        public virtual string VariablePath
        {
            get
            {
                return null;
            }
        }

        public virtual void LoadChildren()
        {
        }

        public DataNode(string value)
            : base(value)
        {
        }

	}

}
