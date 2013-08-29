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
		private bool listening;

		public void Listen()
		{
			try
			{
				listenSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Unspecified);
				EndPoint ep = new IPEndPoint(IPAddress.Any, 6972);
				listenSocket.Bind(ep);
				listenSocket.Listen(1); // just 1 for now
				listening = true;
				log("Listening");
			}
			catch (Exception ex)
			{
				listenSocket.Close();
				listenSocket = null;
			}
		}

		public Session Accept()
		{
			if (listenSocket == null)
			{
				throw new Exception("Not listening");
			}
			int timeout = 30000000;
			int period = 1000000;
			int done = 0;
			while (timeout > done)
			{
				done += period;
				if (ProgressEvent != null) ProgressEvent(this, done, timeout);
				if (!listening)
				{
					// todo, use some other excpetions
					throw new ManagerAcceptTimeoutExceptio();
				}
				if (listenSocket.Poll(period, SelectMode.SelectRead))
				{
					Socket cli = listenSocket.Accept();
					log("Accepted");
					Session sess = new Session(cli);

					return sess;
				}
			}
			throw new ManagerAcceptTimeoutExceptio();
		}

		public void StopListen()
		{
			listenSocket.Close();
			listenSocket = null;
			listening = false;
		}

		public bool Listening
		{
			get { return listening; }
		}

		private static void log(string text)
		{
			if (PluginMain.settingObject.VerboseOutput)
			{
				PluginCore.Managers.TraceManager.AddAsync("Manager: " + text, -1);
			}
		}

	}

	class ManagerAcceptTimeoutExceptio : Exception
	{
	}
}
