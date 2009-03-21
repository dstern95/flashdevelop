using System;
using System.Collections;
using System.IO;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Helpers;
using PluginCore.Localization;
using PluginCore.Managers;
using ProjectManager.Controls;
using ProjectManager.Helpers;
using ProjectManager.Projects;
using ProjectManager.Projects.AS2;
using ProjectManager.Projects.AS3;
using ProjectManager.Projects.Building;

namespace ProjectManager.Actions
{
	public delegate void BuildCompleteHandler(bool runOutput);

	/// <summary>
	/// Provides methods for building a project inside FlashDevelop
	/// </summary>
	public class BuildActions
	{
		IMainForm mainForm;
        FDMenus menus;
		FDProcessRunner fdProcess;
        
		public event BuildCompleteHandler BuildComplete;
        public event BuildCompleteHandler BuildFailed;

		public BuildActions(IMainForm mainForm, FDMenus menus)
		{
			this.mainForm = mainForm;
            this.menus = menus;

			// setup FDProcess helper class
			this.fdProcess = new FDProcessRunner(mainForm);
		}

        public bool Build(Project project, bool runOutput, bool noTrace)
        {
            // save modified files
            mainForm.CallCommand("SaveAllModified", null);

            string compiler = null;
            project.TraceEnabled = !noTrace;
            if (project.NoOutput)
            {
                // get the compiler for as3 projects, or else the FDBuildCommand pre/post command in FDBuild will fail on "No Output" projects
                if (project.Language == "as3")
                    compiler = GetCompilerPath(project);
                
                if (project.PreBuildEvent.Trim().Length == 0 && project.PostBuildEvent.Trim().Length == 0)
                {
                    // no output and no build commands
                    if (project is AS2Project || project is AS3Project) RunFlashIDE(runOutput, noTrace);
                    else
                    {
                        String info = TextHelper.GetString("Info.NoOutputAndNoBuild");
                        ErrorManager.ShowInfo(info);
                    }
                    return false;
                }
            }
            else
            {
                // Ask the project to validate itself
                string error;
                project.ValidateBuild(out error);

                if (error != null)
                {
                    ErrorManager.ShowInfo(TextHelper.GetString(error));
                    return false;
                }

                if (project.OutputPath.Length < 1)
                {
                    String info = TextHelper.GetString("Info.SpecifyValidOutputSWF");
                    ErrorManager.ShowInfo(info);
                    return false;
                }

                bool isProjectDefinedCompiler;
                compiler = GetCompilerPath(project, out isProjectDefinedCompiler);

                if (compiler == null || (!Directory.Exists(compiler) && !File.Exists(compiler)))
                {
                    if (isProjectDefinedCompiler)
                    {
                        string info = TextHelper.GetString("Info.InvalidCustomCompiler");
                        MessageBox.Show(info, TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.OK);
                    }
                    else
                    {
                        string info = String.Format(TextHelper.GetString("Info.SpecifyCompilerPath"), project.Language.ToUpper());
                        DialogResult result = MessageBox.Show(info, TextHelper.GetString("Title.ConfigurationRequired"), MessageBoxButtons.OKCancel);
                        if (result == DialogResult.OK)
                        {
                            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.ShowSettings", project.Language);
                            EventManager.DispatchEvent(this, de);
                        }
                    }
                    return false;
                }
            }

            BuildUsingProjectBuilder(project, runOutput, noTrace, compiler);
            return true;
        }

        private void RunFlashIDE(bool runOutput, bool noTrace)
        {
            string cmd = (runOutput) ? "testmovie.jsfl" : "buildmovie.jsfl";
            if (!noTrace) cmd = "debug-" + cmd;
            cmd = Path.Combine("Tools", Path.Combine("flashide", cmd));
            cmd = PathHelper.ResolvePath(cmd, null);
            if (cmd == null || !File.Exists(cmd))
            {
                ErrorManager.ShowInfo(TextHelper.GetString("Info.JsflNotFound"));
            }
            else
            {
                DataEvent de = new DataEvent(EventType.Command, "ASCompletion.CallFlashIDE", cmd);
                EventManager.DispatchEvent(this, de);
            }
        }

        public void BuildUsingProjectBuilder(Project project, bool runOutput, bool noTrace, string compiler)
        {
            ProjectBuilder builder = project.CreateBuilder();
            builder.CompilerPath = compiler;
            builder.ExtraClasspaths = PluginMain.Settings.GlobalClasspaths.ToArray();
            builder.NoTrace = noTrace;

            SetStatusBar(TextHelper.GetString("Info.BuildStarted"));
            menus.DisabledForBuild = true;
            menus.ConfigurationSelector.Enabled = false;

            EventManager.DispatchEvent(this, new NotifyEvent(EventType.ProcessStart));

            // clear the results panel
            //EventManager.DispatchEvent(this, new DataEvent(EventType.Command, "ResultsPanel.ClearResults", null));

            var invoker = new MethodInvoker(builder.Build);
            invoker.BeginInvoke(delegate(IAsyncResult result)
            {
                mainForm.CurrentDocument.SciControl.Parent.BeginInvoke((MethodInvoker)delegate
                {
                    menus.DisabledForBuild = false;
                    menus.ConfigurationSelector.Enabled = !project.NoOutput;

                    try
                    {
                        invoker.EndInvoke(result);

                        SetStatusBar(TextHelper.GetString("Info.BuildSucceeded"));
                        AddTrustFile(project);
                        OnBuildComplete(runOutput);

                        EventManager.DispatchEvent(this, new TextEvent(EventType.ProcessEnd, "Done (0)"));
                    }
                    catch (Exception e)
                    {
                        TraceManager.Add(e.Message);
                        SetStatusBar(TextHelper.GetString("Info.BuildFailed"));
                        OnBuildFailed(runOutput);

                        EventManager.DispatchEvent(this, new TextEvent(EventType.ProcessEnd, "Done (1)"));
                    }
                });
            }, null);
        }

        /// <summary>
        /// Retrieve the project language's default compiler path
        /// </summary>
        static public string GetCompilerPath(Project project)
        {
            bool dontCare;
            return GetCompilerPath(project, out dontCare);
        }

        static public string GetCompilerPath(Project project, out bool isProjectDefinedCompiler)
        {
            if (project.Language == "as3" && (project as AS3Project).CompilerOptions.CustomSDK.Length > 0)
            {
                isProjectDefinedCompiler = true;
                return PathHelper.ResolvePath((project as AS3Project).CompilerOptions.CustomSDK, project.Directory);
            }
            isProjectDefinedCompiler = false;

            Hashtable info = new Hashtable();
            info["language"] = project.Language;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.GetCompilerPath", info);
            EventManager.DispatchEvent(project, de);
            if (de.Handled && info.ContainsKey("compiler")) return PathHelper.ResolvePath(info["compiler"] as string, project.Directory);
            else return null;
        }

        void OnBuildComplete(bool runOutput)
        {
            if (BuildComplete != null)
                BuildComplete(runOutput);
        }

        void OnBuildFailed(bool runOutput)
        {
            if (BuildFailed != null)
                BuildFailed(runOutput);
        }

        void AddTrustFile(Project project)
        {
            string directory = Path.GetDirectoryName(project.OutputPathAbsolute);
            if (!Directory.Exists(directory))
                return;
            string trustFile = directory.Replace(Path.DirectorySeparatorChar, '_').Remove(1, 1);
            while ((trustFile.Length > 100) && (trustFile.IndexOf('_') > 0)) trustFile = trustFile.Substring(trustFile.IndexOf('_'));
            string trustParams = "FlashDevelop_" + trustFile + ".cfg;" + directory;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.CreateTrustFile", trustParams);
            EventManager.DispatchEvent(this, de);
        }

		public void NotifyBuildStarted() { fdProcess.ProcessStartedEventCaught(); }
		public void NotifyBuildEnded(string result) { fdProcess.ProcessEndedEventCaught(result); }

		void SetStatusBar(string text) { mainForm.StatusLabel.Text = " " + text; }
	}
}
