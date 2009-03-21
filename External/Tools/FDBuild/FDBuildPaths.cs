using System.IO;
using ProjectManager.Projects;
using System.Collections.Generic;
using PluginCore.Helpers;

namespace FDBuild
{
    static class FDBuildPaths
    {
        public static string FDBuildDir
        {
            get { return ProjectPaths.ApplicationDirectory; }
        }

        public static string ToolsDir
        {
            get { return Path.GetDirectoryName(FDBuildDir); }
        }

        public static string FDDir
        {
            get { return Path.GetDirectoryName(ToolsDir); }
        }

        public static string PluginDir
        {
            get { return Path.Combine(FDDir, "Plugins"); }
        }

        public static string LibraryDir
        {
            get { return Path.Combine(FDDir, "Library"); }
        }

        public static string BaseDir
        {
            get { return StandaloneMode ? FDDir : PathHelper.UserAppDir; }
        }

        public static bool StandaloneMode
        {
            get { return File.Exists(Path.Combine(FDDir, ".local")); }
        }

        public static string[] GetAllProjectFiles(string directory)
        {
            var projects = new List<string>();

            foreach (string file in Directory.GetFiles(directory))
                if (FileInspector.IsProject(file))
                    projects.Add(file);

            return projects.ToArray();
        }

        public static string GetSettingsPath(string pluginName)
        {
            string dataDir = Path.Combine(BaseDir, "Data");
            string as3DataDir = Path.Combine(dataDir, pluginName);
            return Path.Combine(as3DataDir, "Settings.fdb");
        }
    }
}
