using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading;

namespace ProjectManager.Projects.Building
{
	public class ProcessRunner
	{
		public static bool Run(string fileName, string arguments, bool ignoreExitCode)
		{
			//if (!File.Exists(fileName))
			//	throw new FileNotFoundException("The program '"+fileName+"' was not found.",fileName);

			Process process = new Process();
            process.StartInfo.UseShellExecute = false;
			process.StartInfo.RedirectStandardOutput = true;
			process.StartInfo.RedirectStandardError = true;
            process.StartInfo.StandardOutputEncoding = Encoding.Default;
            process.StartInfo.StandardErrorEncoding = Encoding.Default;
            process.StartInfo.CreateNoWindow = true;
			process.StartInfo.FileName = fileName;
			process.StartInfo.Arguments = arguments;
			process.StartInfo.WorkingDirectory = Environment.CurrentDirectory;
			process.Start();

			// capture output in a separate thread
            LineFilter stdoutFilter = new LineFilter(process.StandardOutput, ProjectBuilder.Log);
            LineFilter stderrFilter = new LineFilter(process.StandardError, ProjectBuilder.LogError);

			Thread outThread = new Thread(new ThreadStart(stdoutFilter.Filter));
			Thread errThread = new Thread(new ThreadStart(stderrFilter.Filter));

			outThread.Start();
			errThread.Start();

			process.WaitForExit();

			outThread.Join(1000);
			errThread.Join(1000);
			
			return (ignoreExitCode) ? stderrFilter.Lines == 0 : process.ExitCode == 0;
		}
	}

    delegate void MessageFilterDelegate(string message);

	class LineFilter
	{
		TextReader reader;
        MessageFilterDelegate filter;
		public int Lines;

		public LineFilter(TextReader reader, MessageFilterDelegate filter)
		{
			this.reader = reader;
            this.filter = filter;
		}

		public void Filter()
		{
			while (true)
			{
				string line = reader.ReadLine();
				if (line == null) break;

                filter(line);
				
				if (line.Length > 0) Lines++;
			}
		}
	}
}