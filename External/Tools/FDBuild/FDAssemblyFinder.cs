using System;
using System.IO;
using System.Reflection;

namespace FDBuild
{
    static class FDAssemblyFinder
    {
        static string pluginsDir, fdDir;

        public static void Setup()
        {
            AppDomain.CurrentDomain.AssemblyResolve += ResolveFDAssembly;

            string url = Assembly.GetEntryAssembly().GetName().CodeBase;
            string fdBuildDir = Path.GetDirectoryName(new Uri(url).LocalPath);
            string toolsDir = Path.GetDirectoryName(fdBuildDir);
            fdDir = Path.GetDirectoryName(toolsDir);
            pluginsDir = Path.Combine(fdDir, "Plugins");
        }

        static Assembly ResolveFDAssembly(object sender, ResolveEventArgs args)
        {
            string[] split = args.Name.Split(',');

            if (split.Length > 0)
            {
                string dllName = split[0] + ".dll";
                string pluginsPath = Path.Combine(pluginsDir, dllName);
                string fdPath = Path.Combine(fdDir, dllName);

                if (File.Exists(pluginsPath))
                    return Assembly.LoadFile(pluginsPath);
                else if (File.Exists(fdPath))
                    return Assembly.LoadFile(fdPath);
            }
            return null;
        }
    }
}
