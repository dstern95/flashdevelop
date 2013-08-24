using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger
{
    public delegate void TraceEventHandler(object sender, string trace);
    //public delegate void SwfLoadedEventHandler(object sender, SwfLoadedEvent e);
    //public delegate void SwfUnloadedEventHandler(object sender, SwfUnloadedEvent e);
    public delegate void DebuggerEventHandler(object sender);
    public delegate void DebuggerProgressEventHandler(object sender, int current, int total);

    public interface DebuggerInterface
    {
        event TraceEventHandler TraceEvent;
        event DebuggerEventHandler DisconnectedEvent;
        event DebuggerEventHandler PauseFailedEvent;
        event DebuggerEventHandler StartedEvent;
        event DebuggerEventHandler BreakpointEvent;
        event DebuggerEventHandler FaultEvent;
        event DebuggerEventHandler PauseEvent;
        event DebuggerEventHandler StepEvent;
        event DebuggerEventHandler ScriptLoadedEvent;
        event DebuggerEventHandler WatchpointEvent;
        event DebuggerEventHandler UnknownHaltEvent;
        event DebuggerProgressEventHandler ProgressEvent;

        bool Initialize();
		void Start();

		/// <summary>
		/// Step Over
		/// </summary>
		void Next();
		/// <summary>
		/// Step Intp
		/// </summary>
		void Step();
		void Pause();
		void Continue();
		void Detach();
		void Stop();

		bool IsDebuggerStarted { get; }
		bool IsDebuggerSuspended { get; }

		void UpdateBreakpoints(List<BreakPointInfo> breakpoints);

		DbgLocation GetCurrentLocation();

		DbgFrame[] GetFrames();

    }
}
