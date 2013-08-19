using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.Net;

namespace FlashDebugger.Debugger.HxCpp.Server
{
	/// <summary>
	/// Created socket, listens accepts, creates Session object
	/// </summary>
	class Manager
	{
		public event DebuggerProgressEventHandler ProgressEvent;

		private Socket listenSocket;

		public void Listen()
		{
			// need to broadcast some sort of progress evetn
			// ProgressChangedEventArgs  ProgressChangedEventHandler
			listenSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Unspecified);
			EndPoint ep = new IPEndPoint(IPAddress.Any, 6972);
			listenSocket.Bind(ep);
			listenSocket.Listen(1); // just 1 for now
			PluginCore.Managers.TraceManager.AddAsync("Listening", -1);
		}

		public Session Accept()
		{
			int timeout = 30000000;
			int period = 1000000;
			int done = 0;
			while (timeout > done)
			{
				done += period;
				if (ProgressEvent != null) ProgressEvent(this, done, timeout);
				if (listenSocket.Poll(period, SelectMode.SelectRead))
				{
					Socket cli = listenSocket.Accept();
					PluginCore.Managers.TraceManager.AddAsync("Accepted", -1);
					Session sess = new Session(cli);

					return sess;
				}
			}
			throw new ManagerAcceptTimeoutExceptio();
		}

		public void StopListen()
		{
			listenSocket.Close();
		}
	}

	class ManagerAcceptTimeoutExceptio : Exception
	{
	}
}
