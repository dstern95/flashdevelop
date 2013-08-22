using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger
{
	public interface DbgLocation
	{
		DbgSourceFile File { get; }
		int Line { get; }
	}
}
