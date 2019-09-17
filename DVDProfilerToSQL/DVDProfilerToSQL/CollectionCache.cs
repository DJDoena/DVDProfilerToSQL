using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class CollectionCache : ICollectionCache
    {
        private readonly Collection _collection;

        public Hash<string> AudioChannels { get; private set; }

        public Hash<string> AudioContent { get; private set; }

        public Hash<string> AudioFormat { get; private set; }

        public Hash<string> CaseType { get; private set; }

        public Hash<CollectionType> CollectionType { get; private set; }

        public Hash<EventType> EventType { get; private set; }

        public Hash<DVDID_Type> DVDIdType { get; private set; }

        public Hash<VideoStandard> VideoStandard { get; private set; }

        public Hash<string> Genre { get; private set; }

        public Hash<string> Subtitle { get; private set; }

        public Hash<string> MediaType { get; private set; }

        public PersonHash CastAndCrew { get; private set; }

        public Hash<string> StudioAndMediaCompany { get; private set; }

        public TagHash Tag { get; private set; }

        public UserHash User { get; private set; }

        public Hash<CategoryRestriction> LinkCategory { get; private set; }

        public Hash<string> CountryOfOrigin { get; private set; }

        public Hash<LocalityKey> Locality { get; private set; }

        public Hash<string> CreditType { get; private set; }

        public Dictionary<string, Hash<string>> CreditSubtype { get; private set; }

        public Hash<PurchasePlaceKey> PurchasePlace { get; private set; }

        public PluginHash PluginData { get; private set; }

        public CollectionCache(Collection collection)
        {
            _collection = collection;

            DVDIdType = FillStaticHash<DVDID_Type>();

            EventType = FillStaticHash<EventType>();

            VideoStandard = FillStaticHash<VideoStandard>();

            LinkCategory = FillStaticHash<CategoryRestriction>();

            FillDynamicHash();
        }

        private Hash<T> FillStaticHash<T>() where T : Enum
        {
            var fieldInfos = typeof(T).GetFields(BindingFlags.Public | BindingFlags.Static);

            if (fieldInfos?.Length > 0)
            {
                var hash = new Hash<T>();

                foreach (var fieldInfo in fieldInfos)
                {
                    hash.Add((T)(fieldInfo.GetRawConstantValue()));
                }

                return hash;
            }
            else
            {
                return new Hash<T>();
            }
        }

        private void FillDynamicHash()
        {
            InitializeHashes();

            var dvds = _collection.DVDList ?? Enumerable.Empty<DVD>();

            foreach (var dvd in dvds)
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

            foreach (var dvd in dvds)
            {
                //second iteration for data that is less complete
                FillUserHashFromPurchaseInfo(dvd);
            }
        }

        private void InitializeHashes()
        {
            Locality = new Hash<LocalityKey>();

            CollectionType = new Hash<CollectionType>();

            CastAndCrew = new PersonHash();

            StudioAndMediaCompany = new Hash<string>();

            AudioChannels = new Hash<string>();

            AudioContent = new Hash<string>();

            AudioFormat = new Hash<string>();

            CaseType = new Hash<string>();

            Tag = new TagHash();

            User = new UserHash();

            Genre = new Hash<string>();

            Subtitle = new Hash<string>();

            MediaType = new Hash<string>();

            CountryOfOrigin = new Hash<string>();

            PluginData = new PluginHash();

            CreditType = new Hash<string>();

            CreditSubtype = new Dictionary<string, Hash<string>>();

            PurchasePlace = new Hash<PurchasePlaceKey>();
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

                    if (string.IsNullOrEmpty(audioTrack.Format) == false && AudioFormat.ContainsKey(audioTrack.Format) == false)
                    {
                        AudioFormat.Add(audioTrack.Format);
                    }

                    if (string.IsNullOrEmpty(audioTrack.Channels) == false && AudioChannels.ContainsKey(audioTrack.Channels) == false)
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
            var key = new LocalityKey(dvd);

            if (Locality.ContainsKey(key) == false)
            {
                Locality.Add(key);
            }
        }

        private void FillDynamicHash<T>(PersonHash personHash, T person) where T : class, IPerson
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

                CreditSubtype.Add(creditType, new Hash<string>());
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
                var key = new PurchasePlaceKey(dvd.PurchaseInfo);

                if (PurchasePlace.ContainsKey(key) == false)
                {
                    PurchasePlace.Add(key);
                }
            }
        }
    }
}