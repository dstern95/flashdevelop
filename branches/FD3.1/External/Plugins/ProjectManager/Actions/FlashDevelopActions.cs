using System;
using System.Text;
using PluginCore;
using PluginCore.Utilities;

namespace ProjectManager.Actions
{
	public class FlashDevelopActions
	{
        private IMainForm mainForm;

		public FlashDevelopActions(IMainForm mainForm)
		{
			this.mainForm = mainForm;
		}
		
		public Encoding GetDefaultEncoding()
		{
            return Encoding.GetEncoding((Int32)mainForm.Settings.DefaultCodePage);
		}

		public string GetDefaultEOLMarker()
		{
            return LineEndDetector.GetNewLineMarker((Int32)mainForm.Settings.EOLMode);
		}
	}
}
