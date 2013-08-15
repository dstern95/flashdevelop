using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp
{
	class Command : HaxeEnum
	{
		private Command(string constructor):base("debugger.Command", constructor) {}

		public static Command Exit() { return new Command("Exit"); }
		public static Command Detach() { return new Command("Detach"); }
		public static Command Files() { return new Command("Files"); }
		public static Command Classes() { return new Command("Classes"); }
		public static Command Mem() { return new Command("Mem"); }
		// TODO
	}
}
