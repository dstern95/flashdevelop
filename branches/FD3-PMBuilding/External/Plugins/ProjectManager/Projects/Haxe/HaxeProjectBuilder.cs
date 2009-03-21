using System;
using System.IO;
using FDBuild.Building;
using ProjectManager.Projects.Haxe;

namespace ProjectManager.Projects.Building.Haxe
{
    public class HaxeProjectBuilder : ProjectBuilder
    {
        public new HaxeProject Project { get { return (HaxeProject)base.Project; } }

        public HaxeProjectBuilder(HaxeProject project) : base(project) { }

        protected override void DoBuild()
        {
            string basePath = CompilerPath ?? @"C:\Program Files\Motion-Twin\haxe"; // default installation
            string haxePath = Path.Combine(basePath, "haxe.exe");
            if (!File.Exists(haxePath))
                haxePath = "haxe.exe"; // hope you have it in your environment path!

            Environment.CurrentDirectory = Project.Directory;

            string outputDir = Path.GetDirectoryName(Project.OutputPathAbsolute);
            if (!Directory.Exists(outputDir)) Directory.CreateDirectory(outputDir);

            if (Project.IsFlashOutput)
            {
                SwfmillLibraryBuilder libraryBuilder = new SwfmillLibraryBuilder();

                // before doing anything else, make sure any resources marked as "keep updated"
                // are properly kept up to date if possible
                libraryBuilder.KeepUpdated(Project);

                // if we have any resources, build our library file and run swfmill on it
                libraryBuilder.BuildLibrarySwf(Project, Project.CompilerOptions.Verbose);
            }

            string tempFile = Path.GetTempFileName();

            try
            {
                if (File.Exists(tempFile)) File.Delete(tempFile);

                HaxeArgumentBuilder haxe = new HaxeArgumentBuilder(Project);
                haxe.AddLibraries(Project.CompilerOptions.Libraries);
                haxe.AddClassPaths(ExtraClasspaths);
                haxe.AddHeader();
                haxe.AddCompileTargets();
                haxe.AddOutput(tempFile);
                haxe.AddOptions(NoTrace);

                string haxeArgs = haxe.ToString();

                Log("haxe " + haxeArgs);

                if (!ProcessRunner.Run(haxePath, haxeArgs, false))
                    throw new BuildException("Build halted with errors (haxe.exe).");

                // if we get here, the build was successful
                string output = Project.FixDebugReleasePath(Project.OutputPathAbsolute);
                File.Copy(tempFile, output, true);
            }
            finally { File.Delete(tempFile); }
        }
    }
}
