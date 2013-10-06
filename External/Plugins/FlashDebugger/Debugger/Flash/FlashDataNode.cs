using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Controls;
using flash.tools.debugger;
using flash.tools.debugger.expression;

namespace FlashDebugger.Debugger.Flash
{
    public class FlashDataNode : DataNode
    {
        private Variable m_Value;
		private Session m_Session;

        public override string Value
        {
            get
            {
                if (m_Value == null)
                {
                    return string.Empty;
                }
                int type = m_Value.getValue().getType();
                string temp = null;
                if (type == VariableType_.MOVIECLIP || type == VariableType_.OBJECT)
                {
                    return m_Value.getValue().getTypeName().replaceAll("::", ".").replaceAll("@", " (@") + ")";
                }
                else if (type == VariableType_.NUMBER)
                {
                    double number = ((java.lang.Double)m_Value.getValue().getValueAsObject()).doubleValue();
                    if (!Double.IsNaN(number) && (double)(long)number == number)
                    {
                        if (!IsEditing)
                        {
                            if (number < 0 && number >= Int32.MinValue)
                            {
                                return number.ToString() + " [0x" + ((Int32)number).ToString("x") + "]";
                            }
                            else if (number < 0 || number > 9)
                            {
                                return number.ToString() + " [0x" + ((Int64)number).ToString("x") + "]";
                            }
                        }
                        else return number.ToString();
                    }
                }
                else if (type == VariableType_.BOOLEAN)
                {
                    return m_Value.getValue().getValueAsString().toLowerCase();
                }
                else if (type == VariableType_.STRING)
                {
                    if (m_Value.getValue().getValueAsObject() != null)
                    {
                        if (!IsEditing)
                        {
                            temp = "\"" + escape(m_Value.ToString()) + "\"";
                        }
                        else
                        {
                            temp = m_Value.ToString();
                        }
                        return temp;
                    }
                }
                else if (type == VariableType_.NULL)
                {
                    return "null";
                }
                else if (type == VariableType_.FUNCTION)
                {
                    m_Value.ToString();
                    //return "<setter>";
                }
                if (temp == null) temp = m_Value.ToString();
                if (!IsEditing)
                {
                    temp = escape(temp);
                }
                return temp;
            }
            set
            {
                if (m_Value == null)
                {
                    return;
                }
                throw new NotImplementedException();
#if false
				int type = m_Value.getValue().getType();
				if (type == VariableType_.NUMBER)
				{
					m_Value.setValue(type, value);
				}
				else if (type == VariableType.BOOLEAN)
				{
					m_Value.setValue(type, value.ToLower());
				}
				else if (type == VariableType.STRING)
				{
					m_Value.setValue(type, value);
				}
#endif
            }
        }



        public Variable Variable
        {
            get
            {
                return m_Value;
            }
        }

        public override bool EditEnabled
        {
            get
            {
                int type = Variable.getValue().getType();
                if (type != VariableType_.BOOLEAN && type != VariableType_.NUMBER && type != VariableType_.STRING)
                {
                    return false;
                }
                return true;
            }
        }

        public override bool IsLeaf
        {
            get
            {
                if (m_Value == null)
                {
                    return (this.Nodes.Count == 0);
                }
                return m_Value.getValue().getType() != VariableType_.MOVIECLIP && m_Value.getValue().getType() != VariableType_.OBJECT;
            }
        }

        public override bool HasValueChanged
        {
            get
            {
                try
                {
                    if (Variable != null && Variable.hasValueChanged(m_Session))
                    {
                        return true;
                    }
                }
                catch (NullReferenceException) { }
                return false;
            }
        }

        private string m_VariablePath;

        public override string VariablePath
        {
            get
            {
                return m_VariablePath;
            }
        }

        public override void LoadChildren()
        {
            Nodes.Clear();
            List<DataNode> nodes = new List<DataNode>();
            List<DataNode> inherited = new List<DataNode>();
            List<DataNode> statics = new List<DataNode>();
            int tmpLimit = ChildrenShowLimit;
            foreach (Variable member in Variable.getValue().getMembers(m_Session))
            {
                DataNode memberNode = new FlashDataNode(member, VariablePath + "." + member.getName(), m_Session);

                if (member.isAttributeSet(VariableAttribute_.IS_STATIC))
                {
                    statics.Add(memberNode);
                }
                else if (member.getLevel() > 0)
                {
                    inherited.Add(memberNode);
                }
                else
                {
                    nodes.Add(memberNode);
                }
            }
            if (inherited.Count > 0)
            {
                DataNode inheritedNode = new DataNode("[inherited]");
                inherited.Sort();
                foreach (DataNode item in inherited)
                {
                    inheritedNode.Nodes.Add(item);
                }
                Nodes.Add(inheritedNode);
            }
            if (statics.Count > 0)
            {
                DataNode staticNode = new DataNode("[static]");
                statics.Sort();
                foreach (DataNode item in statics)
                {
                    staticNode.Nodes.Add(item);
                }
                Nodes.Add(staticNode);
            }
            //test children
            foreach (String ch in Variable.getValue().getClassHierarchy(false))
            {
                if (ch.Equals("flash.display::DisplayObjectContainer"))
                {
                    double numChildren = ((java.lang.Double)Variable.getValue().getMemberNamed(m_Session, "numChildren").getValue().getValueAsObject()).doubleValue();
                    DataNode childrenNode = new DataNode("[children]");
                    for (int i = 0; i < numChildren; i++)
                    {
                        try
                        {
                            IASTBuilder b = new ASTBuilder(false);
                            string cmd = VariablePath + ".getChildAt(" + i + ")";
                            ValueExp exp = b.parse(new java.io.StringReader(cmd));
                            var ctx = new ExpressionContext(m_Session, m_Session.getFrames()[PluginMain.debugManager.CurrentFrame]);
                            var obj = exp.evaluate(ctx);
                            if (obj is flash.tools.debugger.concrete.DValue) obj = new flash.tools.debugger.concrete.DVariable("getChildAt(" + i + ")", (flash.tools.debugger.concrete.DValue)obj);
                            DataNode childNode = new FlashDataNode((Variable)obj, cmd, m_Session);
                            childNode.Text = "child_" + i;
                            childrenNode.Nodes.Add(childNode);
                        }
                        catch (Exception) { }
                    }
                    Nodes.Add(childrenNode);
                }
                else if (ch.Equals("flash.events::EventDispatcher"))
                {
                    Variable list = Variable.getValue().getMemberNamed(m_Session, "listeners");
                    var omg = list.getName();
                    /*
                    double numChildren = ((java.lang.Double)node.Variable.getValue().getMemberNamed(m_Session, "numChildren").getValue().getValueAsObject()).doubleValue();
                    DataNode childrenNode = new DataNode("[children]");
                    for (int i = 0; i < numChildren; i++)
                    {
                        try
                        {

                            IASTBuilder b = new ASTBuilder(false);
                            string cmd = GetVariablePath(node) + ".getChildAt(" + i + ")";
                            ValueExp exp = b.parse(new java.io.StringReader(cmd));
                            var ctx = new ExpressionContext(m_Session, m_Session.getFrames()[PluginMain.debugManager.CurrentFrame]);
                            var obj = exp.evaluate(ctx);
                            if (obj is flash.tools.debugger.concrete.DValue) obj = new flash.tools.debugger.concrete.DVariable("child_" + i, (flash.tools.debugger.concrete.DValue)obj);
                            DataNode childNode = new DataNode((Variable)obj);
                            childrenNode.Nodes.Add(childNode);
                        }
                        catch (Exception) { }
                    }
                    node.Nodes.Add(childrenNode);
                     * */
                }
            }
            //test children
            nodes.Sort();
            foreach (DataNode item in nodes)
            {
                if (0 == tmpLimit--) break;
                Nodes.Add(item);
            }
            if (tmpLimit == -1)
            {
                DataNode moreNode = new ContinuedDataNode();
                Nodes.Add(moreNode);
            }
        }

        public FlashDataNode(Variable value, Session session)
            : this(value, value.getName(), session)
        {
        }

        public FlashDataNode(Variable value, string variablePath, Session session)
            : base(value.getName())
        {
            m_Value = value;
            m_VariablePath = variablePath;
			m_Session = session;
		}
    }
}
