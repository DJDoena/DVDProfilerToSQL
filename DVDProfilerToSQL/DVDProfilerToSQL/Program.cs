using System;
using System.IO;
using System.Reflection;
using System.Windows.Forms;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    public static class Program
    {
        private static readonly WindowHandle _windowHandle;

        static Program()
        {
            _windowHandle = new WindowHandle();
        }

        [STAThread]
        static void Main(string[] args)
        {
            try
            {
                string errorFile = Path.Combine(Environment.CurrentDirectory, "error.xml");

                if (File.Exists(errorFile))
                {
                    File.Delete(errorFile);
                }
            }
            catch
            {
            }

            if (args?.Length > 0)
            {
                bool found = false;

                for (int i = 0; i < args.Length; i++)
                {
                    if (args[i] == "/skipversioncheck")
                    {
                        break;
                    }
                }

                if (found == false)
                {
                    CheckForNewVersion();
                }
            }

            Process();
        }

        private static void Process()
        {
            //Phase 1: Ask For File Locations
            Console.WriteLine("Welcome to the DVDProfiler to MS SQL Transformer!");
            Console.WriteLine("Version: " + Assembly.GetExecutingAssembly().GetName().Version.ToString());
            Console.WriteLine();
            Console.WriteLine("Please select a \"collection.xml\" and a target location for the Access database!");
            Console.WriteLine("(You should see a file dialog. If not, please minimize your other programs.)");

            using (OpenFileDialog ofd = new OpenFileDialog())
            {
                ofd.Filter = "Collection.xml|*.xml";
                ofd.CheckFileExists = true;
                ofd.Multiselect = false;
                ofd.Title = "Select Source File";
                ofd.RestoreDirectory = true;

                if (ofd.ShowDialog(_windowHandle) == DialogResult.Cancel)
                {
                    Console.WriteLine();
                    Console.WriteLine("Aborted.");
                }
                else
                {
                    Process(ofd.FileName);
                }
            }

            Console.WriteLine();
            Console.WriteLine("Press <Enter> to exit.");
            Console.ReadLine();
        }

        private static void Process(string sourceFile)
        {
            using (SaveFileDialog sfd = new SaveFileDialog())
            {
                var fi = new FileInfo(sourceFile);

                sfd.InitialDirectory = fi.DirectoryName;
                sfd.FileName = fi.Name.Replace(fi.Extension, ".mdf");
                sfd.Filter = "SQL Database|*.mdf";
                sfd.Title = "Select Target File";
                sfd.RestoreDirectory = true;

                if (sfd.ShowDialog(_windowHandle) == DialogResult.Cancel)
                {
                    Console.WriteLine();
                    Console.WriteLine("Aborted.");
                }
                else
                {
                    string originalDatabase = Path.Combine(Environment.CurrentDirectory, "Collection.mdf");

                    if (sfd.FileName == originalDatabase)
                    {
                        Console.WriteLine();
                        Console.WriteLine("Error: You cannot overwrite default database. Abort.");
                    }
                    else
                    {
                        Process(sourceFile, sfd.FileName);
                    }
                }
            }
        }

        private static void Process(string sourceFile
           , string targetFile)
        {
            DateTime start = DateTime.Now;

            //Phase 2: Fill Hashtables
            Console.WriteLine();
            Console.WriteLine("Transforming data:");

            var entityProcessor = new EntityProcessor();

            entityProcessor.ProgressMaxChanged += OnProgressMaxChanged;
            entityProcessor.ProgressValueChanged += OnProgressValueChanged;
            entityProcessor.Feedback += OnFeedback;

            entityProcessor.Process(sourceFile, targetFile);

            entityProcessor.Feedback -= OnFeedback;
            entityProcessor.ProgressValueChanged -= OnProgressValueChanged;
            entityProcessor.ProgressMaxChanged -= OnProgressMaxChanged;

            DateTime end = DateTime.Now;

            TimeSpan elapsed = new TimeSpan(end.Ticks - start.Ticks);

            Console.WriteLine();
            Console.WriteLine($"Time elapsed: {elapsed.Minutes}m {elapsed.Seconds}s");
        }

        static void OnProgressMaxChanged(object sender, EventArgs<int> e)
        {
            if (e.Value == 0)
            {
                Console.WriteLine();
            }
        }

        static void OnFeedback(object sender, EventArgs<string> e)
        {
            Console.WriteLine(e.Value);
        }

        static void OnProgressValueChanged(object sender, EventArgs<int> e)
        {
            int progress = e.Value;

            if (progress > 0)
            {
                if ((progress % 1000) == 0)
                {
                    Console.Write("-");
                }
                else if ((progress % 500) == 0)
                {
                    Console.Write("|");
                }
            }
            else
            {
                Console.Write("+");
            }
        }

        private static void CheckForNewVersion()
        {
            OnlineAccess.Init("Doena Soft.", "DVD Profiler to SQL");
            OnlineAccess.CheckForNewVersion("http://doena-soft.de/dvdprofiler/3.9.0/versions.xml", null, "DVDProfilerToSQL", typeof(Program).Assembly);
        }
    }
}
