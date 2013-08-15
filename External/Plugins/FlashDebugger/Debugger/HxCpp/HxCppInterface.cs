using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp
{
	class HxCppInterface : DebuggerInterface
	{
		#region DebuggerInterface Members

		public event TraceEventHandler TraceEvent;

		public event DebuggerEventHandler DisconnectedEvent;

		public event DebuggerEventHandler PauseFailedEvent;

		public event DebuggerEventHandler StartedEvent;

		public event DebuggerEventHandler BreakpointEvent;

		public event DebuggerEventHandler FaultEvent;

		public event DebuggerEventHandler PauseEvent;

		public event DebuggerEventHandler StepEvent;

		public event DebuggerEventHandler ScriptLoadedEvent;

		public event DebuggerEventHandler WatchpointEvent;

		public event DebuggerEventHandler UnknownHaltEvent;

		public event DebuggerProgressEventHandler ProgressEvent;

		public bool Initialize()
		{
			//throw new NotImplementedException();
			return true;
		}

		public void Start()
		{
			Manager manager = new Manager();
			manager.Listen();
			Session sess = manager.Accept();
			sess.Bind();
			// send some events
			// test
		}

		#endregion
	}
}
