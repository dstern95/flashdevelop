using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.ComponentModel;
using System.Threading;

namespace FlashDebugger.Debugger.HxCpp.Server
{
	/// <summary>
	/// Created from accepted Socket, 
	/// </summary>
	class Session
	{
		private Socket socket;
		private BackgroundWorker readWorker;
		private Dictionary<int, Message> responseQ;
		private Queue<Message> eventQ;
		private AutoResetEvent responseWaitHandle = new AutoResetEvent(false);
		int nextCmdId = 1;

		public Session(Socket socket)
		{
			this.socket = socket;
			responseQ = new Dictionary<int, Message>();
			eventQ = new Queue<Message>();
		}

		public void Bind()
		{
			try
			{
				socket.ReceiveTimeout = 5000;
				socket.SendBufferSize = 5000;
				log("Sending ServerID");
				Protocol.WriteServerIdentification(socket);
				log("Reading ClientID");
				Protocol.ReadClientIdentification(socket);
				log("Read ClientID");
				readWorker = new BackgroundWorker();
				readWorker.DoWork += new DoWorkEventHandler(readWorker_DoWork);
				readWorker.RunWorkerAsync();

				// TEST
				// do files change? can we just load them once?
				//Protocol.WriteCommand(socket, Command.Files());
			}
			catch (Exception e)
			{
				log("Bind e " + e.ToString());
			}
		}

		public void Unbind()
		{
			log("Unbind");
			socket.Close();
		}


		public Message Request(Command cmd)
		{
			int cmdId = Interlocked.Increment(ref nextCmdId);
			
			// write timeout?
			log("out " + cmdId + ": " + cmd.ToString());
			Protocol.WriteCommand(socket, Command.CommandId(cmdId, cmd));

			int timeout = 5000;
			bool pass2 = false;
			while (true)
			{
				lock (responseQ)
				{
					if (responseQ.ContainsKey(cmdId))
					{
						Message res = responseQ[cmdId];
						responseQ.Remove(cmdId);
						responseWaitHandle.Reset();
						return res;
					}
				}
				if (pass2)
				{
					break;
				}
				responseWaitHandle.WaitOne(timeout);
				pass2 = true;
			}
			throw new Exception("No reponse in time");
		}

		public int GetEventCount()
		{
			lock (eventQ)
			{
				return eventQ.Count; // what about null?
			}
		}

		public Message GetNextEvent()
		{
			lock (eventQ)
			{
				return eventQ.Dequeue();
			}
		}

		public bool Connected
		{
			get { return socket.Connected; }
		}


		void readWorker_DoWork(object sender, DoWorkEventArgs e)
		{
			log("DoWork");
			socket.ReceiveTimeout = 0;

			while (socket.Connected)
			{
				try
				{
					socket.Poll(-1, SelectMode.SelectRead);
					if (!socket.Connected)
					{
						// disconnected
						lock (eventQ)
						{
							eventQ.Enqueue(null);
						}
						break;
					}
					HaxeEnum henum = Protocol.ReadMessage(socket);
					Message msg = Message.FromEnum(henum);
					// transalte HaxeEnum into a sane structure! get message id from it!
					if (msg is Message.MessageId)
					{
						lock (responseQ)
						{
							Message.MessageId msg_id = (Message.MessageId)msg;
							log("msg " + msg_id.id + ": " + msg_id.message.ToString());
							responseQ.Add(msg_id.id, msg_id.message);
							responseWaitHandle.Set();
						}
					}
					else
					{
						lock (eventQ)
						{
							log("evt " + msg.ToString());
							eventQ.Enqueue(msg);
						}
					}
				}
				catch (Exception exc)
				{
					// stop?
					log("DoWork exception " + exc.ToString());
					lock (eventQ)
					{
						// singnal end
						eventQ.Enqueue(null);
					}
					return;
				}
			}
			log("DoWork end");
		}


		private static void log(string text)
		{
			if (PluginMain.settingObject.VerboseOutput)
			{
				PluginCore.Managers.TraceManager.AddAsync("Session: " + text, -1);
			}
		}
	}
}
