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
    
    public partial class tDVDxSubtitle
    {
        public int DVDxSubtitleId { get; set; }
        public string DVDId { get; set; }
        public int SubtitleId { get; set; }
    
        public virtual tSubtitle tSubtitle { get; set; }
        public virtual tDVD tDVD { get; set; }
    }
}
