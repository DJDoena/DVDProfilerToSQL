using System.Collections.Generic;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using Collection = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal interface IBaseData
    {
        Dictionary<string, Entity.tAudioChannels> AudioChannels { get; }

        Dictionary<string, Entity.tAudioContent> AudioContent { get; }

        Dictionary<string, Entity.tAudioFormat> AudioFormat { get; }

        Dictionary<string, Entity.tCaseType> CaseType { get; }

        Dictionary<PersonKey, Entity.tCastAndCrew> CastAndCrew { get; }

        Dictionary<Collection.CollectionType, Entity.tCollectionType> CollectionType { get; }

        Dictionary<string, Entity.tCountryOfOrigin> CountryOfOrigin { get; }

        Dictionary<Collection.DVDID_Type, Entity.tDVDIdType> DVDIdType { get; }

        Dictionary<Collection.EventType, Entity.tEventType> EventType { get; }

        Dictionary<string, Entity.tCreditType> CreditType { get; }

        Dictionary<string, Dictionary<string, Entity.tCreditSubtype>> CreditSubtype { get; }

        Dictionary<string, Entity.tGenre> Genre { get; }

        Dictionary<Collection.CategoryRestriction, Entity.tLinkCategory> LinkCategory { get; }

        Dictionary<LocalityKey, Entity.tLocality> Locality { get; }

        Dictionary<string, Entity.tMediaType> MediaType { get; }

        Dictionary<PluginDataKey, Entity.tPluginData> PluginData { get; }

        Dictionary<PurchasePlaceKey, Entity.tPurchasePlace> PurchasePlace { get; }

        Dictionary<string, Entity.tStudioAndMediaCompany> StudioAndMediaCompany { get; }

        Dictionary<string, Entity.tSubtitle> Subtitle { get; }

        Dictionary<TagKey, Entity.tTag> Tag { get; }

        Dictionary<UserKey, Entity.tUser> User { get; }

        Dictionary<Collection.VideoStandard, Entity.tVideoStandard> VideoStandard { get; }
    }
}