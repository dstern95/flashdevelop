using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Debugger.HxCpp.Server;

namespace FlashDebugger.Debugger.HxCpp
{
	class HxCppLocation : DbgLocation
	{
		private DbgSourceFile file;
		private int line;

		public static DbgLocation FromFrame(FrameList.Frame frame)
		{
			return new HxCppLocation(HxCppSourceFile.FromFrame(frame), frame.lineNumber);
		}

		private HxCppLocation(DbgSourceFile file, int line)
		{
			this.file = file;
			this.line = line;
		}

		public DbgSourceFile File
		{
			get { return file; }
		}

		public int Line
		{
			get { return line; }
		}
	}
}
