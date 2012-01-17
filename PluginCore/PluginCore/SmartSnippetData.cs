using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;

namespace PluginCore.PluginCore
{
    public class SmartSnippetData
    {
        public List<SmartSnippetItem> EntryPointsList = new List<SmartSnippetItem>();
        public Int32 Index = 0;
        public Int32 DesiredPos = 0;
        public Int32 PosStart = 0;
        public Int32 PosEnd = 0;
    }

    public class SmartSnippetItem
    {
        public int PrevEnd;
        public int PrevStart;
        public bool ForEdit;
        public int Start;
        public int End;
        public string Variable;
        public string ID;
        public List<string> CompletionList;

        public SmartSnippetItem(int x, int y, string variable)
        {
            this.PrevStart = x;
            this.Start = x;
            this.End = y;
            this.PrevEnd = y;
            this.Variable = variable;
        }
    }
}
