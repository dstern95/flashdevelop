using System;

namespace ProjectManager.Projects.Building
{
    public class BuildException : Exception
    {
        public BuildException(string message) : base(message) { }
    }
}
