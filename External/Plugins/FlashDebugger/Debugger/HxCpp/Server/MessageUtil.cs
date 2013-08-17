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
	}
}
