using System;
using System.IO;
using ProjectManager.Projects;
using ProjectManager.Projects.Building;
using PluginCore.Helpers;

namespace FDBuild.Building
{
    class SwfmillLibraryBuilder
    {
        string SwfmillPath
        {
            get
            {
                string swfmillDir = Path.Combine(PathHelper.ToolDir, "swfmill");
                string swfmillPath = Path.Combine(swfmillDir, "swfmill.exe");

                if (File.Exists(swfmillPath))
                    return swfmillPath;
                else
                    return "swfmill.exe"; // hope you have it in your environment path!
            }
        }

        public int Frame;

        public void KeepUpdated(Project project)
        {
            foreach (LibraryAsset asset in project.LibraryAssets)
                if (asset.UpdatePath != null)
                {
                    string assetName = Path.GetFileName(asset.Path);
                    string assetPath = project.GetAbsolutePath(asset.Path);
                    string updatePath = project.GetAbsolutePath(asset.UpdatePath);
                    if (File.Exists(updatePath))
                    {
                        // check size/modified
                        FileInfo source = new FileInfo(updatePath);
                        FileInfo dest = new FileInfo(assetPath);

                        if (source.LastWriteTime != dest.LastWriteTime ||
                            source.Length != dest.Length)
                        {
                            ProjectBuilder.Log("Updating asset '" + assetName + "'");
                            File.Copy(updatePath, assetPath, true);
                        }
                    }
                    else
                    {
                        Console.Error.WriteLine("Warning: asset '" + assetName + "' could "
                            + " not be updated, as the source file could does not exist.");
                    }
                }
        }

        public void BuildLibrarySwf(Project project, bool verbose)
        {
            // compile into frame 1 unless you're using shared libraries or preloaders
            Frame = 1;

            // delete existing output file if it exists
            if (File.Exists(project.OutputPath))
                File.Delete(project.OutputPath);

            // if we have any resources, build our library file and run swfmill on it
            if (!project.UsesInjection && project.LibraryAssets.Count > 0)
            {
                // ensure obj directory exists
                if (!Directory.Exists("obj"))
                    Directory.CreateDirectory("obj");

                string backupLibraryPath = Path.Combine("obj", project.Name + "Library.old");
                string relLibraryPath = Path.Combine("obj", project.Name + "Library.xml");
                string backupSwfPath = Path.Combine("obj", project.Name + "Resources.swf");
                string arguments = string.Format("simple \"{0}\" \"{1}\"",
                    relLibraryPath, project.OutputPath);

                // backup the old Library.xml to Library.old so we can reference it
                if (File.Exists(relLibraryPath))
                    File.Copy(relLibraryPath, backupLibraryPath, true);

                SwfmillLibraryWriter swfmill = new SwfmillLibraryWriter(relLibraryPath);
                swfmill.WriteProject(project);

                if (swfmill.NeedsMoreFrames) Frame = 3;

                // compare the Library.xml with the one we generated last time.
                // if they're identical, and we have a Resources.swf, then we can
                // just assume that Resources.swf is up to date.
                if (File.Exists(backupSwfPath) && File.Exists(backupLibraryPath) &&
                    FileComparer.IsEqual(relLibraryPath, backupLibraryPath))
                {
                    // just copy the old one over!
                    File.Copy(backupSwfPath, project.OutputPath, true);
                }
                else
                {
                    // delete old resource SWF as it's not longer valid
                    if (File.Exists(backupSwfPath))
                        File.Delete(backupSwfPath);

                    ProjectBuilder.Log("Compiling resources");

                    if (verbose)
                        ProjectBuilder.Log("swfmill " + arguments);

                    if (!ProcessRunner.Run(SwfmillPath, arguments, true))
                        throw new BuildException("Build halted with errors (swfmill).");

                    // ok, we just generated a swf with all our resources ... save it for
                    // reuse if no resources changed next time we compile
                    try { File.Copy(project.OutputPath, backupSwfPath, true); }
                    catch (Exception exception) { Console.Error.WriteLine("Could not backup the resources SWF: " + exception.Message); }
                }
            }
        }
    }
}
