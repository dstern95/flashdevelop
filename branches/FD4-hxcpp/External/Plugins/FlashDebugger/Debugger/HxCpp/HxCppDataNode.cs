using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Controls;
using FlashDebugger.Debugger.HxCpp.Server;

namespace FlashDebugger.Debugger.HxCpp
{
	class HxCppDataNode : DataNode
	{
		private Session session;
		private VariableValue.Item item;
		private List<VariableName> children;
		private string fullName;

		public HxCppDataNode(string name, string fullName, Session session)
			: base(name)
		{
			this.session = session;
			this.fullName = fullName;
			try
			{
				Message ret = session.Request(Command.GetExpression(false, fullName));
				if (ret is Message.Variable)
				{
					Message.Variable var_ = (Message.Variable)ret;
					VariableName.Variable varname = (VariableName.Variable)var_.variable;
					item = (VariableValue.Item)varname.value;
					children = MessageUtil.ToList(item.children);
					Value = item.value;
				}
				else
				{
					Value = "ERR: " + ret.ToString();
				}
			}
			catch (Exception ex)
			{
				Value = ex.ToString();
			}
		}

		public override string Value
		{
			get
			{
				// show type? do we add another column? do we get hx backend to tell us when? list all known types?
				return base.Value;
			}
			set
			{
				// todo
				base.Value = value;
			}
		}

		public override bool EditEnabled
		{
			get
			{
				// todo
				return base.EditEnabled;
			}
		}

		public override bool IsLeaf
		{
			get
			{
				return children == null || children.Count == 0;
			}
		}

		public override bool HasValueChanged
		{
			get
			{
				// todo
				return base.HasValueChanged;
			}
		}

		public override string VariablePath
		{
			get
			{
				return fullName;
			}
		}

		public override void LoadChildren()
		{
			// todo
			Nodes.Clear();
            //DataNode inheritedNode = new DataNode("[inherited]");
            //List<DataNode> nodes = new List<DataNode>();
			//Nodes.Add(
			if (children == null) return;
			List<DataNode> nodes = new List<DataNode>(children.Count);
			foreach (VariableName child in children)
			{
				if (child is VariableName.Variable)
				{
					VariableName.Variable varchild = (VariableName.Variable)child;
					nodes.Add(new HxCppDataNode(varchild.name, varchild.fullName, session));
				}
			}
			nodes.Sort();
			foreach (DataNode item in nodes)
			{
				Nodes.Add(item);
			}
		}

	}
}
