using System;
using System.Collections;
using System.IO;
using System.Reflection;
using PluginCore.Helpers;
using System.Collections.Generic;

namespace ProjectManager.Projects
{
	public class ProjectPaths
	{
		public static string GetRelativePath(string baseDirectory, string path)
		{
			if (!Path.IsPathRooted(path))
				throw new ArgumentException("The path is already relative.");

			char slash = Path.DirectorySeparatorChar;
			string[] a = baseDirectory.Trim(slash).Split(slash);
			string[] b = path.Trim(slash).Split(slash);

			ArrayList relPath = new ArrayList();
			int i = 0;

			// skip equal parts
			for (i = 0; i < a.Length && i < b.Length; i++)
			{
				if (string.Compare(a[i],b[i],true) != 0)
					break;
			}

			// at this point, i is the index of the first diverging element of the two paths
			int backtracks = a.Length - i;
			for (int j = 0; j < backtracks; j++)
				relPath.Add("..");

			for (int j = i; j < b.Length; j++)
				relPath.Add(b[j]);

			string relativePath = 
				string.Join(slash.ToString(), relPath.ToArray(typeof(string)) as string[]);

			return (relativePath.Length > 0) ? relativePath : "."; // special case
		}

		public static string GetAbsolutePath(string baseDirectory, string path)
		{
            if (Path.IsPathRooted(path)) return path;

			string combinedPath = Path.Combine(baseDirectory, path);
			return Path.GetFullPath(combinedPath);
		}

		public static string ApplicationDirectory
		{
			get
			{
				string url = Assembly.GetEntryAssembly().GetName().CodeBase;
				Uri uri = new Uri(url);
				return Path.GetDirectoryName(uri.LocalPath);
			}
		}

		public static string DefaultProjectsDirectory 
		{
			get { return Environment.GetFolderPath(Environment.SpecialFolder.Personal); }
		}

        public static string ProjectTemplatesDirectory
        {
            get { return PathHelper.ProjectsDir; }
        }

        public static string FileTemplatesDirectory
        {
            get
            {
                string altpath = PluginMain.Settings.AlternateTemplateDir;

                if (altpath != null && altpath.Length > 0)
                    return altpath;
                else
                    return PathHelper.TemplateDir;
            }
        }

        public static List<String> GetAllProjectDirs()
        {
            List<String> allDirs = new List<String>();
            if (Directory.Exists(ProjectTemplatesDirectory))
            {
                allDirs.AddRange(Directory.GetDirectories(ProjectTemplatesDirectory));
            }
            if (Directory.Exists(PathHelper.UserProjectsDir))
            {
                allDirs.AddRange(Directory.GetDirectories(PathHelper.UserProjectsDir));
            }
            return allDirs;
        }
	}
}