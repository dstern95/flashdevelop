using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Debugger.HxCpp.Server;

namespace FlashDebugger.Debugger.HxCpp
{
	class HxCppFrame : DbgFrame
	{
		private FrameList.Frame frame;
		private DbgLocation location;

		public static DbgFrame FromFrame(FrameList.Frame frame)
		{
			return new HxCppFrame(frame);
		}

		private HxCppFrame(FrameList.Frame frame)
		{
			this.frame = frame;
			this.location = HxCppLocation.FromFrame(frame);
		}

		public DbgLocation Location
		{
			get { return location; }
		}

		public string CallSignature
		{
			get
			{
				// TODO
				return frame.className + "::" + frame.functionName;
			}
		}
	}
}
