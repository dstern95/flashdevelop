using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.PluginCore;
using PluginCore;
using System.Drawing;
using PluginCore.Controls;
using PluginCore.FRService;
using ASCompletion.Context;
using PluginCore.Localization;

namespace ASCompletion.Completion
{
    class SmartSnippetsUtils
    {
        
        public static bool CheckSmartSnippetsDamaged(ScintillaNet.ScintillaControl sci, int position, int length, int linesAdded, SmartSnippetData smartSnippetData)
        {
            bool insideSnippet = false;
            
            for (int i = 0; i < smartSnippetData.EntryPointsList.Count; i++)
            {
                SmartSnippetItem p = smartSnippetData.EntryPointsList[i];

                if (length < 0)
                {
                    if (p.PrevStart < position - length && p.Start <= position
                                && p.PrevEnd >= position - length && p.End >= position)
                    {
                        if (p.PrevStart != p.PrevEnd)
                        {
                            insideSnippet = true;
                        }
                    }
                }
                else
                {
                    if (p.End >= position && p.Start <= position)
                    {
                        insideSnippet = true;
                    }
                }
                
            }

            return !insideSnippet;
        }

        public static void UpdateSmartSnippetsValues(ScintillaNet.ScintillaControl sci, SmartSnippetData smartSnippetData)
        {
            int pos = sci.CurrentPos;

            SmartSnippetItem currentSnippet = null;
            for (int i = 0; i < smartSnippetData.EntryPointsList.Count; i++)
            {
                SmartSnippetItem p = smartSnippetData.EntryPointsList[i];
                if (p.Start <= pos && p.End >= pos)
                    currentSnippet = p;
            }

            if (currentSnippet == null)
                return;

            sci.SetSel(currentSnippet.Start, currentSnippet.End);
            string word = sci.SelText;
            sci.SetSel(pos, pos);
            sci.CurrentPos = pos;
            if (word == null)
                word = "";

            int newPos = sci.CurrentPos;
            for (int i = 0; i < smartSnippetData.EntryPointsList.Count; i++)
            {
                SmartSnippetItem p = smartSnippetData.EntryPointsList[i];
                if (p != currentSnippet && p.ID == currentSnippet.ID)
                {
                    sci.SetSel(p.Start, p.End);
                    string w = sci.SelText;
                    int diff = word.Length - w.Length;
                    if (newPos > p.Start)
                        newPos += diff;
                    if (w != word)
                    {
                        sci.ReplaceSel(word);
                    }
                }
            }
            sci.SetSel(newPos, newPos);
            sci.CurrentPos = newPos;
        }

        public static void ShiftToNextSmartSnippet(ScintillaNet.ScintillaControl sci, SmartSnippetData snippet, bool startOver)
        {
            CompletionList.Hide();

            if (startOver)
            {
                snippet.Index = 0;
            }
            else
            {
                int prevIndex = snippet.Index;
                int currIndex = snippet.Index;
                currIndex++;
                if (currIndex >= snippet.EntryPointsList.Count)
                {
                    currIndex = 0;
                }
                for (int i = currIndex; i < currIndex + snippet.EntryPointsList.Count; i++)
                {
                    int j = i % snippet.EntryPointsList.Count;
                    if (snippet.EntryPointsList[j].ForEdit)
                    {
                        snippet.Index = j;
                        break;
                    }
                }
            }
            SmartSnippetItem item = snippet.EntryPointsList[snippet.Index];
            sci.SetSel(item.Start, item.End);

            if (item.CompletionList != null)
            {
                List<ICompletionListItem> compList = new List<ICompletionListItem>();
                for (int i = 0; i < item.CompletionList.Count; i++)
                {
                    compList.Add(new SmartSnippetCompletionItem(item.CompletionList[i], item.CompletionList[i], item.CompletionList[i]));
                }

                CompletionList.Show(compList, false, sci.SelText);
            }
        }

        public static void RemoveHighlightSmartSnippets(ScintillaNet.ScintillaControl sci)
        {
            sci.RemoveHighlights();
        }

        public static void HighlightSmartSnippets(ScintillaNet.ScintillaControl sci, SmartSnippetData snippet)
        {
            RemoveHighlightSmartSnippets(sci);
            List<SearchMatch> matches = new List<SearchMatch>();
            for (int i = 0; i < snippet.EntryPointsList.Count; i++)
            {
                SmartSnippetItem p = snippet.EntryPointsList[i];

                SearchMatch srch = new SearchMatch();
                srch.Index = p.Start;
                srch.Length = Math.Max(p.End - p.Start, 1);
                matches.Add(srch);
            }

            foreach (SearchMatch match in matches)
            {
                Int32 mask = 1 << sci.StyleBits;
                sci.SetIndicStyle(0, (int)ScintillaNet.Enums.IndicatorStyle.Box);
                sci.SetIndicFore(0, 0xAFAFAF);
                sci.StartStyling(match.Index, mask);
                sci.SetStyling(match.Length, mask);
                sci.StartStyling(sci.EndStyled, mask - 1);
            }
        }

        public static void UpdateSmartSnippetsPositions(ScintillaNet.ScintillaControl sci, int position, int length, SmartSnippetData smartSnippetData)
        {
            for (int i = 0; i < smartSnippetData.EntryPointsList.Count; i++)
            {
                SmartSnippetItem p = smartSnippetData.EntryPointsList[i];
                p.PrevEnd = p.End;
                p.PrevStart = p.Start;

                if (p.Start > position)
                {
                    p.Start += length;
                }
                    

                if (length > 0)
                {
                    if (p.End >= position)
                        p.End += length;
                }
                else
                {
                    if (p.End > position)
                        p.End += length;
                }
            }

            if (smartSnippetData.DesiredPos > position)
                smartSnippetData.DesiredPos = smartSnippetData.DesiredPos + length;

            if (smartSnippetData.PosStart > position)
                smartSnippetData.PosStart += length;

            if (length > 0)
            {
                if (smartSnippetData.PosEnd >= position)
                    smartSnippetData.PosEnd += length;
            }
            else
            {
                if (smartSnippetData.PosEnd > position)
                    smartSnippetData.PosEnd += length;
            }
        }
    }

    class SmartSnippetCompletionItem : ICompletionListItem, IComparable, IComparable<ICompletionListItem>
    {
        private string label;
        private string value;
        private string desciption;

        public SmartSnippetCompletionItem(string label, string value, string desc)
        {
            this.label = label;
            this.value = value;
            this.desciption = desc;
        }

        #region ICompletionListItem Members

        public string Label
        {
            get { return label; }
        }

        public string Value
        {
            get { return value; }
        }

        public string Description
        {
            get { return desciption; }
        }

        public Bitmap Icon
        {
            get { return (System.Drawing.Bitmap)ASContext.Panel.GetIcon(PluginUI.ICON_TEMPLATE); }
        }

        /// <summary>
        /// Checks the validity of the completion list item 
        /// </summary> 
        Int32 IComparable.CompareTo(Object obj)
        {
            if (obj as ICompletionListItem != null) return String.Compare(Label, (obj as ICompletionListItem).Label, true);
            else
            {
                String message = TextHelper.GetString("Info.CompareError");
                throw new Exception(message);
            }
        }

        /// <summary>
        /// Compares the completion list items
        /// </summary> 
        Int32 IComparable<ICompletionListItem>.CompareTo(ICompletionListItem other)
        {
            return String.Compare(Label, other.Label, true);
        }

        #endregion
    }
}