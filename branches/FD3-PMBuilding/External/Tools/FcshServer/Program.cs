using System;
using System.IO;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;
using System.Threading;
using System.Xml;
using FcshServer.Properties;
using ProjectManager.Helpers;
using ProjectManager.Projects.Building;

namespace FcshServer
{
    class Program
    {
        static void Main(string[] args)
        {
            if (string.IsNullOrEmpty(Settings.Default.FromPath) || string.IsNullOrEmpty(Settings.Default.ToPath))
            {
                Console.WriteLine("Please set the correct FromPath -> ToPath mapping in fcshserver.exe.config.");
                Console.WriteLine("The FromPath should be the base path to your code according to FlashDevelop, and the ToPath should be the corresponding path on the filesystem from which you are running fcshserver.");
                return;
            }

            TcpChannel channel = new TcpChannel(20202);
            ChannelServices.RegisterChannel(channel, false);
            RemotingConfiguration.RegisterWellKnownServiceType(
                typeof(PathReplacingFlexCompilerShell), "FlexCompilerShell", WellKnownObjectMode.Singleton);

            Console.WriteLine("Server is running on port 20202.");
            Console.ReadLine();

            FlexCompilerShell.Cleanup();
        }
    }

    class PathReplacingFlexCompilerShell : FlexCompilerShell
    {
        string fromPath;
        string toPath;

        public override void Compile(string projectPath, string arguments,
            out string output, out string[] errors, string jvmarg)
        {
            Console.WriteLine("[{0}] Compiling {1}...", DateTime.Now, projectPath);

            try
            {
                fromPath = Settings.Default.FromPath;
                toPath = Settings.Default.ToPath;

                projectPath = ConvertPath(projectPath);
                arguments = ConvertPath(arguments);
                jvmarg = ConvertPath(jvmarg);
                
                // load up and convert paths in the XML build file
                string objDir = Path.Combine(projectPath, "obj");
                string buildFile = Directory.GetFiles(objDir, "*.xml")[0];
                
                var document = new XmlDocument();
                document.Load(buildFile);
                ConvertNodes(document.DocumentElement.ChildNodes);

                string ourBuildFile = Path.Combine(objDir, Path.GetFileNameWithoutExtension(buildFile) + "Server.xml");
                string ourTempBuildFile = Path.Combine(objDir, Path.GetFileNameWithoutExtension(buildFile) + "Server.tmp");

                document.Save(ourTempBuildFile);

                if (!File.Exists(ourBuildFile) || !FileComparer.IsEqual(ourBuildFile, ourTempBuildFile))
                    File.Copy(ourTempBuildFile, ourBuildFile, true);

                File.Delete(ourTempBuildFile);

                arguments = arguments.Replace(Path.GetFileName(buildFile), Path.GetFileName(ourBuildFile));

                base.Compile(projectPath, arguments, out output, out errors, jvmarg);

                for (int i = 0; i < errors.Length; i++)
                    errors[i] = ConvertBack(errors[i]);

                Thread.Sleep(100);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        void ConvertNodes(XmlNodeList xmlNodeList)
        {
            foreach (XmlNode node in xmlNodeList)
                if (node.Name == "path-element")
                    node.InnerText = ConvertPath(node.InnerText);
                else if (node.HasChildNodes)
                    ConvertNodes(node.ChildNodes);
        }

        string ConvertPath(string path)
        {
            string replaced = path.Replace(fromPath, toPath);

            // swap slashes if we're on unix
            if (Environment.OSVersion.Platform == PlatformID.Unix)
                replaced = replaced.Replace('\\', '/');

            return replaced;
        }

        string ConvertBack(string path)
        {
            string replaced = path.Replace(toPath, fromPath);

            if (Environment.OSVersion.Platform == PlatformID.Unix)
                replaced = replaced.Replace('/', '\\');
            
            return replaced;
        }
    }
}
