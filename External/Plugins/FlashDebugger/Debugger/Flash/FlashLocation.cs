using System;
using System.Collections.Generic;
using System.Text;
using flash.tools.debugger;

namespace FlashDebugger.Debugger.Flash
{
	class FlashLocation : DbgLocation
	{
		private Location location;
		private DbgSourceFile dbgSourceFile;

		public static DbgLocation FromLocation(Location location)
		{
			return new FlashLocation(location);
		}

		private FlashLocation(Location location)
		{
			this.location = location;
			if (location != null)
			{
				dbgSourceFile = FlashSourceFile.FromSourceFile(location.getFile());
			}
		}

		public DbgSourceFile File
		{
			get { return dbgSourceFile; }
		}

		public int Line
		{
			get { return location.getLine(); }
		}
	}
}
