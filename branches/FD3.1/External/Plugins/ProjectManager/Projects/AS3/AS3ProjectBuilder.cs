using System;
using System.IO;
using FDBuild.Building.AS3;
using ProjectManager.Helpers;
using ProjectManager.Projects.AS3;

namespace ProjectManager.Projects.Building.AS3
{
    public class AS3ProjectBuilder : ProjectBuilder
    {
        public new AS3Project Project { get { return (AS3Project)base.Project; } }
        
        static FlexCompilerShell fcsh;
        const string VMARGS = "-Xmx384m -Dsun.io.useCanonCaches=false -Duser.language=en";
        string sdkPath;
        string mxmlcPath;
        string fcshPath;

        public AS3ProjectBuilder(AS3Project project) : base(project) { }

        private void DetectFlexSdk()
        {
            sdkPath = CompilerPath;
            if (Path.GetFileName(CompilerPath) == "bin") sdkPath = Path.GetDirectoryName(CompilerPath);
            mxmlcPath = Path.Combine(Path.Combine(sdkPath, "lib"), "mxmlc.jar");
            fcshPath = Path.Combine(Path.Combine(sdkPath, "lib"), "fcsh.jar");
        }

        protected override void DoBuild()
        {
            DetectFlexSdk();

            bool mxmlcExists = File.Exists(mxmlcPath);
            bool fcshExists = File.Exists(fcshPath);

            if (!mxmlcExists && !Project.NoOutput)
                throw new Exception("Could not locate lib\\mxmlc.jar in Flex SDK. Please set the correct path to the Flex SDK in AS3Context plugin settings.");

            if (fcsh == null)
            {
                string server = PluginMain.Settings.FcshServer;

                if (!string.IsNullOrEmpty(server))
                    fcsh = (FlexCompilerShell)Activator.GetObject(typeof(FlexCompilerShell),
                        "tcp://" + server + ":20202/FlexCompilerShell");
                else
                    fcsh = new FlexCompilerShell();
            }

            string tempFile = null;
            
            Environment.CurrentDirectory = Project.Directory;
            try
            {
               
                string objDir = "obj";
                if (!Directory.Exists(objDir)) Directory.CreateDirectory(objDir);
                tempFile = GetTempProjectFile(Project);

                //create new config file

                // create compiler configuration file
                string backupConfig = Path.Combine(objDir, Project.Name + "Config.old");
                string configFileTmp = Path.Combine(objDir, Project.Name + "Config.tmp");
                string configFile = Path.Combine(objDir, Project.Name + "Config.xml");

                // backup the old Config.xml to Config.old so we can reference it
                if (File.Exists(configFile))
                    File.Copy(configFile, backupConfig, true);

                //write "new" config to tmp 
                FlexConfigWriter config = new FlexConfigWriter(Project.GetAbsolutePath(configFileTmp));
                config.WriteConfig(Project, ExtraClasspaths);

                //compare tmp to current
                bool configChanged = !File.Exists(backupConfig) || !File.Exists(configFile) || !FileComparer.IsEqual(configFileTmp, configFile);

                //copy temp file to config if there is a change
                if (configChanged){
                    File.Copy(configFileTmp, configFile, true);
                }

                //remove temp
                File.Delete(configFileTmp);
                
                MxmlcArgumentBuilder mxmlc = new MxmlcArgumentBuilder(Project);

                mxmlc.AddConfig(configFile);
                mxmlc.AddOptions(NoTrace == false, fcsh != null);
                mxmlc.AddOutput(tempFile);

                string mxmlcArgs = mxmlc.ToString();

                Log("mxmlc " + mxmlcArgs);

                CompileWithMxmlc(Project.Directory, mxmlcArgs, configChanged);

                // if we get here, the build was successful
                string output = Project.FixDebugReleasePath(Project.OutputPathAbsolute);
                string outputDir = Path.GetDirectoryName(output);
                if (!Directory.Exists(outputDir)) Directory.CreateDirectory(outputDir);
                File.Copy(tempFile, output, true);
            }
            finally { if (tempFile != null && File.Exists(tempFile)) File.Delete(tempFile); }
        }

        public void CompileWithMxmlc(string workingdir, string arguments, bool configChanged)
        {
            if (fcsh != null)
            {
                string output;
                string[] errors;
                string jvmarg = VMARGS + " -Dapplication.home=\""+ sdkPath + "\" -jar \"" + fcshPath + "\"";
                fcsh.Compile(workingdir, arguments, out output, out errors, jvmarg);

                Log(output);
                foreach (string error in errors)
                    LogError(error);

                if (errors.Length > 0)
                    throw new BuildException("Build halted with errors (fcsh).");
            }
            else
            {
                string jvmarg = VMARGS + " -jar \"" + mxmlcPath + "\" +flexlib=\"" + Path.Combine(sdkPath, "frameworks") + "\" ";
                if (!ProcessRunner.Run("java.exe", jvmarg + arguments, false))
                    throw new BuildException("Build halted with errors (mxmlc).");
            }
        }

        // each project needs to have its own temporary build target that is consistent
        // between builds.  This is necessary because the arguments to the FlexCompilerShell
        // (if you're using it) have to be identical between builds to enable incremental compiling.
        //private string GetTempProjectFile(AS3Project project)
        private string GetTempProjectFile(AS3Project project)
        {
            // this serves two purposes - randomize the filename, so two identically-named
            // projects don't get the same temp build target, and also provide an extra
            // method of forcing a recompile after a project modification.
            long modified = File.GetLastWriteTime(project.ProjectPath).Ticks;
            string tempFileName = project.Name + modified;
            string tempPath = "obj";
            string tempFile = Path.Combine(tempPath, tempFileName);
            File.Create(tempFile).Close();
            return tempFile;
        }
    }
}
