using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Controls;

namespace FlashDebugger.Debugger.HxCpp
{
	class HxCppDataNode : DataNode
	{
		public HxCppDataNode(string text)
			: base(text)
		{
		}

		public override string Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = value;
			}
		}

		public override bool EditEnabled
		{
			get
			{
				return base.EditEnabled;
			}
		}

		public override bool IsLeaf
		{
			get
			{
				return base.IsLeaf;
			}
		}

		public override bool HasValueChanged
		{
			get
			{
				return base.HasValueChanged;
			}
		}

		public override string VariablePath
		{
			get
			{
				return base.VariablePath;
			}
		}

		public override void LoadChildren()
		{
			base.LoadChildren();
		}

	}
}
