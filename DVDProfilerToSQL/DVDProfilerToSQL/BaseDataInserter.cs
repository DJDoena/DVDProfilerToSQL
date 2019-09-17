using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using Collection = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class BaseDataInserter
    {
        private readonly CollectionCache _cache;

        private readonly Entity.CollectionEntities _context;

        public Dictionary<string, Entity.tAudioChannels> AudioChannels { get; private set; }

        public Dictionary<string, Entity.tAudioContent> AudioContent { get; private set; }

        public Dictionary<string, Entity.tAudioFormat> AudioFormat { get; private set; }

        public Dictionary<string, Entity.tCaseType> CaseType { get; private set; }

        public Dictionary<Collection.CollectionType, Entity.tCollectionType> CollectionType { get; private set; }

        public Dictionary<Collection.EventType, Entity.tEventType> EventType { get; private set; }

        public Dictionary<Collection.DVDID_Type, Entity.tDVDIdType> DVDIdType { get; private set; }

        public Dictionary<Collection.VideoStandard, Entity.tVideoStandard> VideoStandard { get; private set; }

        public Dictionary<string, Entity.tGenre> Genre { get; private set; }

        public Dictionary<string, Entity.tSubtitle> Subtitle { get; private set; }

        public Dictionary<string, Entity.tMediaType> MediaType { get; private set; }

        public Dictionary<PersonKey, Entity.tCastAndCrew> CastAndCrew { get; private set; }

        public Dictionary<string, Entity.tStudioAndMediaCompany> StudioAndMediaCompany { get; private set; }

        public Dictionary<TagKey, Entity.tTag> Tag { get; private set; }

        public Dictionary<UserKey, Entity.tUser> User { get; private set; }

        public Dictionary<Collection.CategoryRestriction, Entity.tLinkCategory> LinkCategory { get; private set; }

        public Dictionary<string, Entity.tCountryOfOrigin> CountryOfOrigin { get; private set; }

        public Dictionary<string, Entity.tLocality> Locality { get; private set; }

        public Dictionary<string, Entity.tCreditType> CreditType { get; private set; }

        public Dictionary<string, Dictionary<string, Entity.tCreditSubtype>> CreditSubtype { get; private set; }

        public Dictionary<PurchasePlaceKey, Entity.tPurchasePlace> PurchasePlace { get; private set; }

        public Dictionary<PluginKey, Entity.tPluginData> PluginData { get; private set; }

        public BaseDataInserter(CollectionCache cache, Entity.CollectionEntities context)
        {
            _cache = cache;
            _context = context;
        }

        internal event EventHandler<EventArgs<int>> ProgressMaxChanged;

        internal event EventHandler<EventArgs<int>> ProgressValueChanged;

        internal event EventHandler<EventArgs<string>> Feedback;

        public void Insert()
        {
            InitializeHashes();

            InsertAudioChannels();

            InsertAudioContents();

            InsertAudioFormats();

            InsertCaseTypes();

            InsertCastAndCrew();

            InsertCollectionTypes();

            InsertCountriesOfOrigin();

            InsertCreditTypes();

            InsertCreditSubtypes();

            InsertDVDIdTypes();

            InsertEventTypes();

            InsertGenres();

            InsertLinkCategories();

            InsertLocalities();

            InsertMediaTypes();

            InsertPlugins();

            InsertPurchasePlace();

            InsertStudiosAndMediaCompanies();

            InsertSubtitles();

            InsertTags();

            InsertUsers();

            InsertVideoStandards();
        }

        private void InitializeHashes()
        {
            DVDIdType = new Dictionary<Collection.DVDID_Type, Entity.tDVDIdType>(_cache.DVDIdType.Count);

            EventType = new Dictionary<Collection.EventType, Entity.tEventType>(_cache.EventType.Count);

            VideoStandard = new Dictionary<Collection.VideoStandard, Entity.tVideoStandard>(_cache.VideoStandard.Count);

            LinkCategory = new Dictionary<Collection.CategoryRestriction, Entity.tLinkCategory>(_cache.LinkCategory.Count);

            Locality = new Dictionary<string, Entity.tLocality>(_cache.Locality.Count);

            CollectionType = new Dictionary<Collection.CollectionType, Entity.tCollectionType>(_cache.CollectionType.Count);

            CastAndCrew = new Dictionary<PersonKey, Entity.tCastAndCrew>(_cache.CastAndCrew.Count);

            StudioAndMediaCompany = new Dictionary<string, Entity.tStudioAndMediaCompany>(_cache.StudioAndMediaCompany.Count);

            AudioChannels = new Dictionary<string, Entity.tAudioChannels>(_cache.AudioChannels.Count);

            AudioContent = new Dictionary<string, Entity.tAudioContent>(_cache.AudioContent.Count);

            AudioFormat = new Dictionary<string, Entity.tAudioFormat>(_cache.AudioFormat.Count);

            CaseType = new Dictionary<string, Entity.tCaseType>(_cache.CaseType.Count);

            Tag = new Dictionary<TagKey, Entity.tTag>(_cache.Tag.Count);

            User = new Dictionary<UserKey, Entity.tUser>(_cache.User.Count);

            Genre = new Dictionary<string, Entity.tGenre>(_cache.Genre.Count);

            Subtitle = new Dictionary<string, Entity.tSubtitle>(_cache.Subtitle.Count);

            MediaType = new Dictionary<string, Entity.tMediaType>(_cache.MediaType.Count);

            CountryOfOrigin = new Dictionary<string, Entity.tCountryOfOrigin>(_cache.CountryOfOrigin.Count);

            PluginData = new Dictionary<PluginKey, Entity.tPluginData>(_cache.PluginData.Count);

            CreditType = new Dictionary<string, Entity.tCreditType>(_cache.CreditType.Count);

            CreditSubtype = new Dictionary<string, Dictionary<string, Entity.tCreditSubtype>>(_cache.CreditSubtype.Count);

            PurchasePlace = new Dictionary<PurchasePlaceKey, Entity.tPurchasePlace>(_cache.PurchasePlace.Count);
        }

        private void ReportStart(IDictionary dictionary, string section)
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(dictionary.Count));

            Feedback?.Invoke(this, new EventArgs<string>(section));
        }

        private void ReportCurrent(ref int current)
        {
            ProgressValueChanged?.Invoke(this, new EventArgs<int>(current++));
        }

        private void ReportFinish()
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(0));
        }

        private void InsertAudioChannels()
        {
            ReportStart(_cache.AudioChannels, "Audio Channels");

            var current = 0;

            foreach (var kvp in _cache.AudioChannels)
            {
                var entity = new Entity.tAudioChannels()
                {
                    AudioChannelsId = kvp.Value,
                    Channels = kvp.Key,
                };

                _context.tAudioChannels.Add(entity);

                AudioChannels.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertAudioContents()
        {
            ReportStart(_cache.AudioContent, "Audio Content");

            var current = 0;

            foreach (var kvp in _cache.AudioContent)
            {
                var entity = new Entity.tAudioContent()
                {
                    AudioContentId = kvp.Value,
                    Content = kvp.Key,
                };

                _context.tAudioContent.Add(entity);

                AudioContent.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertAudioFormats()
        {
            ReportStart(_cache.AudioFormat, "Audio Format");

            var current = 0;

            foreach (var kvp in _cache.AudioFormat)
            {
                var entity = new Entity.tAudioFormat()
                {
                    AudioFormatId = kvp.Value,
                    Format = kvp.Key,
                };

                _context.tAudioFormat.Add(entity);

                AudioFormat.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertCaseTypes()
        {
            ReportStart(_cache.CaseType, "Case Type");

            var current = 0;

            foreach (var kvp in _cache.CaseType)
            {
                var entity = new Entity.tCaseType()
                {
                    CaseTypeId = kvp.Value,
                    Type = kvp.Key,
                };

                _context.tCaseType.Add(entity);

                CaseType.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertCastAndCrew()
        {
            ReportStart(_cache.CastAndCrew, "Cast & Crew");

            var current = 0;

            foreach (var kvp in _cache.CastAndCrew)
            {
                var key = kvp.Key.KeyData;

                var entity = new Entity.tCastAndCrew()
                {
                    CastAndCrewId = kvp.Value,
                    LastName = key.LastName,
                    MiddleName = key.MiddleName,
                    FirstName = key.FirstName,
                    BirthYear = key.BirthYear != 0 ? key.BirthYear : (int?)null,
                };

                _context.tCastAndCrew.Add(entity);

                CastAndCrew.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertCollectionTypes()
        {
            ReportStart(_cache.CollectionType, "Collection Type");

            var current = 0;

            foreach (var kvp in _cache.CollectionType)
            {
                var collectionType = kvp.Key;

                var entity = new Entity.tCollectionType()
                {
                    CollectionTypeId = kvp.Value,
                    Type = collectionType.Value,
                    IsPartOfOwnedCollection = collectionType.IsPartOfOwnedCollection,
                };

                _context.tCollectionType.Add(entity);

                CollectionType.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertCountriesOfOrigin()
        {
            ReportStart(_cache.CountryOfOrigin, "Country of Origin");

            var current = 0;

            foreach (var kvp in _cache.CountryOfOrigin)
            {
                var entity = new Entity.tCountryOfOrigin()
                {
                    CountryOfOriginId = kvp.Value,
                    Country = kvp.Key,
                };

                _context.tCountryOfOrigin.Add(entity);

                CountryOfOrigin.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertCreditTypes()
        {
            ReportStart(_cache.CreditType, "Credit Type");

            var current = 0;

            foreach (var kvp in _cache.CreditType)
            {
                var entity = new Entity.tCreditType()
                {
                    CreditTypeId = kvp.Value,
                    Type = kvp.Key,
                };

                _context.tCreditType.Add(entity);

                CreditType.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertCreditSubtypes()
        {
            var count = _cache.CreditSubtype.Select(c => c.Value.Count).Sum();

            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(count));

            Feedback?.Invoke(this, new EventArgs<string>("Credit Subtype"));

            var current = 0;

            foreach (var kvp in _cache.CreditSubtype)
            {
                var creditTypeEntity = CreditType[kvp.Key];

                var creditSubtype = InsertCreditSubtypes(creditTypeEntity, kvp.Value, ref current);

                CreditSubtype.Add(kvp.Key, creditSubtype);
            }

            ReportFinish();
        }

        private Dictionary<string, Entity.tCreditSubtype> InsertCreditSubtypes(Entity.tCreditType creditTypeEntity, Hashtable<string> creditSubtypeCache, ref int current)
        {
            var creditSubtype = new Dictionary<string, Entity.tCreditSubtype>(10);

            foreach (var kvp in creditSubtypeCache)
            {
                var entity = new Entity.tCreditSubtype()
                {
                    CreditSubtypeId = kvp.Value,
                    tCreditType = creditTypeEntity,
                    Subtype = kvp.Key,
                };

                _context.tCreditSubtype.Add(entity);

                creditSubtype.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            return creditSubtype;
        }

        private void InsertDVDIdTypes()
        {
            ReportStart(_cache.DVDIdType, "DVD Id Type");

            var current = 0;

            foreach (var kvp in _cache.DVDIdType)
            {
                var entity = new Entity.tDVDIdType()
                {
                    DVDIdTypeId = kvp.Value,
                    Type = Enum.GetName(typeof(Collection.DVDID_Type), kvp.Key),
                };

                _context.tDVDIdType.Add(entity);

                DVDIdType.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertEventTypes()
        {
            ReportStart(_cache.EventType, "Event Type");

            var current = 0;

            foreach (var kvp in _cache.EventType)
            {
                var entity = new Entity.tEventType()
                {
                    EventTypeId = kvp.Value,
                    Type = Enum.GetName(typeof(Collection.EventType), kvp.Key),
                };

                _context.tEventType.Add(entity);

                EventType.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertGenres()
        {
            ReportStart(_cache.Genre, "Genre");

            var current = 0;

            foreach (var kvp in _cache.Genre)
            {
                var entity = new Entity.tGenre()
                {
                    GenreId = kvp.Value,
                    Genre = kvp.Key,
                };

                _context.tGenre.Add(entity);

                Genre.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertLinkCategories()
        {
            ReportStart(_cache.LinkCategory, "Link Category");

            var current = 0;

            foreach (var kvp in _cache.LinkCategory)
            {
                var entity = new Entity.tLinkCategory()
                {
                    LinkCategoryId = kvp.Value,
                    Category = Enum.GetName(typeof(Collection.CategoryRestriction), kvp.Key),
                };

                _context.tLinkCategory.Add(entity);

                LinkCategory.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertLocalities()
        {
            ReportStart(_cache.Locality, "Locality");

            var current = 0;

            foreach (var kvp in _cache.Locality)
            {
                var entity = new Entity.tLocality()
                {
                    LocalityId = kvp.Value,
                    Locality = kvp.Key,
                };

                _context.tLocality.Add(entity);

                Locality.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertMediaTypes()
        {
            ReportStart(_cache.MediaType, "Media Type");

            var current = 0;

            foreach (var kvp in _cache.MediaType)
            {
                var entity = new Entity.tMediaType()
                {
                    MediyTypeId = kvp.Value,
                    Type = kvp.Key,
                };

                _context.tMediaType.Add(entity);

                MediaType.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertPlugins()
        {
            ReportStart(_cache.PluginData, "Plugin Data");

            var current = 0;

            foreach (var kvp in _cache.PluginData)
            {
                var pluginData = kvp.Key.PluginData;

                var entity = new Entity.tPluginData()
                {
                    PluginDataId = kvp.Value,
                    Guid = Guid.Parse(pluginData.ClassID),
                    Name = pluginData.Name,
                };

                _context.tPluginData.Add(entity);

                PluginData.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertPurchasePlace()
        {
            ReportStart(_cache.PurchasePlace, "Purchase Place");

            var current = 0;

            foreach (var kvp in _cache.PurchasePlace)
            {
                var key = kvp.Key;

                var entity = new Entity.tPurchasePlace()
                {
                    PurchasePlaceId = kvp.Value,
                    Place = key.Place,
                    Type = key.Type,
                    Website = key.Website,
                };

                _context.tPurchasePlace.Add(entity);

                PurchasePlace.Add(key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertStudiosAndMediaCompanies()
        {
            ReportStart(_cache.StudioAndMediaCompany, "Studio & Media Company");

            var current = 0;

            foreach (var kvp in _cache.StudioAndMediaCompany)
            {
                var entity = new Entity.tStudioAndMediaCompany()
                {
                    StudioAndMediaCompanyId = kvp.Value,
                    Name = kvp.Key,
                };

                _context.tStudioAndMediaCompany.Add(entity);

                StudioAndMediaCompany.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertSubtitles()
        {
            ReportStart(_cache.Subtitle, "Subtitle");

            var current = 0;

            foreach (var kvp in _cache.Subtitle)
            {
                var entity = new Entity.tSubtitle()
                {
                    SubtitleId = kvp.Value,
                    Subtitle = kvp.Key,
                };

                _context.tSubtitle.Add(entity);

                Subtitle.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertTags()
        {
            ReportStart(_cache.Tag, "Tag");

            var current = 0;

            foreach (var kvp in _cache.Tag)
            {
                var tag = kvp.Key.Tag;

                var entity = new Entity.tTag()
                {
                    TagId = kvp.Value,
                    FullName = tag.FullName,
                    Name = tag.Name,
                };

                _context.tTag.Add(entity);

                Tag.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertUsers()
        {
            ReportStart(_cache.User, "User");

            var current = 0;

            foreach (var kvp in _cache.User)
            {
                var user = kvp.Key.User;

                var entity = new Entity.tUser()
                {
                    UserId = kvp.Value,
                    LastName = user.LastName,
                    FirstName = user.FirstName,
                    EMailAddress = user.EmailAddress,
                    PhoneNumber = user.PhoneNumber,
                };

                _context.tUser.Add(entity);

                User.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }

        private void InsertVideoStandards()
        {
            ReportStart(_cache.VideoStandard, "Video Standard");

            var current = 0;

            foreach (var kvp in _cache.VideoStandard)
            {
                var entity = new Entity.tVideoStandard()
                {
                    VideoStandardId = kvp.Value,
                    VideoStandard = Enum.GetName(typeof(Collection.VideoStandard), kvp.Key),
                };

                _context.tVideoStandard.Add(entity);

                VideoStandard.Add(kvp.Key, entity);

                ReportCurrent(ref current);
            }

            ReportFinish();
        }
    }
}
