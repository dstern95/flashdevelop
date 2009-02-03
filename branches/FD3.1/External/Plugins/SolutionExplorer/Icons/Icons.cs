using System.Collections.Generic;
using System.Drawing;
using System.Reflection;
using System.Windows.Forms;
using PluginCore;
using PluginCore.Utilities;

namespace SolutionExplorer.Graphics
{
    public class FDImage
    {
        public Image Img { get; private set; }
        public int Index { get; private set; }

        public FDImage(Image img, int index)
        {
            Img = img;
            Index = index;
        }

        public Icon Icon { get { return Icon.FromHandle((Img as Bitmap).GetHicon()); } }
    }

	/// <summary>
	/// Contains all icons used by the Solution Explorer
	/// </summary>
	public class Icons
	{
        // store all extension icons we've pulled from the file system
        static Dictionary<string, FDImage> extensionIcons;

        public static ImageList ImageList { get; private set; }

        public static readonly FDImage BulletAdd, SilkPage, XmlFile, MxmlFile, MxmlFileCompile, 
            HiddenItems, HiddenFolder, HiddenFile, BlankFile, Solution, Project, Classpath,
            Font, ImageResource, ActionScript, FlashCS3, HaxeFile, SwfFile, SwfFileHidden, SwcFile,
            Folder, FolderCompile, TextFile, ActionScriptCompile, HtmlFile, AddFile, OpenFile,
            EditFile, Cut, Copy, Paste, Delete, Options, NewProject, GreenCheck, Gear, Class, Refresh,
            Debug, UpArrow, DownArrow, AllClasses;

        static Icons()
        {
            extensionIcons = new Dictionary<string, FDImage>();

            ImageList = new ImageList();
            ImageList.ColorDepth = ColorDepth.Depth32Bit;
            ImageList.ImageSize = new Size(16, 16);
            ImageList.TransparentColor = Color.Transparent;

            BulletAdd = Get(0);
            SilkPage = GetResource("Graphics.SilkPage.png");
            XmlFile = GetResource("Graphics.XmlFile.png");
            MxmlFile = GetResource("Graphics.MxmlFile.png");
            MxmlFileCompile = GetResource("Graphics.MxmlFileCompile.png");
            HiddenItems = GetResource("Graphics.HiddenItems.png");
            HiddenFolder = GetGray("203");
            HiddenFile = GetResource("Graphics.HiddenFile.png");
            BlankFile = GetResource("Graphics.BlankPage.png");
            Solution = GetResource("Graphics.Solution.png");
            Project = Get(274);
            Classpath = Get(98);
            Font = Get(408);
            ImageResource = Get(336);
            ActionScript = GetResource("Graphics.ActionscriptFile.png");
            HaxeFile = GetResource("Graphics.HaxeFile.png");
            SwfFile = GetResource("Graphics.SwfMovie.png");
            SwfFileHidden = GetResource("Graphics.SwfMovieHidden.png");
            SwcFile = GetResource("Graphics.SwcFile.png");
            Folder = Get(203);
            FolderCompile = Get("203|22|-3|3");
            TextFile = Get(315);
            FlashCS3 = GetResource("Graphics.FlashCS3.png");
            ActionScriptCompile = GetResource("Graphics.ActionscriptCompile.png");
            HtmlFile = GetResource("Graphics.HtmlFile.png");
            AddFile = GetResource("Graphics.AddFile.png"); //Get("304|0|5|4");
            OpenFile = Get(214);
            EditFile = Get(282);
            Cut = Get(158);
            Copy = Get(292);
            Paste = Get(283);
            Delete = Get(111);
            Options = Get(54);
            NewProject = Get("274|0|5|4");
            GreenCheck = Get(351);
            Gear = Get(127);
            Class = GetResource("Graphics.Class.png");
            Refresh = Get(66);
            Debug = Get(101);
            UpArrow = Get(74);
            DownArrow = Get(60);
            AllClasses = Get(202);
        }

        static FDImage Get(int fdIndex)
        {
            return MakeFDImage(PluginBase.MainForm.FindImage(fdIndex.ToString()));
        }

        static FDImage GetResource(string resourceID)
        {
            resourceID = "SolutionExplorer." + resourceID;
            Assembly assembly = Assembly.GetExecutingAssembly();
            return MakeFDImage(new Bitmap(assembly.GetManifestResourceStream(resourceID)));
        }

        static FDImage GetGray(string data)
        {
            Image image = PluginBase.MainForm.FindImage(data);
            Image converted = ImageKonverter.ImageToGrayscale(image);
            return MakeFDImage(converted);
        }

        static FDImage Get(string data)
		{
            return MakeFDImage(PluginBase.MainForm.FindImage(data));
		}

        static FDImage MakeFDImage(Image image)
        {
            ImageList.Images.Add(image);
            return new FDImage(image, ImageList.Images.Count - 1);
        }

        /*static FDImage GetImageForFile(string file)
        {
            if (file == null || file == string.Empty)
                return Graphics.BlankFile;
            if (FileInspector.IsActionScript(file))
                return Graphics.ActionScript;
            else if (FileInspector.IsHaxeFile(file))
                return Graphics.HaxeFile;
            else if (FileInspector.IsMxml(file))
                return Graphics.MxmlFile;
            else if (FileInspector.IsFont(file))
                return Graphics.Font;
            else if (FileInspector.IsImage(file))
                return Graphics.ImageResource;
            else if (FileInspector.IsSwf(file))
                return Graphics.SwfFile;
            else if (FileInspector.IsSwc(file))
                return Graphics.SwcFile;
            else if (FileInspector.IsHtml(file))
                return Graphics.HtmlFile;
            else if (FileInspector.IsXml(file))
                return Graphics.XmlFile;
            else if (FileInspector.IsText(file))
                return Graphics.TextFile;
            else if (FileInspector.IsFlashCS3(file))
                return Graphics.FlashCS3;
            else
                return ExtractIconIfNecessary(file);
        }

        public static FDImage ExtractIconIfNecessary(string file)
        {
            string extension = Path.GetExtension(file);
            if (extensionGraphics.ContainsKey(extension))
            {
                return extensionIcons[extension];
            }
            else
            {
                Icon icon = IconExtractor.GetIcon(file, true);
                imageList.Images.Add(icon);
                int index = imageList.Images.Count - 1; // of the icon we just added
                FDImage fdImage = new FDImage(icon.ToBitmap(), index);
                extensionGraphics.Add(extension, fdImage);
                return fdImage;
            }
        }

        public static Image Overlay(Image image, Image overlay, int x, int y)
        {
            Bitmap composed = image.Clone() as Bitmap;
            using (Graphics destination = Graphics.FromImage(composed))
            {
                destination.DrawImage(overlay, new Rectangle(x, y, 16, 16), 
                    new Rectangle(0, 0, 16, 16), GraphicsUnit.Pixel);
            }

            return composed;
        }*/
	}
}
