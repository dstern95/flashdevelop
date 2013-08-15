using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp
{
	class Message
	{
		protected HaxeEnum hEnum;

		public static Message FromEnum(HaxeEnum hEnum)
		{
			if (hEnum.name != "debugger.Message")
			{
				throw new InvalidCastException("Trying to case HaxeEnum "+hEnum.name+" to debugger.Message");
			}
			if (hEnum.constructor == "ThreadStopped")
			{
				return new Message_ThreadStopped(hEnum);
			}
			throw new InvalidCastException("Trying to case HaxeEnum debugger.Message unknown constructor "+hEnum.constructor);
		}

		public Message(HaxeEnum hEnum)
		{
			this.hEnum = hEnum;
		}

		public override string ToString()
		{
			return hEnum.ToString();
		}
	}

	class Message_ThreadStopped : Message
	{
		public Message_ThreadStopped(HaxeEnum hEnum) : base(hEnum) { }

		public int Number { get { return (int)hEnum.arguments[0]; } }
		public string ClassName { get { return (string)hEnum.arguments[0]; } }
		public string FunctionName { get { return (string)hEnum.arguments[0]; } }
		public string FileName { get { return (string)hEnum.arguments[0]; } }
		public int LineNumber { get { return (int)hEnum.arguments[0]; } }
	}

	// TODO
}
