using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger
{
	public interface DbgFrame
	{
		DbgLocation Location { get; }
		string CallSignature { get; }
	}
}
