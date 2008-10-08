using System.IO;
using PluginCore;

namespace ProjectManager.Projects
{
    public class Solution : ISolution
    {
        string path;
        PathCollection projectPaths;

        public Solution(string path)
        {
            this.path = path;
            this.projectPaths = new PathCollection();
        }

        /// <summary>
        /// Gets the full path to this solution file, including filename.
        /// </summary>
        public string SolutionPath { get { return path; } }
        public bool IsTempSolution { get { return path == null; } }
        public string Name { get { return Path.GetFileNameWithoutExtension(path); } }
        public string Directory { get { return Path.GetDirectoryName(path); } }

        public string[] ProjectPaths
        {
            get { return projectPaths.ToArray(); }
        }

        #region Relative Path Helpers

        public string GetRelativePath(string path)
        {
            return Projects.ProjectPaths.GetRelativePath(this.Directory, path);
        }

        public string GetAbsolutePath(string path)
        {
            return Projects.ProjectPaths.GetAbsolutePath(this.Directory, path);
        }

        #endregion
    }
}
