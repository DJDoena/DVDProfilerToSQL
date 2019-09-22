using System;
using System.Linq;
using System.Windows.Forms;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using DoenaSoft.DVDProfiler.SQLDatabase;

namespace QuerySamples
{
    public static class Program
    {
        private static readonly WindowHandle _windowHandle;

        static Program()
        {
            _windowHandle = new WindowHandle();
        }

        [STAThread]
        public static void Main()
        {
            Console.WriteLine("Please select a database file that was created with 'DVD Profiler to SQL'.");
            Console.WriteLine("(You should see a file dialog. If not, please minimize your other programs.)");

            using (OpenFileDialog ofd = new OpenFileDialog())
            {
                ofd.Filter = "collection.mdf|*.mdf";
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

        private static void Process(string mdfFile)
        {
            //                       "metadata=res://*/CollectionModel.csdl|res://*/CollectionModel.ssdl|res://*/CollectionModel.msl;provider=System.Data.SqlClient;provider connection string='data source=(LocalDB)\MSSQLLocalDB;attachdbfilename=|DataDirectory|\Collection.mdf;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework'"
            var connectionString = $@"metadata=res://*/CollectionModel.csdl|res://*/CollectionModel.ssdl|res://*/CollectionModel.msl;provider=System.Data.SqlClient;provider connection string='data source=(LocalDB)\MSSQLLocalDB;attachdbfilename={mdfFile};integrated security=True;MultipleActiveResultSets=True;App=EntityFramework;';";

            using (var context = new CollectionEntities(connectionString))
            {
                context.Database.Log = Console.WriteLine; //this prints the SQL query to the console in the moment the SQL is actually executed against the database
                                                          //which means you can see how many queries are actually executed and what the SQL query looks like

                BoughtIn2018InLinqSyntax(context);
                Console.WriteLine();
                BoughtIn2018InQuerySyntax(context);
                Console.WriteLine();

                Console.WriteLine();

                ClintEastwoodAsAnActorInLinqSyntax(context);
                Console.WriteLine();
                ClintEastwoodAsAnActorInQuerySyntax(context);
                Console.WriteLine();

                Console.WriteLine();

                ClintEastwoodAsAnActorOrDirectorInLinqSyntax(context);
                Console.WriteLine();
                ClintEastwoodAsAnActorOrDirectorInQuerySyntax(context);
                Console.WriteLine();

                Console.WriteLine();

                AllWritingsStaffInLinqSyntax(context);
                Console.WriteLine();
                AllWritingsStaffInQuerySyntax(context);
                Console.WriteLine();
            }

            Console.ReadLine();
        }

        private static void PrintProfiles(IQueryable<tDVD> query)
        {
            //var sql = query.ToString();

            var result = query.ToList();

            Console.WriteLine("Count: " + result.Count);

            foreach (var profile in result)
            {
                Console.WriteLine(profile.Title);
            }
        }

        private static void BoughtIn2018InLinqSyntax(CollectionEntities context)
        {
            var jan1 = new DateTime(2018, 1, 1, 0, 0, 0);
            var dec31 = new DateTime(2018, 12, 31, 23, 59, 59);

            var query = context.tPurchase
                .Where(p => p.Date.Value >= jan1 && p.Date.Value <= dec31 && p.PriceValue > 0)
                .OrderBy(p => p.Date).ThenBy(p => p.tDVD.SortTitle)
                .Select(p => p.tDVD);

            PrintProfiles(query);
        }

        private static void BoughtIn2018InQuerySyntax(CollectionEntities context)
        {
            var jan1 = new DateTime(2018, 1, 1, 0, 0, 0);
            var dec31 = new DateTime(2018, 12, 31, 23, 59, 59);

            var query = from p in context.tPurchase
                        where p.Date >= jan1 && p.Date <= dec31 && p.PriceValue > 0
                        orderby p.Date, p.tDVD.SortTitle
                        select p.tDVD;

            PrintProfiles(query);
        }

        private static void ClintEastwoodAsAnActorInLinqSyntax(CollectionEntities context)
        {
            var query = context.tDVD
                .Where(p => p.tDVDxCast.Any(x => x.tCastAndCrew.FirstName == "Clint" && x.tCastAndCrew.LastName == "Eastwood"))
                .OrderBy(p => p.SortTitle);

            PrintProfiles(query);
        }

        private static void ClintEastwoodAsAnActorInQuerySyntax(CollectionEntities context)
        {
            var query = from p in context.tDVD
                        where p.tDVDxCast.Any(x => x.tCastAndCrew.FirstName == "Clint" && x.tCastAndCrew.LastName == "Eastwood")
                        orderby p.SortTitle
                        select p;

            PrintProfiles(query);
        }

        private static void ClintEastwoodAsAnActorOrDirectorInLinqSyntax(CollectionEntities context)
        {
            var castQuery = context.tDVDxCast
                .Where(x => x.tCastAndCrew.FirstName == "Clint" && x.tCastAndCrew.LastName == "Eastwood");

            var crewQuery = context.tDVDxCrew
                .Where(x => x.tCastAndCrew.FirstName == "Clint" && x.tCastAndCrew.LastName == "Eastwood"
                    && x.tCreditSubtype.Subtype == "Director" && x.tCreditSubtype.tCreditType.Type == "Direction");

            var query = context.tDVD
                .Where(p => p.tDVDxCast.Any(x => castQuery.Contains(x)) || p.tDVDxCrew.Any(x => crewQuery.Contains(x)))
                .OrderBy(p => p.SortTitle);

            PrintProfiles(query);
        }

        private static void ClintEastwoodAsAnActorOrDirectorInQuerySyntax(CollectionEntities context)
        {
            var castQuery = from x in context.tDVDxCast
                            where x.tCastAndCrew.FirstName == "Clint" && x.tCastAndCrew.LastName == "Eastwood"
                            select x;

            var crewQuery = from x in context.tDVDxCrew
                            where x.tCastAndCrew.FirstName == "Clint" && x.tCastAndCrew.LastName == "Eastwood"
                                && x.tCreditSubtype.Subtype == "Director" && x.tCreditSubtype.tCreditType.Type == "Direction"
                            select x;

            var query = from p in context.tDVD
                        where p.tDVDxCast.Any(x => castQuery.Contains(x)) || p.tDVDxCrew.Any(x => crewQuery.Contains(x))
                        orderby p.SortTitle
                        select p;

            PrintProfiles(query);
        }

        private static void PrintCrew(IQueryable<tCastAndCrew> query)
        {
            //var sql = query.ToString();

            var result = query.ToList();

            Console.WriteLine("Count: " + result.Count);

            foreach (var crewMember in result)
            {
                Console.WriteLine($"{crewMember.LastName}, {crewMember.FirstName} {crewMember.MiddleName} ({crewMember.BirthYear})");
            }
        }

        private static void AllWritingsStaffInLinqSyntax(CollectionEntities context)
        {
            var query = context.tCreditType
                .Where(ct => ct.Type == "Writing")
                .SelectMany(ct => ct.tCreditSubtype)
                .SelectMany(cst => cst.tDVDxCrew)
                .Select(x => x.tCastAndCrew)
                .Distinct()
                .OrderBy(c => c.LastName).ThenBy(c => c.FirstName).ThenBy(c => c.MiddleName).ThenBy(c => c.BirthYear);

            PrintCrew(query);
        }

        private static void AllWritingsStaffInQuerySyntax(CollectionEntities context)
        {
            var query = from ct in context.tCreditType
                        where ct.Type == "Writing"
                        from cst in ct.tCreditSubtype
                        from x in cst.tDVDxCrew
                        select x.tCastAndCrew;

            var distinct = query.Distinct(); //Query syntax doesn't have the distinct keyword

            var ordered = from c in distinct
                          orderby c.LastName, c.FirstName, c.MiddleName, c.BirthYear
                          select c;

            PrintCrew(ordered);
        }
    }
}