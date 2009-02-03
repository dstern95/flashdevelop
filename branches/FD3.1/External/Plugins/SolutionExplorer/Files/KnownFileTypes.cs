using System;
using System.IO;

namespace SolutionExplorer.Files
{
    [Flags]
    enum KnownFileTypes : long
    {
        None = 0,
        ActionScript = 1 << 0,
        FlashCS3 = 1 << 1,
        Haxe = 1 << 2,
        Image = 1 << 3,
        Swf = 1 << 4,
        Swc = 1 << 5,
        Font = 1 << 6,
        Resource = 1 << 7,
        Executable = 1 << 8,
        Html = 1 << 9,
        Xml = 1 << 10,
        Text = 1 << 11,
        AS2Project = 1 << 12,
        AS3Project = 1 << 13,
        FlexBuilderProject = 1 << 14,
        HaxeProject = 1 << 15,
        Project = 1 << 16,
        Mxml = 1 << 17,
        Template = 1 << 18
    }

    static class KnownFileTypesExtensions
    {
        public static KnownFileTypes GetKnownTypes(this FileInfo file)
        {
            KnownFileTypes types = KnownFileTypes.None;

            string ext = file.Extension.ToLower();

            switch (ext)
            {
                case ".as":
                    types |= KnownFileTypes.ActionScript; break;
                case ".mxml":
                    types |= KnownFileTypes.Mxml; break;
                case ".fla":
                    types |= KnownFileTypes.FlashCS3; break;
                case ".hx":
                    types |= KnownFileTypes.Haxe; break;
                case ".png": case ".jpg": case ".jpeg": case ".gif":
                    types |= KnownFileTypes.Image; break;
                case ".swf":
                    types |= KnownFileTypes.Swf; break;
                case ".swc":
                    types |= KnownFileTypes.Swc; break;
                case ".ttf":
                    types |= KnownFileTypes.Font; break;
                case ".html": case ".htm":
                    types |= KnownFileTypes.Html; break;
                case ".xml":
                    types |= KnownFileTypes.Xml; break;
                case ".txt":
                    types |= KnownFileTypes.Text; break;
                case ".fdp": case ".as2proj":
                    types |= KnownFileTypes.AS2Project | KnownFileTypes.Project; break;
                case ".as3proj":
                    types |= KnownFileTypes.AS3Project | KnownFileTypes.Project; break;
                case ".actionScriptProperties":
                    types |= KnownFileTypes.AS3Project | KnownFileTypes.Project
                        | KnownFileTypes.FlexBuilderProject; break;
                case ".hxproj":
                    types |= KnownFileTypes.HaxeProject | KnownFileTypes.Project; break;
                case ".template":
                    types |= KnownFileTypes.Template; break;
            }

            // allow for mxml, sxml, asml, etc
            if (ext.Length == 5 && ext.EndsWith("ml"))
                types |= KnownFileTypes.Xml;

            // allow for unix-style config files
            if (file.Name.StartsWith("."))
                types |= KnownFileTypes.Text;

            return types;
        }

        public static bool IsType(this FileInfo file, KnownFileTypes type)
        {
            return (GetKnownTypes(file) & type) > 0;
        }
    }
}
