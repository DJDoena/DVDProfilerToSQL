﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DoenaSoft.DVDProfiler.SQLDatabase
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class CollectionEntities : DbContext
    {
        public CollectionEntities()
            : base("name=CollectionEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tAudioChannels> tAudioChannels { get; set; }
        public virtual DbSet<tAudioContent> tAudioContent { get; set; }
        public virtual DbSet<tAudioFormat> tAudioFormat { get; set; }
        public virtual DbSet<tCaseType> tCaseType { get; set; }
        public virtual DbSet<tCastAndCrew> tCastAndCrew { get; set; }
        public virtual DbSet<tCollectionType> tCollectionType { get; set; }
        public virtual DbSet<tCountryOfOrigin> tCountryOfOrigin { get; set; }
        public virtual DbSet<tCreditSubtype> tCreditSubtype { get; set; }
        public virtual DbSet<tCreditType> tCreditType { get; set; }
        public virtual DbSet<tDBVersion> tDBVersion { get; set; }
        public virtual DbSet<tDigitalDownloadInfo> tDigitalDownloadInfo { get; set; }
        public virtual DbSet<tDVDId> tDVDId { get; set; }
        public virtual DbSet<tDVDIdType> tDVDIdType { get; set; }
        public virtual DbSet<tDVDxAudio> tDVDxAudio { get; set; }
        public virtual DbSet<tDVDxCountryOfOrigin> tDVDxCountryOfOrigin { get; set; }
        public virtual DbSet<tDVDxDisc> tDVDxDisc { get; set; }
        public virtual DbSet<tDVDxEvent> tDVDxEvent { get; set; }
        public virtual DbSet<tDVDxGenre> tDVDxGenre { get; set; }
        public virtual DbSet<tDVDxMediaCompany> tDVDxMediaCompany { get; set; }
        public virtual DbSet<tDVDxMediaType> tDVDxMediaType { get; set; }
        public virtual DbSet<tDVDxMyLinks> tDVDxMyLinks { get; set; }
        public virtual DbSet<tDVDxPluginData> tDVDxPluginData { get; set; }
        public virtual DbSet<tDVDxRegion> tDVDxRegion { get; set; }
        public virtual DbSet<tDVDxStudio> tDVDxStudio { get; set; }
        public virtual DbSet<tDVDxSubtitle> tDVDxSubtitle { get; set; }
        public virtual DbSet<tDVDxTag> tDVDxTag { get; set; }
        public virtual DbSet<tEnhancedFeatures> tEnhancedFeatures { get; set; }
        public virtual DbSet<tEnhancedNotes> tEnhancedNotes { get; set; }
        public virtual DbSet<tEnhancedTitles> tEnhancedTitles { get; set; }
        public virtual DbSet<tEventType> tEventType { get; set; }
        public virtual DbSet<tFeatures> tFeatures { get; set; }
        public virtual DbSet<tFormat> tFormat { get; set; }
        public virtual DbSet<tGenre> tGenre { get; set; }
        public virtual DbSet<tLinkCategory> tLinkCategory { get; set; }
        public virtual DbSet<tLoanInfo> tLoanInfo { get; set; }
        public virtual DbSet<tLocality> tLocality { get; set; }
        public virtual DbSet<tLock> tLock { get; set; }
        public virtual DbSet<tMediaType> tMediaType { get; set; }
        public virtual DbSet<tParentDVDxChildDVD> tParentDVDxChildDVD { get; set; }
        public virtual DbSet<tPluginData> tPluginData { get; set; }
        public virtual DbSet<tPurchase> tPurchase { get; set; }
        public virtual DbSet<tPurchasePlace> tPurchasePlace { get; set; }
        public virtual DbSet<tReview> tReview { get; set; }
        public virtual DbSet<tStudioAndMediaCompany> tStudioAndMediaCompany { get; set; }
        public virtual DbSet<tSubtitle> tSubtitle { get; set; }
        public virtual DbSet<tTag> tTag { get; set; }
        public virtual DbSet<tUser> tUser { get; set; }
        public virtual DbSet<tVideoStandard> tVideoStandard { get; set; }
        public virtual DbSet<vCastGrouped> vCastGrouped { get; set; }
        public virtual DbSet<vCollectionTypeGrouped> vCollectionTypeGrouped { get; set; }
        public virtual DbSet<vDigitalDownloadInfo> vDigitalDownloadInfo { get; set; }
        public virtual DbSet<vDVD> vDVD { get; set; }
        public virtual DbSet<vDVDId> vDVDId { get; set; }
        public virtual DbSet<vDVDxAudio> vDVDxAudio { get; set; }
        public virtual DbSet<vDVDxCountryOfOrigin> vDVDxCountryOfOrigin { get; set; }
        public virtual DbSet<vDVDxDisc> vDVDxDisc { get; set; }
        public virtual DbSet<vDVDxEvent> vDVDxEvent { get; set; }
        public virtual DbSet<vDVDxGenre> vDVDxGenre { get; set; }
        public virtual DbSet<vDVDxMediaCompany> vDVDxMediaCompany { get; set; }
        public virtual DbSet<vDVDxPluginData> vDVDxPluginData { get; set; }
        public virtual DbSet<vDVDxRegion> vDVDxRegion { get; set; }
        public virtual DbSet<vDVDxStudio> vDVDxStudio { get; set; }
        public virtual DbSet<vDVDxTag> vDVDxTag { get; set; }
        public virtual DbSet<vEnhancedFeatures> vEnhancedFeatures { get; set; }
        public virtual DbSet<vEnhancedNotes> vEnhancedNotes { get; set; }
        public virtual DbSet<vEnhancedTitles> vEnhancedTitles { get; set; }
        public virtual DbSet<vFeatures> vFeatures { get; set; }
        public virtual DbSet<vFormat> vFormat { get; set; }
        public virtual DbSet<vGenreGrouped> vGenreGrouped { get; set; }
        public virtual DbSet<vLoanInfo> vLoanInfo { get; set; }
        public virtual DbSet<vLock> vLock { get; set; }
        public virtual DbSet<vMediaCompanyGrouped> vMediaCompanyGrouped { get; set; }
        public virtual DbSet<vParentChildDVD> vParentChildDVD { get; set; }
        public virtual DbSet<vPurchase> vPurchase { get; set; }
        public virtual DbSet<vReview> vReview { get; set; }
        public virtual DbSet<vStudioGrouped> vStudioGrouped { get; set; }
        public virtual DbSet<vTagGrouped> vTagGrouped { get; set; }
        public virtual DbSet<tDVDxCast> tDVDxCast { get; set; }
        public virtual DbSet<tDVDxCrew> tDVDxCrew { get; set; }
        public virtual DbSet<vDVDxCast> vDVDxCast { get; set; }
        public virtual DbSet<vDVDxCrew> vDVDxCrew { get; set; }
        public virtual DbSet<tExclusions> tExclusions { get; set; }
        public virtual DbSet<tDVD> tDVD { get; set; }
        public virtual DbSet<tEnhancedFeaturesMetaData> tEnhancedFeaturesMetaData { get; set; }
        public virtual DbSet<tEnhancedPurchaseInfo> tEnhancedPurchaseInfo { get; set; }
        public virtual DbSet<vEnhancedPurchaseInfo> vEnhancedPurchaseInfo { get; set; }
    }
}
