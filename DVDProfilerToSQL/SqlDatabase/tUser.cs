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
    
    public partial class tUser
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tUser()
        {
            this.tDVDxEvent = new HashSet<tDVDxEvent>();
            this.tLoanInfo = new HashSet<tLoanInfo>();
            this.tPurchase = new HashSet<tPurchase>();
        }
    
        public int UserId { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string EMailAddress { get; set; }
        public string PhoneNumber { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tDVDxEvent> tDVDxEvent { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tLoanInfo> tLoanInfo { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tPurchase> tPurchase { get; set; }
    }
}
