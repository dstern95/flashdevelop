﻿using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using PluginCore.Managers;
using System.Diagnostics;
using PluginCore.Helpers;
using PluginCore;
using System.Text.RegularExpressions;

namespace CssCompletion
{
    public class Optimizer
    {
        static public void ProcessFile(string fileName, CssFeatures features, Settings settings)
        {
            if (settings.DisableCompileOnSave) return;
            if (!string.IsNullOrEmpty(features.Compile)) CompileFile(fileName, features, settings);
            else CompressFile(fileName, features, settings);
        }

        static public void CompressFile(string fileName, CssFeatures features, Settings settings)
        {
            if (settings.DisableMinifyOnSave) return;
            try
            {
                if (!File.Exists(fileName)) return;
                string raw = File.ReadAllText(fileName);
                string min = CssMinifier.Minify(raw);
                string outFile = Path.Combine(Path.GetDirectoryName(fileName), Path.GetFileNameWithoutExtension(fileName)) + ".min.css";
                File.WriteAllText(outFile, min);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowInfo(ex.Message);
            }
        }

        static public void CompileFile(string fileName, CssFeatures features, Settings settings)
        {
            EventManager.DispatchEvent(features, new NotifyEvent(EventType.ProcessStart));

            string raw = File.ReadAllText(fileName);
            string options = "";
            Match mParams = Regex.Match(raw, "\\@options\\s(.*)", RegexOptions.Multiline);
            if (mParams.Success)
            {
                options = mParams.Groups[1].Value.Trim();
                int endComment = options.IndexOf("*/");
                if (endComment > 0) options = options.Substring(0, endComment).Trim();
            }

            string toolsDir = Path.Combine(PathHelper.ToolDir, "css");
            string[] parts = features.Compile.Split(';');
            string cmd = PathHelper.ResolvePath(parts[0], toolsDir);
            if (cmd == null)
            {
                TraceManager.Add(parts[0] + " command not found");
                return;
            }
            string outFile = Path.GetFileNameWithoutExtension(fileName) + ".css";
            string args = parts[1].Replace("$(options)", options)
                .Replace("$(in)", Path.GetFileName(fileName))
                .Replace("$(out)", outFile);
            TraceManager.Add(Path.GetFileNameWithoutExtension(cmd) + " " + args);

            ProcessStartInfo info = new ProcessStartInfo();
            info.FileName = cmd;
            info.Arguments = args;
            if (info.EnvironmentVariables.ContainsKey("path")) info.EnvironmentVariables["path"] += ";" + toolsDir;
            else info.EnvironmentVariables["path"] = toolsDir;
            info.CreateNoWindow = true;
            info.WorkingDirectory = Path.GetDirectoryName(fileName);
            info.UseShellExecute = false;
            info.RedirectStandardOutput = true;
            info.RedirectStandardError = true;
            Process p = Process.Start(info);
            if (p.WaitForExit(3000))
            {
                string res = p.StandardOutput.ReadToEnd() ?? "";
                string err = p.StandardError.ReadToEnd() ?? "";

                MatchCollection matches = features.ErrorPattern.Matches(err);
                if (matches.Count > 0)
                    foreach (Match m in matches)
                        TraceManager.Add(fileName + ":" + m.Groups["line"] + ": " + m.Groups["desc"].Value.Trim(), -3);

                if (settings.EnableVerboseCompilation || (err != "" && matches.Count == 0))
                {
                    if (res.Trim().Length > 0) TraceManager.Add(res);
                    if (err.Trim().Length > 0) TraceManager.Add(err, 3);
                }

                EventManager.DispatchEvent(features, new TextEvent(EventType.ProcessEnd, "Done(" + p.ExitCode + ")"));

                if (p.ExitCode == 0)
                {
                    outFile = Path.Combine(Path.GetDirectoryName(fileName), outFile);
                    CompressFile(outFile, features, settings);
                }
            }
            else
            {
                p.Kill();
                EventManager.DispatchEvent(features, new TextEvent(EventType.ProcessEnd, "Done(99): Style compiler not responding."));
            }
        }
    }
}