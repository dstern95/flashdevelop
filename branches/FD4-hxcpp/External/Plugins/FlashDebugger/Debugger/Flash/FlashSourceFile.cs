using System;
using System.Collections.Generic;
using System.Text;
using flash.tools.debugger;
using System.IO;
using ProjectManager.Projects;
using PluginCore;

namespace FlashDebugger.Debugger.Flash
{
	class FlashSourceFile : DbgSourceFile
	{
		private SourceFile sourceFile;
		private static Dictionary<string, string> pathMap = new Dictionary<string, string>();

		public static DbgSourceFile FromSourceFile(SourceFile sourceFile)
		{
			return new FlashSourceFile(sourceFile);
		}

		private FlashSourceFile(SourceFile sourceFile)
		{
			this.sourceFile = sourceFile;
		}

		string DbgSourceFile.LocalPath
		{
			get
			{
				return getLocalPath(sourceFile);
			}
		}

		/// <summary>
		/// 
		/// </summary>
		private static string getLocalPath(SourceFile file)
		{
			if (file == null) return null;
			if (File.Exists(file.getFullPath()))
			{
				return file.getFullPath();
			}
			if (pathMap.ContainsKey(file.getFullPath()))
			{
				return pathMap[file.getFullPath()];
			}
			Char pathSeparator = Path.DirectorySeparatorChar;
			String pathFromPackage = file.getPackageName().ToString().Replace('/', pathSeparator);
			foreach (Folder folder in PluginMain.settingObject.SourcePaths)
			{
				String localPath = folder.Path + pathSeparator + pathFromPackage + pathSeparator + file.getName();
				if (File.Exists(localPath))
				{
					pathMap[file.getFullPath()] = localPath;
					return localPath;
				}
			}
			Project project = PluginBase.CurrentProject as Project;
			if (project != null)
			{
				foreach (string cp in project.Classpaths)
				{
					String localPath = project.Directory + pathSeparator + cp + pathSeparator + pathFromPackage + pathSeparator + file.getName();
					if (File.Exists(localPath))
					{
						pathMap[file.getFullPath()] = localPath;
						return localPath;
					}
				}
			}
			return null;
		}

	}
}
