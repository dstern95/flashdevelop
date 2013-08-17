using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp.Server
{
	class Command : HaxeEnum
	{
		private Command(string constructor):base("debugger.Command", constructor) {}

		public static Command Exit() { Command cmd = new Command("Exit"); return cmd; }
		// Response: Exited
		public static Command Detach() { Command cmd = new Command("Detach"); return cmd; }
		// Response: Detached
		public static Command Files() { Command cmd = new Command("Files"); return cmd; }
		// Response: StringList
		public static Command Classes() { Command cmd = new Command("Classes"); return cmd; }
		// Response: StringList
		public static Command Mem() { Command cmd = new Command("Mem"); return cmd; }
		// Response: MemBytes
		public static Command Compact() { Command cmd = new Command("Compact"); return cmd; }
		// Response: Compacted
		public static Command Collect() { Command cmd = new Command("Collect"); return cmd; }
		// Response: Collected
		public static Command SetCurrentThread(int number) { Command cmd = new Command("SetCurrentThread"); cmd.arguments.Add(number); return cmd; }
		// Response: CurrentThread, ErrorNoSuchThread
		public static Command AddFileLineBreakpoint(string fileName, int lineNumber) { Command cmd = new Command("AddFileLineBreakpoint"); cmd.arguments.Add(fileName); cmd.arguments.Add(lineNumber); return cmd; }
		// Response: FileLineBreakpointNumber, ErrorNoSuchFile
		public static Command AddClassFunctionBreakpoint(string className, string functionName) { Command cmd = new Command("AddClassFunctionBreakpoint"); cmd.arguments.Add(className); cmd.arguments.Add(functionName); return cmd; }
		// Response: ClassFunctionBreakpointNumber, ErrorBadClassNameRegex,
		// ErrorBadFunctionNameRegex, ErrorNoMatchingFunctions
		public static Command ListBreakpoints(bool enabled, bool disabled) { Command cmd = new Command("ListBreakpoints"); cmd.arguments.Add(enabled); cmd.arguments.Add(disabled); return cmd; }
		// Response: Breakpoints
		public static Command DescribeBreakpoint(int number) { Command cmd = new Command("DescribeBreakpoint"); cmd.arguments.Add(number); return cmd; }
		// Response: BreakpointDescription, ErrorNoSuchBreakpoint
		public static Command DisableAllBreakpoints() { Command cmd = new Command("DisableAllBreakpoints"); return cmd; }
		// Response: BreakpointStatuses
		public static Command DisableBreakpointRange(int first, int last) { Command cmd = new Command("DisableBreakpointRange"); cmd.arguments.Add(first); cmd.arguments.Add(last); return cmd; }
		// Response: BreakpointStatuses
		public static Command EnableAllBreakpoints() { Command cmd = new Command("EnableAllBreakpoints"); return cmd; }
		// Response: BreakpointStatuses
		public static Command EnableBreakpointRange(int first, int last) { Command cmd = new Command("EnableBreakpointRange"); cmd.arguments.Add(first); cmd.arguments.Add(last); return cmd; }
		// Response: BreakpointStatuses
		public static Command DeleteAllBreakpoints() { Command cmd = new Command("DeleteAllBreakpoints"); return cmd; }
		// Response: BreakpointStatuses
		public static Command DeleteBreakpointRange(int first, int last) { Command cmd = new Command("DeleteBreakpointRange"); cmd.arguments.Add(first); cmd.arguments.Add(last); return cmd; }
		// Response: BreakpointStatuses
		public static Command BreakNow() { Command cmd = new Command("BreakNow"); return cmd; }
		// Response: OK
		public static Command Continue(int count) { Command cmd = new Command("Continue"); cmd.arguments.Add(count); return cmd; }
		// Response: Continued, ErrorBadCount
		public static Command Step(int count) { Command cmd = new Command("Step"); cmd.arguments.Add(count); return cmd; }
		// Response: Continued, ErrorBadCount
		public static Command Next(int count) { Command cmd = new Command("Next"); cmd.arguments.Add(count); return cmd; }
		// Response: Continued, ErrorBadCount
		public static Command Finish(int count) { Command cmd = new Command("Finish"); cmd.arguments.Add(count); return cmd; }
		// Response: Continued, ErrorBadCount
		public static Command WhereCurrentThread(bool unsafe_) { Command cmd = new Command("WhereCurrentThread"); cmd.arguments.Add(unsafe_); return cmd; }
		// Response: ThreadsWhere, ErrorCurrentThreadNotStopped
		public static Command WhereAllThreads() { Command cmd = new Command("WhereAllThreads"); return cmd; }
		// Response: ThreadsWhere
		public static Command Up(int count) { Command cmd = new Command("Up"); cmd.arguments.Add(count); return cmd; }
		// Response: CurrentFrame, ErrorCurrentThreadNotStopped, ErrorBadCount
		public static Command Down(int count) { Command cmd = new Command("Down"); cmd.arguments.Add(count); return cmd; }
		// Response: CurrentFrame, ErrorCurrentThreadNotStopped, ErrorBadCount
		public static Command SetFrame(int number) { Command cmd = new Command("SetFrame"); cmd.arguments.Add(number); return cmd; }
		// Response: CurrentFrame, ErrorCurrentThreadNotStopped, ErrorBadCount
		public static Command Variables(bool unsafe_) { Command cmd = new Command("Variables"); cmd.arguments.Add(unsafe_); return cmd; }
		// Response: ErrorCurrentThreadNotStopped, Variables
		public static Command PrintExpression(bool unsafe_, string expression) { Command cmd = new Command("PrintExpression"); cmd.arguments.Add(unsafe_); cmd.arguments.Add(expression); return cmd; }
		// Response: Value, ErrorCurrentThreadNotStopped, ErrorEvaluatingExpression
		public static Command SetExpression(bool unsafe_, string lhs, string rhs) { Command cmd = new Command("SetExpression"); cmd.arguments.Add(unsafe_); cmd.arguments.Add(lhs); cmd.arguments.Add(rhs); return cmd; }
		// Response: Valuet, ErrorCurrentThreadNotStopped,
		// ErrorEvaluatingExpression
		public static Command CommandId(int id, Command command) { Command cmd = new Command("CommandId"); cmd.arguments.Add(id); cmd.arguments.Add(command); return cmd; }

	}
}
