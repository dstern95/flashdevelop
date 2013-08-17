using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Debugger.HxCpp.Server;

namespace FlashDebugger.Debugger.HxCpp
{
	class HxCppInterface : DebuggerInterface
	{
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

		Manager manager;
		Session session;
		bool isSuspended;

		public bool Initialize()
		{
			manager = new Manager();
			return true;
		}

		public void Start()
		{
			manager.Listen();
			session = manager.Accept();
			session.Bind();
			manager.StopListen();

			isSuspended = false;

			if (StartedEvent != null) { StartedEvent(this); };
			// send some events
			// test

			while (true)
			{
				handleEvents();
				if (!session.Connected)
				{
					break;
				}
			}

			if (DisconnectedEvent != null) { DisconnectedEvent(this); }
		}

		private void handleEvents()
		{
			while (session.GetEventCount() > 0)
			{
				Message e = session.GetNextEvent();
				if (e == null)
				{
					// was disconnect
					return;
				}
				if (TraceEvent != null) { TraceEvent(this, e.ToString()); }
				if (e is Message.ThreadStopped)
				{
					//Message.ThreadStopped x;
					// store current location?
					isSuspended = true; // TODO
					if (PauseEvent != null) { PauseEvent(this); }
				}
			}

		}



		public void Continue()
		{
			session.Request(Command.Continue(1));
		}

		public void Detach()
		{
			throw new NotImplementedException();
		}

		public bool IsDebuggerStarted
		{
			get { return session != null && session.Connected; }
		}

		public bool IsDebuggerSuspended
		{
			get { return isSuspended; }
		}

		public void UpdateBreakpoints(List<BreakPointInfo> breakpoints)
		{
			// add new ones
			List<string> fres = MessageUtil.ToList(((Message.Files)session.Request(Command.Files())).list);
			Dictionary<string, string> map = new Dictionary<string, string>(fres.Count);
			foreach (string f in fres)
			{
				String localPath = PluginMain.debugManager.GetLocalPath2(f);
				map.Add(localPath, f);
			}

			foreach (BreakPointInfo bp in breakpoints)
			{
				if (bp.InternalData == null)
				{
					if (bp.IsEnabled && !bp.IsDeleted)
					{
						if (map.ContainsKey(bp.FileFullPath))
						{
							string remo = map[bp.FileFullPath];
							Message res = session.Request(Command.AddFileLineBreakpoint(remo, bp.Line));
							if (res is Message.FileLineBreakpointNumber)
							{
								bp.InternalData = ((Message.FileLineBreakpointNumber)res).number;
							}
						}
					}
				}
				else
				{
					if (bp.IsDeleted || !bp.IsEnabled)
					{
						Message res = session.Request(Command.DeleteBreakpointRange((int)bp.InternalData, (int)bp.InternalData));
						bp.InternalData = null;
					}
				}
			}

			// delete old ones
		}


	}
}
