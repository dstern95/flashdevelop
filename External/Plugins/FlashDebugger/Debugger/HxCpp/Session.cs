using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.ComponentModel;

namespace FlashDebugger.Debugger.HxCpp
{
	/// <summary>
	/// Created from accepted Socket, 
	/// </summary>
	class Session
	{
		private Socket socket;
		private BackgroundWorker readWorker;
		private Queue<Message> messageQ;

		public Session(Socket socket)
		{
			this.socket = socket;
			messageQ = new Queue<Message>();
		}

		public void Bind()
		{
			try
			{
				socket.ReceiveTimeout = 5000;
				PluginCore.Managers.TraceManager.AddAsync("Sending ServerID", -1);
				Protocol.WriteServerIdentification(socket);
				PluginCore.Managers.TraceManager.AddAsync("Reading ClientID", -1);
				Protocol.ReadClientIdentification(socket);
				PluginCore.Managers.TraceManager.AddAsync("Read ClientID", -1);
				readWorker = new BackgroundWorker();
				readWorker.DoWork += new DoWorkEventHandler(readWorker_DoWork);
				readWorker.RunWorkerAsync();

				// TEST
				HaxeEnum tmp = new HaxeEnum("debugger.Command", "Files");
				Protocol.WriteCommand(socket, tmp);
			}
			catch (Exception e)
			{
				PluginCore.Managers.TraceManager.AddAsync("Bind e "+e.ToString(), -1);
			}
		}

		public void Unbind()
		{
			PluginCore.Managers.TraceManager.AddAsync("Unbind", -1);
			socket.Close();
		}

		void readWorker_DoWork(object sender, DoWorkEventArgs e)
		{
			PluginCore.Managers.TraceManager.AddAsync("DoWork", -1);
			socket.ReceiveTimeout = 0;

			while (socket.Connected)
			{
				try
				{
					HaxeEnum henum = Protocol.ReadMessage(socket);
					Message msg = Message.FromEnum(henum);
					PluginCore.Managers.TraceManager.AddAsync("msg "+msg.ToString(), -1);
					// transalte HaxeEnum into a sane structure! get message id from it!
					lock (messageQ)
					{
						messageQ.Enqueue(msg);
					}
				}
				catch (Exception exc)
				{
					// stop?
					PluginCore.Managers.TraceManager.AddAsync("DoWork exception "+exc.ToString(), -1);
					return;
				}
			}
			PluginCore.Managers.TraceManager.AddAsync("DoWork end", -1);
		}
	}
}
