using System;
using System.Text;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Utilities;
using ProjectManager.Helpers;
using PluginCore.Localization;

namespace ProjectManager.Actions
{
	public class FlashDevelopActions
	{
        static private bool nameAsked;
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

        public static void CheckAuthorName()
        {
            if (nameAsked) return;
            nameAsked = true;
            foreach (Argument arg in PluginBase.Settings.CustomArguments)
            {
                if (arg.Key == "DefaultUser" && arg.Value == "...")
                {
                    String caption = TextHelper.GetString("Title.AuthorName");
                    LineEntryDialog prompt = new LineEntryDialog(caption, "Author", "");
                    if (prompt.ShowDialog() == DialogResult.OK)
                    {
                        arg.Value = prompt.Line;
                    }
                }
            }
        }

    }

}
