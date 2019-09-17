using System;
using System.Collections.Generic;
using System.Linq;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using Collection = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class BaseDataInserter : IBaseData, IProgressReporter
    {
        private readonly ICollectionCache _cache;

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

        public Dictionary<LocalityKey, Entity.tLocality> Locality { get; private set; }

        public Dictionary<string, Entity.tCreditType> CreditType { get; private set; }

        public Dictionary<string, Dictionary<string, Entity.tCreditSubtype>> CreditSubtype { get; private set; }

        public Dictionary<PurchasePlaceKey, Entity.tPurchasePlace> PurchasePlace { get; private set; }

        public Dictionary<PluginKey, Entity.tPluginData> PluginData { get; private set; }

        public BaseDataInserter(ICollectionCache cache, Entity.CollectionEntities context)
        {
            _cache = cache;
            _context = context;
        }

        public event EventHandler<EventArgs<int>> ProgressMaxChanged;

        public event EventHandler<EventArgs<int>> ProgressValueChanged;

        public event EventHandler<EventArgs<string>> Feedback;

        internal void Insert()
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

            Locality = new Dictionary<LocalityKey, Entity.tLocality>(_cache.Locality.Count);

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

        private void InsertAudioChannels()
        {
            ReportStart(_cache.AudioChannels, "Audio Channels");

            var currentProgress = 0;

            foreach (var item in _cache.AudioChannels)
            {
                var entity = new Entity.tAudioChannels()
                {
                    Channels = item,
                };

                _context.tAudioChannels.Add(entity);

                AudioChannels.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertAudioContents()
        {
            ReportStart(_cache.AudioContent, "Audio Content");

            var currentProgress = 0;

            foreach (var item in _cache.AudioContent)
            {
                var entity = new Entity.tAudioContent()
                {
                    Content = item,
                };

                _context.tAudioContent.Add(entity);

                AudioContent.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertAudioFormats()
        {
            ReportStart(_cache.AudioFormat, "Audio Format");

            var currentProgress = 0;

            foreach (var item in _cache.AudioFormat)
            {
                var entity = new Entity.tAudioFormat()
                {
                    Format = item,
                };

                _context.tAudioFormat.Add(entity);

                AudioFormat.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertCaseTypes()
        {
            ReportStart(_cache.CaseType, "Case Type");

            var currentProgress = 0;

            foreach (var item in _cache.CaseType)
            {
                var entity = new Entity.tCaseType()
                {
                    Type = item,
                };

                _context.tCaseType.Add(entity);

                CaseType.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertCastAndCrew()
        {
            ReportStart(_cache.CastAndCrew, "Cast & Crew");

            var currentProgress = 0;

            foreach (var item in _cache.CastAndCrew)
            {
                var key = item.KeyData;

                var entity = new Entity.tCastAndCrew()
                {
                    LastName = key.LastName,
                    MiddleName = key.MiddleName,
                    FirstName = key.FirstName,
                    BirthYear = key.BirthYear != 0 ? key.BirthYear : (int?)null,
                };

                _context.tCastAndCrew.Add(entity);

                CastAndCrew.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertCollectionTypes()
        {
            ReportStart(_cache.CollectionType, "Collection Type");

            var currentProgress = 0;

            foreach (var item in _cache.CollectionType)
            {
                var collectionType = item;

                var entity = new Entity.tCollectionType()
                {
                    Type = collectionType.Value,
                    IsPartOfOwnedCollection = collectionType.IsPartOfOwnedCollection,
                };

                _context.tCollectionType.Add(entity);

                CollectionType.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertCountriesOfOrigin()
        {
            ReportStart(_cache.CountryOfOrigin, "Country of Origin");

            var currentProgress = 0;

            foreach (var item in _cache.CountryOfOrigin)
            {
                var entity = new Entity.tCountryOfOrigin()
                {
                    Country = item,
                };

                _context.tCountryOfOrigin.Add(entity);

                CountryOfOrigin.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertCreditTypes()
        {
            ReportStart(_cache.CreditType, "Credit Type");

            var currentProgress = 0;

            foreach (var item in _cache.CreditType)
            {
                var entity = new Entity.tCreditType()
                {
                    Type = item,
                };

                _context.tCreditType.Add(entity);

                CreditType.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertCreditSubtypes()
        {
            var count = _cache.CreditSubtype.Select(c => c.Value.Count).Sum();

            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(count));

            Feedback?.Invoke(this, new EventArgs<string>("Credit Subtype"));

            var currentProgress = 0;

            foreach (var item in _cache.CreditSubtype)
            {
                var creditTypeEntity = CreditType[item.Key];

                var creditSubtype = InsertCreditSubtypes(creditTypeEntity, item.Value, ref currentProgress);

                CreditSubtype.Add(item.Key, creditSubtype);
            }

            ReportFinish();
        }

        private Dictionary<string, Entity.tCreditSubtype> InsertCreditSubtypes(Entity.tCreditType creditTypeEntity, Hash<string> creditSubtypeCache, ref int currentProgress)
        {
            var creditSubtype = new Dictionary<string, Entity.tCreditSubtype>(10);

            foreach (var item in creditSubtypeCache)
            {
                var entity = new Entity.tCreditSubtype()
                {
                    tCreditType = creditTypeEntity,
                    Subtype = item,
                };

                _context.tCreditSubtype.Add(entity);

                creditSubtype.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            return creditSubtype;
        }

        private void InsertDVDIdTypes()
        {
            ReportStart(_cache.DVDIdType, "DVD Id Type");

            var currentProgress = 0;

            foreach (var item in _cache.DVDIdType)
            {
                var entity = new Entity.tDVDIdType()
                {
                    Type = Enum.GetName(typeof(Collection.DVDID_Type), item),
                };

                _context.tDVDIdType.Add(entity);

                DVDIdType.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertEventTypes()
        {
            ReportStart(_cache.EventType, "Event Type");

            var currentProgress = 0;

            foreach (var item in _cache.EventType)
            {
                var entity = new Entity.tEventType()
                {
                    Type = Enum.GetName(typeof(Collection.EventType), item),
                };

                _context.tEventType.Add(entity);

                EventType.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertGenres()
        {
            ReportStart(_cache.Genre, "Genre");

            var currentProgress = 0;

            foreach (var item in _cache.Genre)
            {
                var entity = new Entity.tGenre()
                {
                    Genre = item,
                };

                _context.tGenre.Add(entity);

                Genre.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertLinkCategories()
        {
            ReportStart(_cache.LinkCategory, "Link Category");

            var currentProgress = 0;

            foreach (var item in _cache.LinkCategory)
            {
                var entity = new Entity.tLinkCategory()
                {
                    Category = Enum.GetName(typeof(Collection.CategoryRestriction), item),
                };

                _context.tLinkCategory.Add(entity);

                LinkCategory.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertLocalities()
        {
            ReportStart(_cache.Locality, "Locality");

            var currentProgress = 0;

            foreach (var item in _cache.Locality)
            {
                var entity = new Entity.tLocality()
                {
                    LocalityId = item.Id,
                    Locality = item.Description,
                };

                _context.tLocality.Add(entity);

                Locality.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertMediaTypes()
        {
            ReportStart(_cache.MediaType, "Media Type");

            var currentProgress = 0;

            foreach (var item in _cache.MediaType)
            {
                var entity = new Entity.tMediaType()
                {
                    Type = item,
                };

                _context.tMediaType.Add(entity);

                MediaType.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertPlugins()
        {
            ReportStart(_cache.PluginData, "Plugin Data");

            var currentProgress = 0;

            foreach (var item in _cache.PluginData)
            {
                var entity = new Entity.tPluginData()
                {
                    Guid = item.ClassId,
                    Name = item.Name,
                };

                _context.tPluginData.Add(entity);

                PluginData.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertPurchasePlace()
        {
            ReportStart(_cache.PurchasePlace, "Purchase Place");

            var currentProgress = 0;

            foreach (var item in _cache.PurchasePlace)
            {
                var key = item;

                var entity = new Entity.tPurchasePlace()
                {
                    Place = key.Place,
                    Type = key.Type,
                    Website = key.Website,
                };

                _context.tPurchasePlace.Add(entity);

                PurchasePlace.Add(key, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertStudiosAndMediaCompanies()
        {
            ReportStart(_cache.StudioAndMediaCompany, "Studio & Media Company");

            var currentProgress = 0;

            foreach (var item in _cache.StudioAndMediaCompany)
            {
                var entity = new Entity.tStudioAndMediaCompany()
                {
                    Name = item,
                };

                _context.tStudioAndMediaCompany.Add(entity);

                StudioAndMediaCompany.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertSubtitles()
        {
            ReportStart(_cache.Subtitle, "Subtitle");

            var currentProgress = 0;

            foreach (var item in _cache.Subtitle)
            {
                var entity = new Entity.tSubtitle()
                {
                    Subtitle = item,
                };

                _context.tSubtitle.Add(entity);

                Subtitle.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertTags()
        {
            ReportStart(_cache.Tag, "Tag");

            var currentProgress = 0;

            foreach (var item in _cache.Tag)
            {
                var entity = new Entity.tTag()
                {
                    FullName = item.FullName,
                    Name = item.Name,
                };

                _context.tTag.Add(entity);

                Tag.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertUsers()
        {
            ReportStart(_cache.User, "User");

            var currentProgress = 0;

            foreach (var item in _cache.User)
            {
                var entity = new Entity.tUser()
                {
                    LastName = item.LastName,
                    FirstName = item.FirstName,
                    EMailAddress = item.EmailAddress,
                    PhoneNumber = item.PhoneNumber,
                };

                _context.tUser.Add(entity);

                User.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void InsertVideoStandards()
        {
            ReportStart(_cache.VideoStandard, "Video Standard");

            var currentProgress = 0;

            foreach (var item in _cache.VideoStandard)
            {
                var entity = new Entity.tVideoStandard()
                {
                    VideoStandard = Enum.GetName(typeof(Collection.VideoStandard), item),
                };

                _context.tVideoStandard.Add(entity);

                VideoStandard.Add(item, entity);

                ReportCurrent(ref currentProgress);
            }

            ReportFinish();
        }

        private void ReportStart<T>(IEnumerable<T> enumerable, string section)
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(enumerable.Count()));

            Feedback?.Invoke(this, new EventArgs<string>(section));
        }

        private void ReportCurrent(ref int currentProgress)
        {
            ProgressValueChanged?.Invoke(this, new EventArgs<int>(currentProgress++));
        }

        private void ReportFinish()
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(0));
        }
    }
}
