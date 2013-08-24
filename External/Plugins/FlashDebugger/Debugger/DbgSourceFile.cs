using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger
{
	/// <summary>
	/// Describes source file from VM
	/// </summary>
	public interface DbgSourceFile
	{
		string FullPath { get; }
		string LocalPath { get; }
	}
}
