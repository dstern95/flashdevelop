using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.IO;

namespace FlashDebugger.Debugger.HxCpp.Server
{
	class Protocol
	{
		private static string ClientIdentification = "Haxe debug client v1.0 coming at you!\n\n";
		private static string ServerIdentification = "Haxe debug server v1.0 ready and willing, sir!\n\n";

		public static void WriteServerIdentification(Socket socket)
		{
			socket.Send(Encoding.ASCII.GetBytes(ServerIdentification));
		}

		public static void ReadClientIdentification(Socket socket)
		{
			byte[] str = new byte[ClientIdentification.Length]; // should make a byte array first! 
			socket.Receive(str, ClientIdentification.Length, SocketFlags.None); // could block!
			if (Encoding.ASCII.GetString(str) != ClientIdentification)
			{
				throw new Exception("Client identification is wrong: " + str);
			}
		}

		public static void WriteCommand(Socket socket, HaxeEnum command)
		{
			HaxeSerializer ser = new HaxeSerializer();
			string buf = ser.Serialize(command);
			writeFrame(socket, Encoding.ASCII.GetBytes(buf));
		}

		public static HaxeEnum ReadMessage(Socket socket)
		{
			byte[] buf = readFrame(socket);
			HaxeDeserializer ser = new HaxeDeserializer();
			return (HaxeEnum)ser.Deserialize(new MemoryStream(buf));
		}

		private static void writeFrame(Socket socket, byte[] data)
		{
			// make a "header"
			string len = string.Format("{0:D8}", data.Length);
			//PluginCore.Managers.TraceManager.AddAsync("writeFrame " + len + ": " + Encoding.ASCII.GetString(data), -1);
			socket.Send(Encoding.ASCII.GetBytes(len));
			socket.Send(data);
		}

		private static byte[] readFrame(Socket socket)
		{
			byte[] lenBuf = new byte[8];
			if (socket.Receive(lenBuf, 8, SocketFlags.None) == 0)
			{
				// remote end closed, TODO
				throw new Exception("EOF");
			}
			int len = Convert.ToInt32(Encoding.ASCII.GetString(lenBuf));
			// Validate the length.  Don't allow messages larger than 100K.
			if (len > (100 * 1024))
			{
				throw new Exception("Read bad message length: " + len + ".");
			}

			byte[] ret = new byte[len];
			socket.Receive(ret, len, SocketFlags.None);
			//PluginCore.Managers.TraceManager.AddAsync("readFrame " + Encoding.ASCII.GetString(lenBuf) +": " +Encoding.ASCII.GetString(ret), -1);
			return ret;
		}


	}
}