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
    
    public partial class tDVDId
    {
        public string DVDId { get; set; }
        public string IdBase { get; set; }
        public short VariantNum { get; set; }
        public short LocalityNum { get; set; }
        public int LocalityId { get; set; }
        public int IdType { get; set; }
    
        public virtual tDVD tDVD { get; set; }
        public virtual tLocality tLocality { get; set; }
        public virtual tDVDIdType tDVDIdType { get; set; }
    }
}
