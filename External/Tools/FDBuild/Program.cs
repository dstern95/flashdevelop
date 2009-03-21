using System;
using System.IO;
using System.Reflection;
using System.Text;
using ProjectManager.Projects;
using ProjectManager.Projects.Building;
using ProjectManager;
using AS3Context;
using PluginCore.Utilities;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects.Building.AS3;

namespace FDBuild
{
    /// <summary>
    /// FDBuild.exe is a command-line tool for compiling FlashDevelop project files.
    /// </summary>
    public class Program
    {
        public static int Main(string[] args)
        {
            FDAssemblyFinder.Setup();

            // We have to duck-type this method call so that the runtime doesn't attempt to load
            // any PM symbols before invoking this method. If we just called Process() directly,
            // it would look for ProjectManager.dll before we could call FDAssemblyFinder.Setup().
            var processMethod = typeof(Program).GetMethod("Process", BindingFlags.Static | BindingFlags.Public);
            return (int)processMethod.Invoke(null, new [] { args });
        }

        public static int Process(string[] args)
        {
            Console.OutputEncoding = Encoding.Default;
            ProjectBuilder.LogDelegate = LogToConsole;

            var options = GetOptionsAndDefaults(args);
            
            // save current directory - ProjectBuilder might change it
            string directory = Environment.CurrentDirectory;
            
            try
            {
                if (options.ProjectFile.Length > 0)
                    Build(Path.GetFullPath(options.ProjectFile), options);
                else
                {
                    // build everything in this directory
                    string[] files = FDBuildPaths.GetAllProjectFiles(directory);

                    if (files.Length == 0)
                    {
                        options.DoHelp();
                        return 0;
                    }

                    foreach (string file in files)
                        Build(file, options);
                }

                return 0;
            }
            catch (BuildException exception)
            {
                Console.Error.WriteLine(exception.Message);
                return 1;
            }
            catch (Exception exception)
            {
                Console.Error.WriteLine("Exception: " + exception);
                return 1;
            }
            finally
            {
                Environment.CurrentDirectory = directory;

                if (options.PauseAtEnd)
                {
                    Console.WriteLine();
                    Console.WriteLine("Press enter to continue...");
                    Console.ReadLine();
                }
            }
        }

        static void LogToConsole(string message, bool isError)
        {
            if (isError) Console.Error.WriteLine(message); else Console.WriteLine(message);
        }

        static FDBuildOptions GetOptionsAndDefaults(string[] args)
        {
            var options = new FDBuildOptions(args);

            if (options.LibraryDir == null)
                options.LibraryDir = FDBuildPaths.LibraryDir;

            return options;
        }

        // Builds a single project
        public static void Build(string projectFile, FDBuildOptions options)
        {
            Project project = ProjectLoader.Load(projectFile);
            project.TraceEnabled = !options.NoTrace;
            options.Language = project.Language.ToUpper();

            ProjectBuilder builder = project.CreateBuilder();
            builder.CompilerPath = options.CompilerPath;
            builder.ExtraClasspaths = options.ExtraClasspaths;

            // this build will fail if you haven't specified a compile path!
            if (project is AS3Project && string.IsNullOrEmpty(options.CompilerPath))
            {
                var settings = new AS3Settings();
                settings = (AS3Settings)ObjectSerializer.Deserialize(
                    FDBuildPaths.GetSettingsPath("AS3Context"), settings);
                builder.CompilerPath = settings.FlexSDK;
            }

            // you also might want some options here
            if (project is AS3Project && ProjectManager.PluginMain.Settings == null)
            {
                ProjectManager.PluginMain.Settings = (ProjectManagerSettings)ObjectSerializer.Deserialize(
                    FDBuildPaths.GetSettingsPath("ProjectManager"), new ProjectManagerSettings());

                // if you're not using FcshServer, don't use Fcsh! since this is a one-shot thing.
                if (string.IsNullOrEmpty(ProjectManager.PluginMain.Settings.FcshServer))
                    AS3ProjectBuilder.AllowFcsh = false;
            }

            builder.Build();
        }

        /*
        /// <summary>
        /// Build from pre/post command: FDBuild
        /// </summary>
        /// <param name="projectFile"></param>
        public static void BuildProject(string projectFile)
        {
            Project project = ProjectLoader.Load(projectFile);
            Program.BuildOptions.Language = project.Language.ToUpper();

            ProjectBuilder builder = project.CreateBuilder();
            //builder.BuildCommand(Program.BuildOptions.ExtraClasspaths, Program.BuildOptions.NoTrace);
        }

        /// <summary>
        /// Build from pre/post command: mxmlc
        /// </summary>
        /// <param name="workingdir">the working directory for fsch, to have full optimization make this the same for all calls </param>
        /// <param name="arguments">the mxmlc arguments</param>
        public static void BuildMXMLC( string workingdir, string arguments )
        {
            //Project project = ProjectLoader.Load(projectFile);
            //Program.BuildOptions.Language = project.Language.ToUpper();

            //AS3ProjectBuilder builder = new AS3ProjectBuilder(null, Program.BuildOptions.CompilerPath, Program.BuildOptions.IpcName);
            //builder.CompileWithMxmlc(workingdir, arguments, true);
            
        }

        /// <summary>
        /// Build from pre/post command: compc
        /// </summary>
        /// <param name="workingdir">the working directory for fsch, to have full optimization make this the same for all calls </param>
        /// <param name="arguments">the compc arguments</param>
        public static void BuildCOMPC( string workingdir, string arguments )
        {
            //AS3ProjectBuilder builder = new AS3ProjectBuilder(null, Program.BuildOptions.CompilerPath, Program.BuildOptions.IpcName);
        }
        */
    }
}
