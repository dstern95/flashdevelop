using System;
using System.Collections.Generic;
using System.Text;
using flash.tools.debugger;

namespace FlashDebugger.Debugger.Flash
{
	class FlashFrame : DbgFrame
	{
		private Frame frame;
		private DbgLocation location;

		public static DbgFrame FromFrame(Frame frame)
		{
			return new FlashFrame(frame);
		}

		private FlashFrame(Frame frame)
		{
			this.frame = frame;
			location = FlashLocation.FromLocation(frame.getLocation());
		}

		public DbgLocation Location
		{
			get { return location; }
		}

		public string CallSignature
		{
			get { return frame.getCallSignature(); }
		}
	}
}
