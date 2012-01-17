using System;
using System.IO;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using ASCompletion.Model;
using PluginCore.Helpers;
using PluginCore.Utilities;
using PluginCore;
using ASCompletion.Context;

namespace ASCompletion.Completion
{
    public class TemplateUtils
    {
        public static string boundaries_folder = "boundaries";
        public static string generators_folder = "generators";
        public static string template_variable = @"<<[^\$]*?\$\({0}\).*?>>";

        public static string GetStaticExtern(MemberModel member)
        {
            FlagType ft = member.Flags;
            string modifiers = "";
            if ((ft & FlagType.Extern) > 0)
                modifiers += "extern ";
            if ((ft & FlagType.Static) > 0)
                modifiers += "static ";
            return modifiers;
        }

        public static string GetOverride(MemberModel member)
        {
            FlagType ft = member.Flags;
            string modifiers = "";
            if ((ft & FlagType.Override) > 0)
                modifiers += "override ";
            return modifiers;
        }

        public static string GetStaticExternModifiers(MemberModel m, bool addModifiers)
        {
            return GetStaticExternModifiers(m, addModifiers, true);
        }

        public static string GetStaticExternModifiers(MemberModel m, bool addModifiers, bool useSmartSnippets)
        {
            string methodModifiers = "";
            if (ASContext.CommonSettings.StartWithModifiers)
                methodModifiers = ((addModifiers ? GetModifiers(m, useSmartSnippets) + " " : "") + GetStaticExtern(m)).Trim();
            else
                methodModifiers = (GetStaticExtern(m) + (addModifiers ? GetModifiers(m, useSmartSnippets) : "")).Trim();
            return methodModifiers;
        }

        public static string GetStaticExternOverrideModifiers(MemberModel m, bool addModifiers)
        {
            return GetStaticExternOverrideModifiers(m, addModifiers, true);
        }

        public static string GetStaticExternOverrideModifiers(MemberModel m, bool addModifiers, bool useSmartSnippets)
        {
            string methodModifiers = "";
            if (ASContext.CommonSettings.StartWithModifiers)
                methodModifiers = (GetOverride(m) + (addModifiers ? GetModifiers(m, useSmartSnippets) + " " : "") + GetStaticExtern(m)).Trim();
            else
                methodModifiers = (GetOverride(m) + GetStaticExtern(m) + (addModifiers ? GetModifiers(m, useSmartSnippets) : "")).Trim();
            return methodModifiers;
        }

        public static string GetModifiers(MemberModel member)
        {
            return GetModifiers(member, true);
        }

        public static string GetModifiers(MemberModel member, bool useSmartSnippets)
        {
            string modifiers = "";
            Visibility acc = member.Access;
            if ((acc & Visibility.Private) > 0)
                modifiers += "private";
            else if ((acc & Visibility.Public) > 0)
                modifiers += "public";
            else if ((acc & Visibility.Protected) > 0)
                modifiers += "protected";
            else if ((acc & Visibility.Internal) > 0)
                modifiers += "internal";

            if (useSmartSnippets)
            {
                modifiers = CreateSmartSnippet(modifiers, "modifiers", "private,protected,internal,public");
            }
            return modifiers;
        }

        public static string ToDeclarationWithModifiersString(MemberModel m, string template)
        {
            return ToDeclarationWithModifiersString(m, template, true);
        }

        public static string ToDeclarationWithModifiersString(MemberModel m, string template, bool useSmartSnippets)
        {
            bool isConstructor = (m.Flags & FlagType.Constructor) > 0;

            string methodModifiers;
            if (isConstructor)
            {
                methodModifiers = GetModifiers(m, useSmartSnippets).Trim();
            }
            else
            {
                methodModifiers = GetStaticExternOverrideModifiers(m, true, useSmartSnippets);
            }

            // Insert Modifiers (private, static, etc)
            string res = ReplaceTemplateVariable(template, "Modifiers", methodModifiers);

            // Insert Declaration
            res = ToDeclarationString(m, res, useSmartSnippets);

            return res;
        }

        public static string ToDeclarationString(MemberModel m, string template)
        {
            return ToDeclarationString(m, template, true);
        }

        public static string ToDeclarationString(MemberModel m, string template, bool useSmartSnippets)
        {
            // Insert Name
            if (m.Name != null)
                template = ReplaceTemplateVariable(template, "Name",
                    (useSmartSnippets ? CreateSmartSnippet(m.Name, "name") : m.Name));
            else
                template = ReplaceTemplateVariable(template, "Name", null);

            // If method, insert arguments
            template = ReplaceTemplateVariable(template, "Arguments", ParametersString(m, true, useSmartSnippets));

            if (m.Type != null && m.Type.Length > 0)
            {
                if ((m.Flags & FlagType.Setter) > 0 && m.Parameters != null && m.Parameters.Count == 1)
                    template = ReplaceTemplateVariable(template, "Type",
                        (useSmartSnippets ? CreateSmartSnippet(FormatType(m.Parameters[0].Type), "type") : FormatType(m.Parameters[0].Type)));
                else
                    template = ReplaceTemplateVariable(template, "Type",
                        (useSmartSnippets ? CreateSmartSnippet(FormatType(m.Type), "type") : FormatType(m.Type)));
            }
            else
                template = ReplaceTemplateVariable(template, "Type", null);

            if (m.Value != null)
                template = ReplaceTemplateVariable(template, "Value",
                    (useSmartSnippets ? CreateSmartSnippet(m.Value, "value") : m.Value));
            else
                template = ReplaceTemplateVariable(template, "Value", null);

            return template;
        }

        public static string CreateSmartSnippet(string snippetContent, string snippetID)
        {
            return CreateSmartSnippet(snippetContent, snippetID, null);
        }

        public static string CreateSmartSnippet(string snippetContent, string snippetID, string options)
        {
            snippetContent = snippetContent.Replace("\"", "\\\"");
            if (options == null)
                options = "";
            else
                options = ",list=\"" + options + "\"";
            return String.Format("$(var=\"{0}\",id=\"{1}\"{2})", snippetContent, snippetID, options);
        }

        public static string ParametersString(MemberModel member, bool formated)
        {
            return ParametersString(member, formated, true);
        }

        public static string ParametersString(MemberModel member, bool formated, bool useSmartSnippets)
        {
            string template = GetTemplate("FunctionParameter");
            string res = "";
            if (member.Parameters != null && member.Parameters.Count > 0)
            {
                for (int i = 0; i < member.Parameters.Count; i++)
                {
                    MemberModel param = member.Parameters[i];
                    string one = template;

                    if (i + 1 < member.Parameters.Count)
                        one = ReplaceTemplateVariable(one, "PComma", ",");
                    else
                        one = ReplaceTemplateVariable(one, "PComma", null);

                    one = ReplaceTemplateVariable(one, "PName",
                        (useSmartSnippets ? CreateSmartSnippet(param.Name, "param_name" + i) : param.Name));

                    if (param.Type != null && param.Type.Length > 0)
                        one = ReplaceTemplateVariable(one, "PType",
                            (useSmartSnippets ? CreateSmartSnippet(formated ? FormatType(param.Type) : param.Type, "param_type" + i) : (formated ? FormatType(param.Type) : param.Type)));
                    else
                        one = ReplaceTemplateVariable(one, "PType", null);

                    if (param.Value != null)
                        one = ReplaceTemplateVariable(one, "PDefaultValue",
                            (useSmartSnippets ? CreateSmartSnippet(param.Value.Trim(), "param_value" + i) : param.Value.Trim()));
                    else
                        one = ReplaceTemplateVariable(one, "PDefaultValue", null);

                    res += one;
                }
            }
            else
            {
                res = useSmartSnippets ? CreateSmartSnippet("", "Arguments") : "";
            }
            return res;
        }

        public static string CallParametersString(MemberModel member)
        {
            return CallParametersString(member, true);
        }

        public static string CallParametersString(MemberModel member, bool useSmartSnippets)
        {
            string template = GetTemplate("FunctionParameter");
            string res = "";
            if (member.Parameters != null && member.Parameters.Count > 0)
            {
                for (int i = 0; i < member.Parameters.Count; i++)
                {
                    MemberModel param = member.Parameters[i];
                    string one = template;

                    if (i + 1 < member.Parameters.Count)
                        one = ReplaceTemplateVariable(one, "PComma", ",");
                    else
                        one = ReplaceTemplateVariable(one, "PComma", null);

                    one = ReplaceTemplateVariable(one, "PName",
                        (useSmartSnippets ? CreateSmartSnippet(param.Name, "param_name" + i) : param.Name));

                    one = ReplaceTemplateVariable(one, "PType", null);
                    one = ReplaceTemplateVariable(one, "PDefaultValue", null);

                    res += one;
                }
            }
            return res;
        }

        public static string ReplaceTemplateVariable(string template, string var, string replace)
        {
            Match m = Regex.Match(template, String.Format(template_variable, var));
            if (m.Success)
            {
                if (replace == null)
                {
                    template = template.Substring(0, m.Index) + template.Substring(m.Index + m.Length);
                    return template;
                }
                else
                {
                    string val = m.Value;
                    val = val.Substring(2, val.Length - 4);
                    template = template.Substring(0, m.Index) + val + template.Substring(m.Index + m.Length);
                }
            }
            template = template.Replace("$(" + var + ")", replace);
            return template;
        }

        private static string FormatType(string type)
        {
            return MemberModel.FormatType(type);
        }

        public static MemberModel GetTemplateBlockMember(ScintillaNet.ScintillaControl Sci, string blockTmpl)
        {
            blockTmpl = blockTmpl.Replace("\n", LineEndDetector.GetNewLineMarker(Sci.EOLMode));
            int lineNum = 0;
            while (lineNum < Sci.LineCount)
            {
                string line = Sci.GetLine(lineNum);
                int funcBlockIndex = line.IndexOf(blockTmpl);
                if (funcBlockIndex != -1)
                {
                    MemberModel latest = new MemberModel();
                    latest.LineFrom = lineNum;
                    latest.LineTo = lineNum;
                    return latest;
                }
                lineNum++;
            }
            return null;
        }

        /// <summary>
        /// Templates are stored in the plugin's Data folder
        /// </summary>
        public static string GetTemplate(string name, string altName)
        {
            string tmp = GetTemplate(name);
            if (tmp == "") return GetTemplate(altName);
            else return tmp;
        }

        /// <summary>
        /// Templates are stored in the plugin's Data folder
        /// </summary>
        public static string GetTemplate(string name)
        {
            string lang = PluginBase.MainForm.CurrentDocument.SciControl.ConfigurationLanguage.ToLower();
            string path = Path.Combine(PathHelper.SnippetDir, lang);
            path = Path.Combine(path, generators_folder);
            path = Path.Combine(path, name + ".fds");
            if (!File.Exists(path)) return "";

            Stream src = File.OpenRead(path);
            if (src == null) return "";

            String content;
            using (StreamReader sr = new StreamReader(src))
            {
                content = sr.ReadToEnd();
                sr.Close();
            }
            return "$(Boundary)" + content + "$(Boundary)";
        }

        public static string GetBoundary(string name)
        {
            string lang = PluginBase.MainForm.CurrentDocument.SciControl.ConfigurationLanguage.ToLower();
            string path = Path.Combine(PathHelper.SnippetDir, lang);
            path = Path.Combine(path, boundaries_folder);
            path = Path.Combine(path, name + ".fds");
            if (!File.Exists(path)) return "";

            Stream src = File.OpenRead(path);
            if (src == null) return "";

            String content;
            using (StreamReader sr = new StreamReader(src))
            {
                content = sr.ReadToEnd();
                sr.Close();
            }
            return content;
        }
    }
}
