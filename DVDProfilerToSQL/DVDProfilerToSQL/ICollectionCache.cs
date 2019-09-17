using System.Collections.Generic;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal interface ICollectionCache
    {
        Hash<string> AudioChannels { get; }

        Hash<string> AudioContent { get; }
        
        Hash<string> AudioFormat { get; }

        Hash<string> CaseType { get; }

        PersonHash CastAndCrew { get; }

        Hash<CollectionType> CollectionType { get; }

        Hash<string> CountryOfOrigin { get; }

        Dictionary<string, Hash<string>> CreditSubtype { get; }

        Hash<string> CreditType { get; }

        Hash<DVDID_Type> DVDIdType { get; }

        Hash<EventType> EventType { get; }

        Hash<string> Genre { get; }

        Hash<CategoryRestriction> LinkCategory { get; }

        Hash<LocalityKey> Locality { get; }

        Hash<string> MediaType { get; }

        PluginHash PluginData { get; }

        Hash<PurchasePlaceKey> PurchasePlace { get; }

        Hash<string> StudioAndMediaCompany { get; }

        Hash<string> Subtitle { get; }

        TagHash Tag { get; }

        UserHash User { get; }

        Hash<VideoStandard> VideoStandard { get; }
    }
}