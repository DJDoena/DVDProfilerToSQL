using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class CollectionCache
    {
        private readonly Collection _collection;

        public Hashtable<string> AudioChannels { get; private set; }

        public Hashtable<string> AudioContent { get; private set; }

        public Hashtable<string> AudioFormat { get; private set; }

        public Hashtable<string> CaseType { get; private set; }

        public Hashtable<CollectionType> CollectionType { get; private set; }

        public Hashtable<EventType> EventType { get; private set; }

        public Hashtable<DVDID_Type> DVDIdType { get; private set; }

        public Hashtable<VideoStandard> VideoStandard { get; private set; }

        public Hashtable<string> Genre { get; private set; }

        public Hashtable<string> Subtitle { get; private set; }

        public Hashtable<string> MediaType { get; private set; }

        public PersonHashtable CastAndCrew { get; private set; }

        public Hashtable<string> StudioAndMediaCompany { get; private set; }

        public TagHashtable Tag { get; private set; }

        public UserHashtable User { get; private set; }

        public Hashtable<CategoryRestriction> LinkCategory { get; private set; }

        public Hashtable<string> CountryOfOrigin { get; private set; }

        public Hashtable<string> Locality { get; private set; }

        public Hashtable<string> CreditType { get; private set; }

        public Dictionary<string, Hashtable<string>> CreditSubtype { get; private set; }

        public Hashtable<PurchasePlaceKey> PurchasePlace { get; private set; }

        public PluginHashtable PluginData { get; private set; }

        public CollectionCache(Collection collection)
        {
            _collection = collection;

            DVDIdType = FillStaticHash<DVDID_Type>();

            EventType = FillStaticHash<EventType>();

            VideoStandard = FillStaticHash<VideoStandard>();

            LinkCategory = FillStaticHash<CategoryRestriction>();

            FillDynamicHash();
        }

        private Hashtable<T> FillStaticHash<T>() where T : struct
        {
            var fieldInfos = typeof(T).GetFields(BindingFlags.Public | BindingFlags.Static);

            if (fieldInfos?.Length > 0)
            {
                var hash = new Hashtable<T>(fieldInfos.Length);

                foreach (var fieldInfo in fieldInfos)
                {
                    hash.Add((T)(fieldInfo.GetRawConstantValue()));
                }

                return hash;
            }
            else
            {
                return new Hashtable<T>(0);
            }
        }

        private void FillDynamicHash()
        {
            InitializeHashes();

            if (_collection.DVDList?.Length > 0)
            {
                foreach (var dvd in _collection.DVDList)
                {
                    if (string.IsNullOrEmpty(dvd.ID))
                    {
                        continue;
                    }

                    FillLocalityHash(dvd);

                    FillCollectionTypeHash(dvd);

                    FillCastHash(dvd);

                    FillCrewHash(dvd);

                    FillUserHashFromLoanInfo(dvd);

                    FillUserHashFromEvents(dvd);

                    FillStudioHash(dvd);

                    FillMediaCompanyHash(dvd);

                    FillTagHash(dvd);

                    FillAudioHashes(dvd);

                    FillCaseTypeHash(dvd);

                    FillGenreHash(dvd);

                    FillSubtitleHash(dvd);

                    FillMediaTypeHash(dvd);

                    FillCountryOfOriginHash(dvd);

                    FillPluginHash(dvd);

                    FillCreditTypeAndSubtypeHash(dvd);

                    FillPurchasePlaceHash(dvd);
                }

                foreach (var dvd in _collection.DVDList)
                {
                    //second iteration for data that is less complete
                    FillUserHashFromPurchaseInfo(dvd);
                }
            }
        }

        private void InitializeHashes()
        {
            Locality = new Hashtable<string>(5);

            CollectionType = new Hashtable<CollectionType>(5);

            CastAndCrew = new PersonHashtable(_collection.DVDList.Length * 50);

            StudioAndMediaCompany = new Hashtable<string>(100);

            AudioChannels = new Hashtable<string>(20);

            AudioContent = new Hashtable<string>(20);

            AudioFormat = new Hashtable<string>(20);

            CaseType = new Hashtable<string>(20);

            Tag = new TagHashtable(50);

            User = new UserHashtable(20);

            Genre = new Hashtable<string>(30);

            Subtitle = new Hashtable<string>(30);

            MediaType = new Hashtable<string>(5);

            CountryOfOrigin = new Hashtable<string>(20);

            PluginData = new PluginHashtable(5);

            CreditType = new Hashtable<string>(10);

            CreditSubtype = new Dictionary<string, Hashtable<string>>(10);

            PurchasePlace = new Hashtable<PurchasePlaceKey>(10);
        }

        private void FillUserHashFromPurchaseInfo(DVD dvd)
        {
            if (dvd.PurchaseInfo?.GiftFrom != null)
            {
                if (string.IsNullOrEmpty(dvd.PurchaseInfo.GiftFrom.FirstName) == false || string.IsNullOrEmpty(dvd.PurchaseInfo.GiftFrom.LastName) == false)
                {
                    var user = new User(dvd.PurchaseInfo.GiftFrom);

                    if (User.ContainsKey(user) == false)
                    {
                        User.Add(user);
                    }
                }
            }
        }

        private void FillPluginHash(DVD dvd)
        {
            if (dvd.PluginCustomData?.Length > 0)
            {
                foreach (PluginData pluginData in dvd.PluginCustomData)
                {
                    if (pluginData != null && PluginData.ContainsKey(pluginData) == false)
                    {
                        PluginData.Add(pluginData);
                    }
                }
            }
        }

        private void FillCountryOfOriginHash(DVD dvd)
        {
            if (string.IsNullOrEmpty(dvd.CountryOfOrigin) == false && CountryOfOrigin.ContainsKey(dvd.CountryOfOrigin) == false)
            {
                CountryOfOrigin.Add(dvd.CountryOfOrigin);
            }

            if (string.IsNullOrEmpty(dvd.CountryOfOrigin2) == false && CountryOfOrigin.ContainsKey(dvd.CountryOfOrigin2) == false)
            {
                CountryOfOrigin.Add(dvd.CountryOfOrigin2);
            }

            if (string.IsNullOrEmpty(dvd.CountryOfOrigin3) == false && CountryOfOrigin.ContainsKey(dvd.CountryOfOrigin3) == false)
            {
                CountryOfOrigin.Add(dvd.CountryOfOrigin3);
            }
        }

        private void FillMediaTypeHash(DVD dvd)
        {
            if (dvd.MediaTypes != null)
            {
                if (dvd.MediaTypes.DVD && MediaType.ContainsKey("DVD") == false)
                {
                    MediaType.Add("DVD");
                }

                if (dvd.MediaTypes.BluRay && MediaType.ContainsKey("Blu-ray") == false)
                {
                    MediaType.Add("Blu-ray");
                }

                if (dvd.MediaTypes.HDDVD && MediaType.ContainsKey("HD-DVD") == false)
                {
                    MediaType.Add("HD-DVD");
                }

                if (dvd.MediaTypes.UltraHD && MediaType.ContainsKey("Ultra HD") == false)
                {
                    MediaType.Add("Ultra HD");
                }

                if (string.IsNullOrEmpty(dvd.MediaTypes.CustomMediaType) == false && MediaType.ContainsKey(dvd.MediaTypes.CustomMediaType) == false)
                {
                    MediaType.Add(dvd.MediaTypes.CustomMediaType);
                }
            }
        }

        private void FillSubtitleHash(DVD dvd)
        {
            if (dvd.SubtitleList?.Length > 0)
            {
                foreach (var subtitle in dvd.SubtitleList)
                {
                    if (string.IsNullOrEmpty(subtitle) == false && Subtitle.ContainsKey(subtitle) == false)
                    {
                        Subtitle.Add(subtitle);
                    }
                }
            }
        }

        private void FillGenreHash(DVD dvd)
        {
            if (dvd.GenreList?.Length > 0)
            {
                foreach (var genre in dvd.GenreList)
                {
                    if (string.IsNullOrEmpty(genre) == false && Genre.ContainsKey(genre) == false)
                    {
                        Genre.Add(genre);
                    }
                }
            }
        }

        private void FillCaseTypeHash(DVD dvd)
        {
            if (string.IsNullOrEmpty(dvd.CaseType) == false && CaseType.ContainsKey(dvd.CaseType) == false)
            {
                CaseType.Add(dvd.CaseType);
            }
        }

        private void FillAudioHashes(DVD dvd)
        {
            if (dvd.AudioList?.Length > 0)
            {
                foreach (var audioTrack in dvd.AudioList)
                {
                    if (AudioContent.ContainsKey(audioTrack.Content) == false)
                    {
                        AudioContent.Add(audioTrack.Content);
                    }

                    if (AudioFormat.ContainsKey(audioTrack.Format) == false)
                    {
                        AudioFormat.Add(audioTrack.Format);
                    }

                    if (AudioChannels.ContainsKey(audioTrack.Channels) == false)
                    {
                        AudioChannels.Add(audioTrack.Channels);
                    }

                }
            }
        }

        private void FillTagHash(DVD dvd)
        {
            if (dvd.TagList?.Length > 0)
            {
                foreach (var tag in dvd.TagList)
                {
                    if (Tag.ContainsKey(tag) == false)
                    {
                        Tag.Add(tag);
                    }
                }
            }
        }

        private void FillMediaCompanyHash(DVD dvd)
        {
            if (dvd.MediaCompanyList?.Length > 0)
            {
                foreach (var distributor in dvd.MediaCompanyList)
                {
                    if (StudioAndMediaCompany.ContainsKey(distributor) == false)
                    {
                        StudioAndMediaCompany.Add(distributor);
                    }
                }
            }
        }

        private void FillStudioHash(DVD dvd)
        {
            if (dvd.StudioList?.Length > 0)
            {
                foreach (var studio in dvd.StudioList)
                {
                    if (StudioAndMediaCompany.ContainsKey(studio) == false)
                    {
                        StudioAndMediaCompany.Add(studio);
                    }
                }
            }
        }

        private void FillUserHashFromEvents(DVD dvd)
        {
            if (dvd.EventList?.Length > 0)
            {
                foreach (var myEvent in dvd.EventList)
                {
                    if (User.ContainsKey(myEvent.User) == false)
                    {
                        User.Add(myEvent.User);
                    }
                }
            }
        }

        private void FillUserHashFromLoanInfo(DVD dvd)
        {
            if (dvd.LoanInfo?.User != null && User.ContainsKey(dvd.LoanInfo.User) == false)
            {
                User.Add(dvd.LoanInfo.User);
            }
        }

        private void FillCrewHash(DVD dvd)
        {
            if (dvd.CrewList?.Length > 0)
            {
                var crewMembers = dvd.CrewList.OfType<CrewMember>();

                foreach (var crewMember in crewMembers)
                {
                    FillDynamicHash(CastAndCrew, crewMember);
                }
            }
        }

        private void FillCastHash(DVD dvd)
        {
            if (dvd.CastList?.Length > 0)
            {
                var castMembers = dvd.CastList.OfType<CastMember>();

                foreach (var castMember in castMembers)
                {
                    FillDynamicHash(CastAndCrew, castMember);
                }
            }
        }

        private void FillCollectionTypeHash(DVD dvd)
        {
            if (CollectionType.ContainsKey(dvd.CollectionType) == false)
            {
                CollectionType.Add(dvd.CollectionType);
            }
        }

        private void FillLocalityHash(DVD dvd)
        {
            if (Locality.ContainsKey(dvd.ID_LocalityDesc) == false)
            {
                Locality.Add(dvd.ID_LocalityDesc);
            }
        }

        private void FillDynamicHash<T>(PersonHashtable personHash, T person) where T : class, IPerson
        {
            if (personHash.ContainsKey(person) == false)
            {
                personHash.Add(person);
            }
        }

        private void FillCreditTypeAndSubtypeHash(DVD dvd)
        {
            if (dvd.CrewList?.Length > 0)
            {
                var crewMembers = dvd.CrewList.OfType<CrewMember>();

                foreach (var crewMember in crewMembers)
                {
                    var creditType = crewMember.CreditType ?? string.Empty;

                    FillCreditTypeAndSubtypeHash(creditType, crewMember.CreditSubtype ?? string.Empty);
                }
            }
        }

        private void FillCreditTypeAndSubtypeHash(string creditType, string creditSubtype)
        {
            if (CreditType.ContainsKey(creditType) == false)
            {
                CreditType.Add(creditType);

                CreditSubtype.Add(creditType, new Hashtable<string>(10));
            }

            var creditSubTypes = CreditSubtype[creditType];

            if (creditSubTypes.ContainsKey(creditSubtype) == false)
            {
                creditSubTypes.Add(creditSubtype);
            }
        }

        private void FillPurchasePlaceHash(DVD dvd)
        {
            if (string.IsNullOrEmpty(dvd.PurchaseInfo?.Place) == false)
            {
                var pi = dvd.PurchaseInfo;

                var key = new PurchasePlaceKey(pi.Place, pi.Type, pi.Website);

                if (PurchasePlace.ContainsKey(key) == false)
                {
                    PurchasePlace.Add(key);
                }
            }
        }
    }
}