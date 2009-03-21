using System;
using System.IO;
using FDBuild.Building;
using PluginCore.Helpers;
using ProjectManager.Projects.AS2;

namespace ProjectManager.Projects.Building.AS2
{
	public class AS2ProjectBuilder : ProjectBuilder
	{
        public new AS2Project Project { get { return (AS2Project)base.Project; } }

		#region Path Helpers
		
        string MtascPath
		{
			get
			{
                // path given in arguments
                if (CompilerPath != null)
                {
                    if (File.Exists(CompilerPath)) return CompilerPath;
                    if (File.Exists(Path.Combine(CompilerPath, "mtasc.exe")))
                        return Path.Combine(CompilerPath, "mtasc.exe");
                }

				string mtascDir = Path.Combine(PathHelper.ToolDir, "mtasc");
				string mtascPath = Path.Combine(mtascDir, "mtasc.exe");
                
                if (File.Exists(mtascPath))
					return mtascPath;
				else
					return "mtasc.exe"; // hope you have it in your environment path!
			}
		}

		#endregion

        public AS2ProjectBuilder(AS2Project project) : base(project) { }

		protected override void DoBuild()
		{
			Environment.CurrentDirectory = Project.Directory;

            string outputDir = Path.GetDirectoryName(Project.OutputPathAbsolute);
            if (!Directory.Exists(outputDir)) Directory.CreateDirectory(outputDir);

            SwfmillLibraryBuilder libraryBuilder = new SwfmillLibraryBuilder();

			// before doing anything else, make sure any resources marked as "keep updated"
			// are properly kept up to date if possible
            libraryBuilder.KeepUpdated(Project);

            // if we have any resources, build our library file and run swfmill on it
            libraryBuilder.BuildLibrarySwf(Project, Project.CompilerOptions.Verbose);

			// do we have anything to compile?
			if (Project.CompileTargets.Count > 0 || 
				Project.CompilerOptions.IncludePackages.Length > 0)
			{
				MtascArgumentBuilder mtasc = new MtascArgumentBuilder(Project);
				mtasc.AddCompileTargets();
				mtasc.AddOutput();
				mtasc.AddClassPaths(ExtraClasspaths);
				mtasc.AddOptions(NoTrace);

				if (Project.UsesInjection)
				{
					mtasc.AddInput();
				}
				else
				{
                    mtasc.AddFrame(libraryBuilder.Frame);

					if (Project.LibraryAssets.Count == 0)
						mtasc.AddHeader(); // mtasc will have to generate its own output SWF
					else
						mtasc.AddKeep(); // keep everything you added with swfmill
				}
				
				string mtascArgs = mtasc.ToString();

				if (Project.CompilerOptions.Verbose)
					Log("mtasc " + mtascArgs);

				if (!ProcessRunner.Run(MtascPath, mtascArgs, false))
					throw new BuildException("Build halted with errors (mtasc).");
			}
		}

		private void KeepUpdated()
		{
			foreach (LibraryAsset asset in Project.LibraryAssets)
				if (asset.UpdatePath != null)
				{
					string assetName = Path.GetFileName(asset.Path);
					string assetPath = Project.GetAbsolutePath(asset.Path);
					string updatePath = Project.GetAbsolutePath(asset.UpdatePath);
					if (File.Exists(updatePath))
					{
						// check size/modified
						FileInfo source = new FileInfo(updatePath);
						FileInfo dest = new FileInfo(assetPath);

						if (source.LastWriteTime != dest.LastWriteTime ||
							source.Length != dest.Length)
						{
							Log("Updating asset '" + assetName + "'");
							File.Copy(updatePath,assetPath,true);
						}
					}
					else
					{
						Console.Error.WriteLine("Warning: asset '"+assetName+"' could "
							+ " not be updated, as the source file could does not exist.");
					}
				}
		}
	}
}
