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
            this.tDVDxAudio = new HashSet<tDVDxAudio>();
            this.tDVDxCast = new HashSet<tDVDxCast>();
            this.tParentDVDxChildDVD = new HashSet<tParentDVDxChildDVD>();
            this.tDVDxCountryOfOrigin = new HashSet<tDVDxCountryOfOrigin>();
            this.tDVDxCrew = new HashSet<tDVDxCrew>();
            this.tDVDxDisc = new HashSet<tDVDxDisc>();
            this.tDVDxEvent = new HashSet<tDVDxEvent>();
            this.tDVDxGenre = new HashSet<tDVDxGenre>();
            this.tDVDxMyLinks = new HashSet<tDVDxMyLinks>();
            this.tDVDxMediaCompany = new HashSet<tDVDxMediaCompany>();
            this.tDVDxMediaType = new HashSet<tDVDxMediaType>();
            this.tParentDVDxChildDVD1 = new HashSet<tParentDVDxChildDVD>();
            this.tDVDxPluginData = new HashSet<tDVDxPluginData>();
            this.tDVDxRegion = new HashSet<tDVDxRegion>();
            this.tDVDxStudio = new HashSet<tDVDxStudio>();
            this.tDVDxSubtitle = new HashSet<tDVDxSubtitle>();
            this.tDVDxTag = new HashSet<tDVDxTag>();
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
        public int CaseTypeId { get; set; }
        public bool CaseSlipCover { get; set; }
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
        public virtual tDigitalDownloadInfo tDigitalDownloadInfo { get; set; }
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
        public virtual tDVDId tDVDId { get; set; }
        public virtual tEnhancedFeatures tEnhancedFeatures { get; set; }
        public virtual tEnhancedNotes tEnhancedNotes { get; set; }
        public virtual tEnhancedPurchaseInfo tEnhancedPurchaseInfo { get; set; }
        public virtual tEnhancedTitles tEnhancedTitles { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxEvent> tDVDxEvent { get; set; }
        public virtual tFeatures tFeatures { get; set; }
        public virtual tFormat tFormat { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxGenre> tDVDxGenre { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxMyLinks> tDVDxMyLinks { get; set; }
        public virtual tLoanInfo tLoanInfo { get; set; }
        public virtual tLock tLock { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxMediaCompany> tDVDxMediaCompany { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxMediaType> tDVDxMediaType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tParentDVDxChildDVD> tParentDVDxChildDVD1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxPluginData> tDVDxPluginData { get; set; }
        public virtual tPurchase tPurchase { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxRegion> tDVDxRegion { get; set; }
        public virtual tReview tReview { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxStudio> tDVDxStudio { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxSubtitle> tDVDxSubtitle { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxTag> tDVDxTag { get; set; }
    }
}
