using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp
{
	public class HaxeSerializer
	{
		private List<string> stringCache = new List<string>();
		private List<object> objectCache = new List<object>();

		public HaxeSerializer()
		{
		}

		public string Serialize(string item)
		{
				int i = stringCache.IndexOf(item);
				if (i != -1)
				{
					return string.Format("R{0}", i);
				}
				else
				{
					stringCache.Add(item);
					string tmp = System.Web.HttpUtility.UrlEncode(item);
					return string.Format("y{0:D}:{1}", tmp.Length, tmp);
				}
		}

		public string Serialize(int item)
		{
			if (item == 0)
			{
				return "z";
			}
			else
			{
				return string.Format("i{0}", item);
			}
		}

		public string Serialize(float item)
		{
			if (float.IsNaN(item))
			{
				return "k";
			}
			else if (float.IsPositiveInfinity(item))
			{
				return "p";
			}
			else if (float.IsNegativeInfinity(item))
			{
				return "m";
			}
			else
			{
				return string.Format("d{0}", item); // todo format?
			}
		}

		public string Serialize(bool item)
		{
			if (item)
			{
				return "t";
			}
			return "f";
		}

		public string Serialize(HaxeList item)
		{
			// todo object cache
			string ret = "l";
			foreach (object o in item)
			{
				ret += Serialize(o);
			}
			return ret + "h";
		}

		public string Serialize(HaxeEnum item)
		{
			// todo object cache
			string ret = "w";
			ret += Serialize(item.name);
			ret += Serialize(item.constructor);
			ret += string.Format(":{0}", item.arguments.Count);
			foreach (object o in item.arguments)
			{
				ret += Serialize(o);
			}
			return ret;
		}

		public string Serialize(object data)
		{
			// todo object cache
			if (data is string)
			{
				return Serialize((string)data);
			}
			else if (data is int)
			{
				return Serialize((int)data);
			}
			else if (data == null)
			{
				return "n";
			}
			// todo double
			else if (data is float)
			{
				return Serialize((float)data);
			}
			else if (data is bool)
			{
				return Serialize((bool)data);
			}
			else if (data is HaxeList)
			{
				return Serialize((HaxeList)data);
			}
			else if (data is HaxeEnum)
			{
				return Serialize((HaxeEnum)data);
			}
			else
			{
				throw new HaxeUnsupportedSerializationException("Unsupported object " + (data != null ? data.GetType().ToString() : "null"));
			}
		}
	}

	public class HaxeUnsupportedSerializationException : Exception
	{
		public HaxeUnsupportedSerializationException(string message) : base(message)
		{}
	}
}
