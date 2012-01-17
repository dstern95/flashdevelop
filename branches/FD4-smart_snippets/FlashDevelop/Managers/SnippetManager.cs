using System;
using System.IO;
using System.Text;
using System.Drawing;
using WeifenLuo.WinFormsUI;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using PluginCore.Localization;
using FlashDevelop.Utilities;
using FlashDevelop.Helpers;
using PluginCore.Utilities;
using PluginCore.Controls;
using PluginCore.Helpers;
using PluginCore.Managers;
using System.Collections;
using ScintillaNet;
using PluginCore;
using PluginCore.PluginCore;

namespace FlashDevelop.Managers
{
    public class SnippetManager
    {
        /// <summary>
        /// Gets a snippet from a file in the snippets directory
        /// </summary>
        public static String GetSnippet(String word, String syntax, Encoding current)
        {
            String global = Path.Combine(PathHelper.SnippetDir, word + ".fds");
            String specificDir = Path.Combine(PathHelper.SnippetDir, syntax);
            String specific = Path.Combine(specificDir, word + ".fds");
            if (File.Exists(specific))
            {
                EncodingFileInfo info = FileHelper.GetEncodingFileInfo(specific);
                return DataConverter.ChangeEncoding(info.Contents, info.CodePage, current.CodePage);
            }
            else if (File.Exists(global))
            {
                EncodingFileInfo info = FileHelper.GetEncodingFileInfo(global);
                return DataConverter.ChangeEncoding(info.Contents, info.CodePage, current.CodePage);
            }
            else return null;
        }

        /// <summary>
        /// Inserts text from the snippets class
        /// </summary>
        public static Boolean InsertTextByWord(String word, Boolean emptyUndoBuffer)
        {
            ScintillaControl sci = Globals.SciControl;
            if (sci == null) return false;
            Boolean canShowList = false; 
            String snippet = null;
            if (word == null)
            {
                canShowList = true;
                word = sci.GetWordFromPosition(sci.CurrentPos);
            }
            if (word != null && word.Length > 0)
            {
                snippet = GetSnippet(word, sci.ConfigurationLanguage, sci.Encoding);
            }
            // let plugins handle the snippet
            Hashtable data = new Hashtable();
            data["word"] = word;
            data["snippet"] = snippet;
            DataEvent de = new DataEvent(EventType.Command, "SnippetManager.Expand", data);
            EventManager.DispatchEvent(Globals.MainForm, de);
            if (de.Handled) return true;
            snippet = (string)data["snippet"];
            if (!String.IsNullOrEmpty(sci.SelText))
            {
                // Remember the previous selection
                ArgsProcessor.PrevSelText = sci.SelText;
            }
            if (snippet != null)
            {
                Int32 endPos = sci.SelectionEnd;
                Int32 startPos = sci.SelectionStart;
                String curWord = sci.GetWordFromPosition(sci.CurrentPos);
                if (startPos == endPos)
                {
                    endPos = sci.WordEndPosition(sci.CurrentPos, true);
                    startPos = sci.WordStartPosition(sci.CurrentPos, true);
                    sci.SetSel(startPos, endPos);
                }
                int p2 = sci.CurrentPos;
                if (!String.IsNullOrEmpty(curWord))
                {
                    // Remember the current word
                    ArgsProcessor.PrevSelWord = curWord;
                    p2 -= curWord.Length;
                }

                
                sci.BeginUndoAction();
                try
                {
                    InsertSmartSnippetText(sci, sci.CurrentPos, snippet, true);
                }
                finally
                {
                    sci.EndUndoAction();
                }
               
                return true;
            }
            else if (canShowList)
            {
                ICompletionListItem item;
                List<ICompletionListItem> items = new List<ICompletionListItem>();
                PathWalker walker = new PathWalker(PathHelper.SnippetDir, "*.fds", false);
                List<String> files = walker.GetFiles();
                foreach (String file in files)
                {
                    item = new SnippetItem(Path.GetFileNameWithoutExtension(file), file);
                    items.Add(item);
                }
                String path = Path.Combine(PathHelper.SnippetDir, sci.ConfigurationLanguage);
                if (Directory.Exists(path))
                {
                    walker = new PathWalker(path, "*.fds", false);
                    files = walker.GetFiles();
                    foreach (String file in files)
                    {
                        item = new SnippetItem(Path.GetFileNameWithoutExtension(file), file);
                        items.Add(item);
                    }
                }
                if (items.Count > 0)
                {
                    items.Sort();
                    if (!String.IsNullOrEmpty(sci.SelText)) word = sci.SelText;
                    else
                    {
                        word = sci.GetWordFromPosition(sci.CurrentPos);
                        if (word == null) word = String.Empty;
                    }
                    CompletionList.OnInsert += new InsertedTextHandler(HandleListInsert);
                    CompletionList.OnCancel += new InsertedTextHandler(HandleListInsert);
                    CompletionList.Show(items, false, word);
                    return true;
                }
            }
            return false;
        }

        public static int InsertSmartSnippetText(ScintillaControl sci, int position, string snippet, bool useSmartSnippets)
        {
            String curWord = sci.GetWordFromPosition(position);
            int p2 = sci.SelectionStart;

            int len = SnippetHelper.InsertSnippetText(sci, position, snippet);
            sci.CurrentPos = sci.SelectionStart;

            SmartSnippetData snp = new SmartSnippetData();
            snp.DesiredPos = sci.CurrentPos;

            int pos = sci.CurrentPos;
            sci.SetSel(p2, p2 + len);
            string selText = sci.SelText;
            string newText = ReplaceArgsWithSmartSnippets(snp, p2, sci.SelText);
            sci.ReplaceSel(newText);

            snp.PosStart = p2;
            snp.PosEnd = p2 + newText.Length;

            sci.SetSel(pos, pos);
            sci.CurrentPos = pos;

            if (useSmartSnippets)
            {
                if (snp.EntryPointsList.Count > 0)
                {
                    DispatchHighlightSmartSnippet(snp);
                }
            }
            else
            {
                sci.CurrentPos = snp.DesiredPos;
                sci.SetSel(snp.DesiredPos, snp.DesiredPos);
            }

            return len;
        }

        public static void DispatchHighlightSmartSnippet(SmartSnippetData smartSnippetData)
        {
            Hashtable info = new Hashtable();
            info["snippet"] = smartSnippetData;
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.HighlightSmartSnippet", info);
            EventManager.DispatchEvent(Globals.MainForm, de);
        }

        /// <summary>
        /// On completion list insert or cancel, reset the previous selection
        /// </summary>
        private static void HandleListInsert(ScintillaControl sender, Int32 position, String text, Char trigger, ICompletionListItem item)
        {
            CompletionList.OnInsert -= new InsertedTextHandler(HandleListInsert);
            CompletionList.OnCancel -= new InsertedTextHandler(HandleListInsert);
            ArgsProcessor.PrevSelText = String.Empty;
        }

        public static string ReplaceArgsWithSmartSnippets(SmartSnippetData snippet, int pos, string args)
        {
            Regex re = new Regex("\\$\\((var=\"(?<var>(?:[^\"\\\\]|\\\\.)*?)\")?(,id=\"(?<id>(?:[^\"\\\\]|\\\\.)*?)\")?(,list=\"(?<list>(?:[^\"\\\\]|\\\\.)*?)\")?\\)");
            Match m = re.Match(args);
            int shift;
            while (m.Success)
            {
                shift = m.Value.Length - m.Groups["var"].Length;
                if (snippet.DesiredPos > pos + m.Index)
                    snippet.DesiredPos -= shift;

                SmartSnippetItem p = new SmartSnippetItem(pos + m.Index, pos + m.Index + m.Groups["var"].Length, m.Groups["var"].Value);
                if (m.Groups["list"].Success)
                {
                    string[] choices = m.Groups["list"].Value.Split(new char[] { ',' });
                    p.CompletionList = new List<string>(choices);
                }
                if (m.Groups["id"].Success)
                {
                    p.ID = m.Groups["id"].Value;
                }
                else
                {
                    p.ID = m.Groups["var"].Value;
                }
                snippet.EntryPointsList.Add(p);

                args = args.Substring(0, m.Index) + m.Groups["var"].Value.Replace("\\\"", "\"") + args.Substring(m.Index + m.Length);
                m = re.Match(args);
            }

            List<string> unique = new List<string>();
            for (int i = 0; i < snippet.EntryPointsList.Count; i++)
            {
                SmartSnippetItem d = snippet.EntryPointsList[i];
                if (!unique.Contains(d.ID))
                {
                    unique.Add(d.ID);
                    d.ForEdit = true;
                }
            }

            return args;
        }

    }

    public class SnippetItem : ICompletionListItem, IComparable, IComparable<ICompletionListItem>
    {
        private String word;
        private String snippet;
        private String fileName;
        private Bitmap icon;

        public SnippetItem(String word, String fileName)
        {
            this.word = word;
            this.fileName = fileName;
        }

        /// <summary>
        /// Label of the snippet item
        /// </summary>
        public String Label
        {
            get { return this.word; }
        }

        /// <summary>
        /// Description of the snippet item
        /// </summary>
        public String Description
        {
            get
            {
                String desc = TextHelper.GetString("Info.SnippetItemDesc");
                if (this.snippet == null)
                {
                    this.snippet = FileHelper.ReadFile(this.fileName);
                    this.snippet = ArgsProcessor.ProcessCodeStyleLineBreaks(this.snippet);
                    this.snippet = this.snippet.Replace(SnippetHelper.ENTRYPOINT, "|");
                    this.snippet = this.snippet.Replace(SnippetHelper.EXITPOINT, "|");
                }
                if (this.snippet.Length > 40) return desc + ": " + this.snippet.Substring(0, 40) + "...";
                else return desc + ": " + this.snippet;
            }
        }

        /// <summary>
        /// String value if the snippet item
        /// </summary>
        public String Value
        {
            get
            {
                SnippetManager.InsertTextByWord(this.word, false);
                return null;
            }
        }

        /// <summary>
        /// Icon if the snippet item
        /// </summary>
        public Bitmap Icon
        {
            get 
            {
                if (icon == null)
                {
                    Image image = Globals.MainForm.FindImage("341");
                    this.icon = new Bitmap(image);
                }
                return icon;
            }
            set 
            {
                this.icon = value;
            }
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

    }

}
