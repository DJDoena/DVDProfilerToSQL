using System.Collections.Generic;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal interface ICollectionCache
    {
        HashSet<string> AudioChannels { get; }

        HashSet<string> AudioContent { get; }

        HashSet<string> AudioFormat { get; }

        HashSet<string> CaseType { get; }

        HashSet<PersonKey> CastAndCrew { get; }

        HashSet<Profiler.CollectionType> CollectionType { get; }

        HashSet<string> CountryOfOrigin { get; }

        HashSet<string> CreditType { get; }

        Dictionary<string, HashSet<string>> CreditSubtype { get; }

        HashSet<Profiler.DVDID_Type> DVDIdType { get; }

        HashSet<Profiler.EventType> EventType { get; }

        HashSet<string> Genre { get; }

        HashSet<Profiler.CategoryRestriction> LinkCategory { get; }

        HashSet<LocalityKey> Locality { get; }

        HashSet<string> MediaType { get; }

        HashSet<PluginDataKey> PluginData { get; }

        HashSet<PurchasePlaceKey> PurchasePlace { get; }

        HashSet<string> StudioAndMediaCompany { get; }

        HashSet<string> Subtitle { get; }

        HashSet<TagKey> Tag { get; }

        HashSet<UserKey> User { get; }

        HashSet<Profiler.VideoStandard> VideoStandard { get; }
    }
}