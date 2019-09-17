using System.Collections.Generic;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;
using DoenaSoft.DVDProfiler.SQLDatabase;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal interface IBaseData
    {
        Dictionary<string, tAudioChannels> AudioChannels { get; }

        Dictionary<string, tAudioContent> AudioContent { get; }

        Dictionary<string, tAudioFormat> AudioFormat { get; }

        Dictionary<string, tCaseType> CaseType { get; }

        Dictionary<PersonKey, tCastAndCrew> CastAndCrew { get; }

        Dictionary<CollectionType, tCollectionType> CollectionType { get; }

        Dictionary<string, tCountryOfOrigin> CountryOfOrigin { get; }

        Dictionary<string, Dictionary<string, tCreditSubtype>> CreditSubtype { get; }

        Dictionary<string, tCreditType> CreditType { get; }

        Dictionary<DVDID_Type, tDVDIdType> DVDIdType { get; }

        Dictionary<EventType, tEventType> EventType { get; }

        Dictionary<string, tGenre> Genre { get; }

        Dictionary<CategoryRestriction, tLinkCategory> LinkCategory { get; }

        Dictionary<LocalityKey, tLocality> Locality { get; }

        Dictionary<string, tMediaType> MediaType { get; }

        Dictionary<PluginKey, tPluginData> PluginData { get; }

        Dictionary<PurchasePlaceKey, tPurchasePlace> PurchasePlace { get; }

        Dictionary<string, tStudioAndMediaCompany> StudioAndMediaCompany { get; }

        Dictionary<string, tSubtitle> Subtitle { get; }

        Dictionary<TagKey, tTag> Tag { get; }

        Dictionary<UserKey, tUser> User { get; }

        Dictionary<VideoStandard, tVideoStandard> VideoStandard { get; }
    }
}