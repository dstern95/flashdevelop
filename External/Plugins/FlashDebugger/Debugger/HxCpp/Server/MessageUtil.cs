using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp.Server
{
	class MessageUtil
	{
		static public List<string> ToList(StringList stringList)
		{
			List<string> ret = new List<string>();
			while (stringList is StringList.Element)
			{
				ret.Add(((StringList.Element)stringList).string_);
				stringList = ((StringList.Element)stringList).next;
			}
			return ret;
		}

		static public List<ThreadWhereList.Where> ToList(ThreadWhereList list)
		{
			List<ThreadWhereList.Where> ret = new List<ThreadWhereList.Where>();
			while (list is ThreadWhereList.Where)
			{
				ret.Add((ThreadWhereList.Where)list);
				list = ((ThreadWhereList.Where)list).next;
			}
			return ret;
		}

		static public List<FrameList.Frame> ToList(FrameList list)
		{
			List<FrameList.Frame> ret = new List<FrameList.Frame>();
			while (list is FrameList.Frame)
			{
				ret.Add((FrameList.Frame)list);
				list = ((FrameList.Frame)list).next;
			}
			return ret;
		}

		static public List<VariableName> ToList(VariableNameList list)
		{
			List<VariableName> ret = new List<VariableName>();
			while (list is VariableNameList.Element)
			{
				ret.Add(((VariableNameList.Element)list).variable);
				list = ((VariableNameList.Element)list).next;
			}
			return ret;
		}
	}
}
