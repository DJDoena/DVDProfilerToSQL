//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class tDVD
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tDVD()
        {
            this.tDigitalDownloadInfo = new HashSet<tDigitalDownloadInfo>();
            this.tDVDxAudio = new HashSet<tDVDxAudio>();
            this.tDVDxCast = new HashSet<tDVDxCast>();
            this.tParentDVDxChildDVD = new HashSet<tParentDVDxChildDVD>();
            this.tDVDxCountryOfOrigin = new HashSet<tDVDxCountryOfOrigin>();
            this.tDVDxCrew = new HashSet<tDVDxCrew>();
            this.tDVDxDisc = new HashSet<tDVDxDisc>();
            this.tEnhancedFeatures = new HashSet<tEnhancedFeatures>();
            this.tEnhancedNotes = new HashSet<tEnhancedNotes>();
            this.tEnhancedPurchaseInfo = new HashSet<tEnhancedPurchaseInfo>();
            this.tEnhancedTitles = new HashSet<tEnhancedTitles>();
            this.tDVDxEvent = new HashSet<tDVDxEvent>();
            this.tFeatures = new HashSet<tFeatures>();
            this.tFormat = new HashSet<tFormat>();
            this.tDVDxGenre = new HashSet<tDVDxGenre>();
            this.tDVDxMyLinks = new HashSet<tDVDxMyLinks>();
            this.tLoanInfo = new HashSet<tLoanInfo>();
            this.tLock = new HashSet<tLock>();
            this.tDVDxMediaCompany = new HashSet<tDVDxMediaCompany>();
            this.tDVDxMediaType = new HashSet<tDVDxMediaType>();
            this.tParentDVDxChildDVD1 = new HashSet<tParentDVDxChildDVD>();
            this.tDVDxPluginData = new HashSet<tDVDxPluginData>();
            this.tPurchase = new HashSet<tPurchase>();
            this.tDVDxRegion = new HashSet<tDVDxRegion>();
            this.tReview = new HashSet<tReview>();
            this.tDVDxStudio = new HashSet<tDVDxStudio>();
            this.tDVDxSubtitle = new HashSet<tDVDxSubtitle>();
            this.tDVDxTag = new HashSet<tDVDxTag>();
            this.tDVDId = new HashSet<tDVDId>();
        }
    
        public string DVDId { get; set; }
        public string UPC { get; set; }
        public string CollectionNumber { get; set; }
        public int CollectionTypeId { get; set; }
        public string Title { get; set; }
        public string DistTrait { get; set; }
        public string OriginalTitle { get; set; }
        public Nullable<int> ProductionYear { get; set; }
        public Nullable<System.DateTime> Released { get; set; }
        public Nullable<int> RunningTime { get; set; }
        public string Rating { get; set; }
        public Nullable<int> CaseTypeId { get; set; }
        public Nullable<bool> CaseSlipCover { get; set; }
        public string SRPDenomination { get; set; }
        public Nullable<decimal> SRPValue { get; set; }
        public string Overview { get; set; }
        public string EasterEggs { get; set; }
        public string SortTitle { get; set; }
        public Nullable<System.DateTime> LastEdited { get; set; }
        public int WishPriority { get; set; }
        public string Notes { get; set; }
    
        public virtual tCaseType tCaseType { get; set; }
        public virtual tCollectionType tCollectionType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDigitalDownloadInfo> tDigitalDownloadInfo { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxAudio> tDVDxAudio { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxCast> tDVDxCast { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tParentDVDxChildDVD> tParentDVDxChildDVD { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxCountryOfOrigin> tDVDxCountryOfOrigin { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxCrew> tDVDxCrew { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxDisc> tDVDxDisc { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tEnhancedFeatures> tEnhancedFeatures { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tEnhancedNotes> tEnhancedNotes { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tEnhancedPurchaseInfo> tEnhancedPurchaseInfo { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tEnhancedTitles> tEnhancedTitles { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxEvent> tDVDxEvent { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tFeatures> tFeatures { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tFormat> tFormat { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxGenre> tDVDxGenre { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxMyLinks> tDVDxMyLinks { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tLoanInfo> tLoanInfo { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tLock> tLock { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxMediaCompany> tDVDxMediaCompany { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxMediaType> tDVDxMediaType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tParentDVDxChildDVD> tParentDVDxChildDVD1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxPluginData> tDVDxPluginData { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tPurchase> tPurchase { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxRegion> tDVDxRegion { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tReview> tReview { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxStudio> tDVDxStudio { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxSubtitle> tDVDxSubtitle { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxTag> tDVDxTag { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDId> tDVDId { get; set; }
    }
}