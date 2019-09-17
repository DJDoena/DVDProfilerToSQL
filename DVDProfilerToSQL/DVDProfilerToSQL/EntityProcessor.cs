using System;
using System.Data.Entity;
using System.Globalization;
using System.IO;
using System.Linq;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;
using DoenaSoft.DVDProfiler.SQLDatabase;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EntityProcessor : IProgressReporter
    {
        private const string DVDProfilerSchemaVersion = "4.0.0.0";

        private CollectionEntities _context;

        static EntityProcessor()
        {
            FormatInfo = CultureInfo.GetCultureInfo("en-US").NumberFormat;
        }

        internal static NumberFormatInfo FormatInfo { get; }

        public event EventHandler<EventArgs<int>> ProgressMaxChanged;

        public event EventHandler<EventArgs<int>> ProgressValueChanged;

        public event EventHandler<EventArgs<string>> Feedback;

        internal ExceptionXml Process(string collectionFile, string mdfTargetFile)
        {
            ExceptionXml exceptionXml = null;

            DbContextTransaction transaction = null;

            try
            {
                CopyDatabaseFiles(mdfTargetFile);

                var collection = DVDProfilerSerializer<Collection>.Deserialize(collectionFile);

                //Phase 2: Fill Hashtables
                var cache = new CollectionCache(collection);

                //                       "metadata=res://*/CollectionModel.csdl|res://*/CollectionModel.ssdl|res://*/CollectionModel.msl;provider=System.Data.SqlClient;provider connection string='data source=(LocalDB)\MSSQLLocalDB;attachdbfilename=|DataDirectory|\Collection.mdf;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework'"
                var connectionString = $@"metadata=res://*/CollectionModel.csdl|res://*/CollectionModel.ssdl|res://*/CollectionModel.msl;provider=System.Data.SqlClient;provider connection string='data source=(LocalDB)\MSSQLLocalDB;attachdbfilename={mdfTargetFile};integrated security=True;MultipleActiveResultSets=True;App=EntityFramework;';";

                using (_context = new CollectionEntities(connectionString))
                {
                    _context.Database.Log = Console.WriteLine;

                    _context.Configuration.AutoDetectChangesEnabled = false;

                    using (transaction = _context.Database.BeginTransaction())
                    {
                        CheckDbVersion();

                        //Phase 3: Fill Basic Data Into Database
                        var baseData = InsertBaseData(cache);

                        //Phase 4: Fill DVDs into Database
                        InsertData(collection, baseData);

                        //Phase 5: Save & Exit
                        _context.ChangeTracker.DetectChanges();
                        _context.SaveChanges();

                        transaction.Commit();
                    }
                }

                Feedback?.Invoke(this, new EventArgs<string>($"{(collection.DVDList?.Length ?? 0):#,##0} profiles transformed."));
            }
            catch (Exception exception)
            {
                try
                {
                    transaction.Rollback();
                }
                catch
                {
                }

                try
                {
                    if (File.Exists(mdfTargetFile))
                    {
                        File.Delete(mdfTargetFile);
                    }
                }
                catch
                {
                }

                Feedback?.Invoke(this, new EventArgs<string>($"Error: {exception.Message} "));

                exceptionXml = new ExceptionXml(exception);
            }

            return exceptionXml;
        }

        private static void CopyDatabaseFiles(string mdfTargetFullName)
        {
            var mdfFileInfo = new FileInfo(mdfTargetFullName);

            var ldfTargetName = Path.GetFileNameWithoutExtension(mdfTargetFullName) + "_log.ldf";

            var ldfTargetFullName = Path.Combine(mdfFileInfo.DirectoryName, ldfTargetName);

            CopyDatabaseFile("Collection.mdf", mdfTargetFullName);
            CopyDatabaseFile("Collection_log.ldf", ldfTargetFullName);
        }

        private static void CopyDatabaseFile(string sourceFile, string targetFile)
        {
            if (File.Exists(targetFile))
            {
                File.Delete(targetFile);
            }

            File.Copy(sourceFile, targetFile);
            File.SetAttributes(targetFile, FileAttributes.Normal | FileAttributes.Archive);
        }

        private IBaseData InsertBaseData(ICollectionCache cache)
        {
            BaseDataInserter inserter = null;

            try
            {
                inserter = new BaseDataInserter(cache, _context);

                inserter.ProgressMaxChanged += OnProgressMaxChanged;
                inserter.ProgressValueChanged += OnProgressValueChanged;
                inserter.Feedback += OnFeedback;

                inserter.Insert();
            }
            finally
            {
                if (inserter != null)
                {
                    inserter.ProgressMaxChanged -= OnProgressMaxChanged;
                    inserter.ProgressValueChanged -= OnProgressValueChanged;
                    inserter.Feedback -= OnFeedback;
                }
            }

            return inserter;
        }

        private void InsertData(Collection collection, IBaseData baseData)
        {
            DataInserter inserter = null;

            try
            {
                inserter = new DataInserter(baseData, _context);

                var dvds = collection.DVDList ?? Enumerable.Empty<DVD>();

                inserter.Insert(dvds);
            }
            finally
            {
                if (inserter != null)
                {
                    inserter.ProgressMaxChanged -= OnProgressMaxChanged;
                    inserter.ProgressValueChanged -= OnProgressValueChanged;
                    inserter.Feedback -= OnFeedback;
                }
            }
        }

        private void OnProgressMaxChanged(object sender, EventArgs<int> e)
        {
            ProgressMaxChanged?.Invoke(this, e);
        }

        private void OnProgressValueChanged(object sender, EventArgs<int> e)
        {
            ProgressValueChanged?.Invoke(this, e);
        }

        private void OnFeedback(object sender, EventArgs<string> e)
        {
            Feedback?.Invoke(this, e);
        }

        private void CheckDbVersion()
        {
            var versionEntity = _context.tDBVersion.Single();

            if (versionEntity.Version != DVDProfilerSchemaVersion)
            {
                throw new InvalidOperationException("Error: Database version incorrect. Abort.");
            }
        }
    }
}