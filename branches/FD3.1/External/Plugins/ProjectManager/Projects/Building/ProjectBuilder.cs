using PluginCore.Managers;

namespace ProjectManager.Projects.Building
{
    public abstract class ProjectBuilder
    {
        public Project Project { get; private set; }
        public string CompilerPath { get; set; }
        public string[] ExtraClasspaths { get; set; }
        public bool NoTrace { get; set; }

        protected ProjectBuilder(Project project)
        {
            this.Project = project;
        }
        
        public void Build()
        {
            Log("Building " + Project.Name);

            BuildEventRunner runner = new BuildEventRunner(Project, CompilerPath);
            bool attempedPostBuildEvent = false;

            try
            {
                if (Project.PreBuildEvent.Length > 0)
                {
                    Log("Running Pre-Build Command Line...");
                    runner.Run(Project.PreBuildEvent);
                }
                if (!Project.NoOutput) DoBuild();
                attempedPostBuildEvent = true;

                if (Project.PostBuildEvent.Length > 0)
                {
                    Log("Running Post-Build Command Line...");
                    runner.Run(Project.PostBuildEvent);
                }
            }
            finally
            {
                // honor the post-build request on a failed build if you want
                if (!attempedPostBuildEvent && Project.AlwaysRunPostBuild &&
                    Project.PostBuildEvent.Length > 0)
                {
                    Log("Running Post-Build Command Line...");
                    runner.Run(Project.PostBuildEvent);
                }
            }

            Log("Build succeeded");
        }

        protected abstract void DoBuild();

        public static void Log(string message)
        {
            TraceManager.AddAsync(message);
        }

        public static void LogError(string message)
        {
            TraceManager.AddAsync(message, (int)PluginCore.TraceType.Error);
        }
    }
}
