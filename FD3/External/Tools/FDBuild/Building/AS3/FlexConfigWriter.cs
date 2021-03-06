using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using ProjectManager.Projects.AS3;
using System.IO;
using System.Collections;

namespace FDBuild.Building.AS3
{
    class FlexConfigWriter : XmlTextWriter
    {
        AS3Project project;

        public FlexConfigWriter(string libraryPath): base(libraryPath, new UTF8Encoding(false))
        {
            base.Formatting = Formatting.Indented;
        }

        public void WriteConfig(AS3Project project, string[] extraClasspaths, bool debugMode)
        {
            this.project = project;

            try { InternalWriteConfig(extraClasspaths, debugMode); }
            finally { Close(); }
        }

        private void InternalWriteConfig(string[] extraClasspaths, bool debugMode)
        {
            WriteStartDocument();
            WriteComment("This Adobe Flex compiler configuration file was generated by a tool.");
            WriteComment("Any modifications you make may be lost.");
            WriteStartElement("flex-config");
                AddTargetPlayer();
                WriteStartElement("compiler");
                    AddCompilerConstants(debugMode);
                    AddClassPaths(extraClasspaths);
                    AddLibraries();
                WriteEndElement();
                AddRSLs();
                AddCompileTargets();
                AddMovieOptions();
            WriteEndElement();
        }

        private void AddCompilerConstants(bool debugMode)
        {
            WriteDefine("CONFIG::debug", debugMode ? "true" : "false");
            WriteDefine("CONFIG::release", debugMode ? "false" : "true");
            WriteDefine("CONFIG::timeStamp", "'" + DateTime.Now.ToString("d") + "'");

            if (project.CompilerOptions.CompilerConstants != null)
            {
                foreach (string define in project.CompilerOptions.CompilerConstants)
                {
                    int p = define.IndexOf(',');
                    if (p < 0) continue;
                    WriteDefine(define.Substring(0, p), define.Substring(p + 1));
                }
            }
        }

        private void WriteDefine(string name, string value)
        {
            WriteStartElement("define");
                WriteAttributeString("append", "true");
                WriteElementString("name", name);
                WriteElementString("value", value);
            WriteEndElement();
        }

        private void AddTargetPlayer()
        {
            int majorVersion = project.MovieOptions.Version;
            string minorVersion = project.CompilerOptions.MinorVersion;
            if (majorVersion == 11)
            {
                majorVersion = 10;
                minorVersion = "1.0";
            }
            if (minorVersion.Length == 0) minorVersion = "0.0";

            WriteElementString("target-player", majorVersion + "." + minorVersion);
        }

        private void AddLibraries()
        {
            MxmlcOptions options = project.CompilerOptions;
            string absPath;
            if (options.IncludeLibraries.Length > 0)
            {
                WriteStartElement("include-libraries");
                foreach (string path in options.IncludeLibraries)
                {
                    absPath = project.GetAbsolutePath(path);
                    if (File.Exists(absPath))
                        WriteElementPathString("library", absPath);
                    else if (Directory.Exists(absPath))
                    {
                        string[] libs = Directory.GetFiles(absPath, "*.swc");
                        foreach(string lib in libs)
                            WriteElementPathString("library", lib);
                    }
                }
                WriteEndElement();
            }
            if (options.ExternalLibraryPaths.Length > 0)
            {
                WriteStartElement("external-library-path");
                WriteAttributeString("append", "true");
                foreach (string path in options.ExternalLibraryPaths)
                {
                    absPath = project.GetAbsolutePath(path);
                    if (File.Exists(absPath) || Directory.Exists(absPath))
                        WriteElementPathString("path-element", absPath);
                }
                WriteEndElement();
            }
            if (options.LibraryPaths.Length > 0)
            {
                WriteStartElement("library-path");
                WriteAttributeString("append", "true");
                foreach (string path in options.LibraryPaths)
                {
                    absPath = project.GetAbsolutePath(path);
                    if (File.Exists(absPath) || Directory.Exists(absPath))
                        WriteElementPathString("path-element", absPath);
                }
                WriteEndElement();
            }
        }

        private void AddRSLs()
        {
            MxmlcOptions options = project.CompilerOptions;
            if (options.RSLPaths.Length > 0)
            {
                foreach (string path in options.RSLPaths)
                {
                    string[] parts = path.Split(',');
                    if (parts.Length < 2) continue;
                    string absPath = project.GetAbsolutePath(parts[0]);
                    if (File.Exists(absPath))
                    {
                        WriteStartElement("runtime-shared-library-path");
                            WriteElementString("path-element", absPath);
                            WriteElementString("rsl-url", parts[1]);
                            if (parts.Length > 2)
                                WriteElementString("policy-file-url", parts[2]);
                            if (parts.Length > 3)
                                WriteElementString("rsl-url", parts[3]);
                            if (parts.Length > 4)
                                WriteElementString("policy-file-url", parts[4]);
                        WriteEndElement();
                    }
                }
            }
        }

        private void AddMovieOptions()
        {
            WriteElementString("default-background-color", project.MovieOptions.Background);
            WriteElementString("default-frame-rate", project.MovieOptions.Fps.ToString());
            WriteStartElement("default-size");
                WriteElementString("width", project.MovieOptions.Width.ToString());
                WriteElementString("height", project.MovieOptions.Height.ToString());
            WriteEndElement();

            /*MxmlcOptions options = project.CompilerOptions;

            WriteStartElement("metadata");
                WriteElementString("title", options.MetaTitle);
                WriteElementString("description", options.MetaDescription);
                WriteElementString("publisher", options.MetaPublisher);
                WriteElementString("creator", options.MetaCreator);
                WriteElementString("language", options.MetaLanguage);
            WriteEndElement();*/
        }

        public void AddClassPaths(string[] extraClasspaths)
        {
            WriteStartElement("source-path");
            WriteAttributeString("append", "true");

            // build classpaths
            ArrayList classPaths = new ArrayList(project.AbsoluteClasspaths);

            foreach (string extraClassPath in extraClasspaths)
                if (Directory.Exists(extraClassPath))
                    classPaths.Add(extraClassPath);

            foreach (string classPath in classPaths)
                if (Directory.Exists(classPath))
                    WriteElementPathString("path-element", classPath);

            WriteEndElement();
        }

        private void WriteElementPathString(string name, string path)
        {
            if (Directory.Exists(path) || File.Exists(path))
                WriteElementString(name, path);
        }

        public void AddCompileTargets()
        {
            if (project.CompileTargets.Count == 0) return;
            WriteStartElement("file-specs");
            foreach (string relTarget in project.CompileTargets)
            {
                string target = project.GetAbsolutePath(relTarget);
                if (File.Exists(target))
                {
                    WriteElementString("path-element", target);
                    break;
                }
            }
            WriteEndElement();
        }
    }
}
