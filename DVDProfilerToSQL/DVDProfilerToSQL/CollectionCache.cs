using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class CollectionCache : ICollectionCache
    {
        private readonly IEnumerable<Profiler.DVD> _profiles;

        public HashSet<string> AudioChannels { get; private set; }

        public HashSet<string> AudioContent { get; private set; }

        public HashSet<string> AudioFormat { get; private set; }

        public HashSet<string> CaseType { get; private set; }

        public HashSet<PersonKey> CastAndCrew { get; private set; }

        public HashSet<Profiler.CollectionType> CollectionType { get; private set; }

        public HashSet<string> CountryOfOrigin { get; private set; }

        public HashSet<string> CreditType { get; private set; }

        public Dictionary<string, HashSet<string>> CreditSubtype { get; private set; }

        public HashSet<Profiler.DVDID_Type> DVDIdType { get; private set; }

        public HashSet<Profiler.EventType> EventType { get; private set; }

        public HashSet<string> Genre { get; private set; }

        public HashSet<Profiler.CategoryRestriction> LinkCategory { get; private set; }

        public HashSet<LocalityKey> Locality { get; private set; }

        public HashSet<string> MediaType { get; private set; }

        public HashSet<PluginDataKey> PluginData { get; private set; }

        public HashSet<PurchasePlaceKey> PurchasePlace { get; private set; }

        public HashSet<string> StudioAndMediaCompany { get; private set; }

        public HashSet<string> Subtitle { get; private set; }

        public HashSet<TagKey> Tag { get; private set; }

        public HashSet<UserKey> User { get; private set; }

        public HashSet<Profiler.VideoStandard> VideoStandard { get; private set; }

        public CollectionCache(IEnumerable<Profiler.DVD> profiles)
        {
            _profiles = profiles;

            DVDIdType = FillStaticHashSet<Profiler.DVDID_Type>();

            EventType = FillStaticHashSet<Profiler.EventType>();

            LinkCategory = FillStaticHashSet<Profiler.CategoryRestriction>();

            VideoStandard = FillStaticHashSet<Profiler.VideoStandard>();

            FillDynamicHash();
        }

        private HashSet<T> FillStaticHashSet<T>() where T : Enum
        {
            var fieldInfos = typeof(T).GetFields(BindingFlags.Public | BindingFlags.Static);

            var hash = new HashSet<T>();

            if (fieldInfos == null)
            {
                return hash;
            }

            foreach (var fieldInfo in fieldInfos)
            {
                hash.Add((T)(fieldInfo.GetRawConstantValue()));
            }

            return hash;
        }

        private void FillDynamicHash()
        {
            InitializeHashes();

            if (_profiles == null)
            {
                return;
            }

            var valid = _profiles.Where(IsNotNull).Where(dvd => !string.IsNullOrEmpty(dvd.ID)).ToList();

            foreach (var profile in valid)
            {
                FillAudioHashes(profile.AudioList);
                FillCollectionTypeHash(profile.CollectionType);
                FillCaseTypeHash(profile.CaseType);
                FillCastHash(profile.CastList);
                FillStringHashSet(CountryOfOrigin, profile.CountryOfOriginList);

                var crewMembers = profile.CrewList?.OfType<Profiler.CrewMember>() ?? Enumerable.Empty<Profiler.CrewMember>();

                FillCreditTypeAndSubtypeHash(crewMembers);
                FillCrewHash(crewMembers);
                FillStringHashSet(Genre, profile.GenreList);

                Locality.Add(new LocalityKey(profile));

                FillStringHashSet(StudioAndMediaCompany, profile.MediaCompanyList);
                FillMediaTypeHash(profile.MediaTypes);
                FillPluginDataHash(profile.PluginCustomData);
                FillPurchasePlaceHash(profile.PurchaseInfo);
                FillStringHashSet(StudioAndMediaCompany, profile.StudioList);
                FillStringHashSet(Subtitle, profile.SubtitleList);
                FillTagHash(profile.TagList);
                FillUserHashFromEvents(profile.EventList);
                FillUserHashFromLoanInfo(profile.LoanInfo);
            }

            foreach (var dvd in valid)
            {
                //second iteration for data that is less complete
                FillUserHashFromPurchaseInfo(dvd.PurchaseInfo);
            }
        }

        private void InitializeHashes()
        {
            AudioChannels = new HashSet<string>();
            AudioContent = new HashSet<string>();
            AudioFormat = new HashSet<string>();
            CaseType = new HashSet<string>();
            CastAndCrew = new HashSet<PersonKey>();
            CollectionType = new HashSet<Profiler.CollectionType>();
            CountryOfOrigin = new HashSet<string>();
            CreditType = new HashSet<string>();
            CreditSubtype = new Dictionary<string, HashSet<string>>();
            Genre = new HashSet<string>();
            Locality = new HashSet<LocalityKey>();
            MediaType = new HashSet<string>();
            PluginData = new HashSet<PluginDataKey>();
            PurchasePlace = new HashSet<PurchasePlaceKey>();
            StudioAndMediaCompany = new HashSet<string>();
            Subtitle = new HashSet<string>();
            Tag = new HashSet<TagKey>();
            User = new HashSet<UserKey>();
        }

        private void FillAudioHashes(IEnumerable<Profiler.AudioTrack> audioTracks)
        {
            if (audioTracks == null)
            {
                return;
            }

            var valid = audioTracks.Where(IsNotNull);

            foreach (var audioTrack in valid)
            {
                AudioContent.Add(audioTrack.Content);

                if (!string.IsNullOrEmpty(audioTrack.Format))
                {
                    AudioFormat.Add(audioTrack.Format);
                }

                if (!string.IsNullOrEmpty(audioTrack.Channels))
                {
                    AudioChannels.Add(audioTrack.Channels);
                }
            }
        }

        private void FillCollectionTypeHash(Profiler.CollectionType collectionType)
        {
            if (collectionType == null)
            {
                throw new ArgumentNullException(nameof(collectionType));
            }

            CollectionType.Add(collectionType);
        }

        private void FillCaseTypeHash(string caseType)
        {
            if (!string.IsNullOrEmpty(caseType))
            {
                CaseType.Add(caseType);
            }
        }

        private void FillCastHash(IEnumerable<object> castList)
        {
            if (castList == null)
            {
                return;
            }

            var valid = castList.OfType<Profiler.CastMember>();

            foreach (var castMember in valid)
            {
                CastAndCrew.Add(new PersonKey(castMember));
            }
        }

        private void FillCreditTypeAndSubtypeHash(IEnumerable<Profiler.CrewMember> crewMembers)
        {
            foreach (var crewMember in crewMembers)
            {
                FillCreditTypeAndSubtypeHash(crewMember.CreditType ?? string.Empty, crewMember.CreditSubtype ?? string.Empty);
            }
        }

        private void FillCrewHash(IEnumerable<Profiler.CrewMember> crewMembers)
        {
            foreach (var crewMember in crewMembers)
            {
                CastAndCrew.Add(new PersonKey(crewMember));
            }
        }

        private void FillMediaTypeHash(Profiler.MediaTypes mediaTypes)
        {
            if (mediaTypes == null)
            {
                return;
            }

            if (mediaTypes.DVD)
            {
                MediaType.Add("DVD");
            }

            if (mediaTypes.BluRay)
            {
                MediaType.Add("Blu-ray");
            }

            if (mediaTypes.HDDVD)
            {
                MediaType.Add("HD-DVD");
            }

            if (mediaTypes.UltraHD)
            {
                MediaType.Add("Ultra HD");
            }

            if (!string.IsNullOrEmpty(mediaTypes.CustomMediaType))
            {
                MediaType.Add(mediaTypes.CustomMediaType);
            }
        }

        private void FillPluginDataHash(IEnumerable<Profiler.PluginData> pluginDataList)
        {
            if (pluginDataList == null)
            {
                return;
            }

            var valdi = pluginDataList.Where(IsNotNull);

            foreach (var pluginData in valdi)
            {
                PluginData.Add(new PluginDataKey(pluginData));
            }
        }

        private void FillPurchasePlaceHash(Profiler.PurchaseInfo purchaseInfo)
        {
            if (purchaseInfo == null)
            {
                return;
            }

            if (!string.IsNullOrEmpty(purchaseInfo.Place))
            {
                PurchasePlace.Add(new PurchasePlaceKey(purchaseInfo));
            }
        }

        private void FillTagHash(IEnumerable<Profiler.Tag> tags)
        {
            if (tags == null)
            {
                return;
            }

            var valid = tags.Where(IsNotNull);

            foreach (var tag in tags)
            {
                Tag.Add(new TagKey(tag));
            }
        }

        private void FillUserHashFromEvents(IEnumerable<Profiler.Event> events)
        {
            if (events == null)
            {
                return;
            }

            var valid = events.Where(IsNotNull);

            foreach (var anEvent in valid)
            {
                var user = anEvent.User;

                if (UserKey.IsInvalid(user))
                {
                    throw new ArgumentNullException(nameof(user), "An event has no user assigned.");
                }

                User.Add(new UserKey(user));
            }
        }

        private void FillUserHashFromLoanInfo(Profiler.LoanInfo loanInfo)
        {
            if (loanInfo == null)
            {
                return;
            }

            TryAddUser(loanInfo.User);
        }

        private void FillUserHashFromPurchaseInfo(Profiler.PurchaseInfo purchaseInfo)
        {
            if (purchaseInfo == null || !purchaseInfo.ReceivedAsGift)
            {
                return;
            }

            TryAddUser(purchaseInfo.GiftFrom);
        }

        private static void FillStringHashSet(HashSet<string> hashSet, IEnumerable<string> values)
        {
            if (values == null)
            {
                return;
            }

            var valid = values.Where(IsNotEmpty);

            foreach (var value in valid)
            {
                hashSet.Add(value);
            }
        }

        private static bool IsNotEmpty(string value) => !string.IsNullOrWhiteSpace(value);

        private static bool IsNotNull(object value) => value != null;

        private void FillCreditTypeAndSubtypeHash(string creditType, string creditSubtype)
        {
            if (CreditType.Contains(creditType) == false)
            {
                CreditType.Add(creditType);

                CreditSubtype.Add(creditType, new HashSet<string>());
            }

            var creditSubTypes = CreditSubtype[creditType];

            if (creditSubTypes.Contains(creditSubtype) == false)
            {
                creditSubTypes.Add(creditSubtype);
            }
        }

        private void TryAddUser(Profiler.User user)
        {
            if (UserKey.IsInvalid(user))
            {
                return;
            }

            User.Add(new UserKey(user));
        }
    }
}