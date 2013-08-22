using System;
using System.Collections.Generic;
using System.Text;
using FlashDebugger.Debugger.HxCpp.Server;
using PluginCore.Managers;
using System.Net.Sockets;

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
			manager.ProgressEvent += new DebuggerProgressEventHandler(manager_ProgressEvent);
			return true;
		}

		public void Start()
		{
			try
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

					// sleep for a bit, then process our events.
					try
					{
						System.Threading.Thread.Sleep(25);
					}
					catch { }
				}
			}
			catch (ManagerAcceptTimeoutExceptio mate)
			{
				TraceManager.AddAsync("[No debugger connection request]", -1);
			}
			catch (SocketException se)
			{
				// if we requested stop, it's ok, otherwise ...
				if (session != null) throw se;
			}
			finally
			{
				if (DisconnectedEvent != null) { DisconnectedEvent(this); }
				if (manager.Listening)
				{
					manager.StopListen();
				}
				if (session != null && session.Connected)
				{
					session.Unbind();
				}
				session = null;
			}
		}

		void manager_ProgressEvent(object sender, int current, int total)
		{
			if (ProgressEvent != null) ProgressEvent(this, current, total);
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
			session.Request(Command.Detach());
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
				String localPath = HxCppSourceFile.FromString(f).LocalPath;
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
		}

		public void Next()
		{
			session.Request(Command.Next(1));
		}

		public void Step()
		{
			session.Request(Command.Step(1));
		}

		public void Pause()
		{
			session.Request(Command.BreakNow());
		}

		public void Stop()
		{
			if (manager.Listening)
			{
				manager.StopListen();
			}
			else
			{
				session.Request(Command.Exit());
			}
		}

		public DbgLocation CurrentLocation
		{
			get
			{
				try
				{
					// todo, cache this
					Message.ThreadsWhere msg = (Message.ThreadsWhere)session.Request(Command.WhereCurrentThread(false));
					List<ThreadWhereList.Where> tl = MessageUtil.ToList(msg.list);
					List<FrameList.Frame> fl = MessageUtil.ToList(tl[0].frameList);
					return HxCppLocation.FromFrame(fl[0]);
				}
				catch (Exception ex)
				{
					return null;
				}
			}
		}
	}
}
