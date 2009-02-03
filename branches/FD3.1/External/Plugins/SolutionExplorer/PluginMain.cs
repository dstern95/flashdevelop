using System;
using System.Collections.Generic;
using System.Text;
using PluginCore;
using System.ComponentModel;

namespace SolutionExplorer
{
    public class PluginMain : IPlugin
    {
        public string Name { get { return "SolutionExplorer"; } }
        public string Guid { get { return "44FF5045-089F-4ab5-AC1F-5965C305C89D"; } }
        public string Help { get { return "http:/www.flashdevelop.org"; } }
        public string Author { get { return "FlashDevelop Team"; } }
        public string Description { get { return "Adds solution/project management and building."; } }

        public static Settings Settings { get; private set; }

        [Browsable(false)] // explicit implementation so we can reuse the "Settings" var name
        object IPlugin.Settings { get { return Settings; } }

        public void Initialize()
        {
        }

        public void Dispose()
        {
        }

        public void HandleEvent(object sender, NotifyEvent e, HandlingPriority priority)
        {
        }
    }
}
