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
    
    public partial class tEnhancedNotes
    {
        public int EnhancedNotesId { get; set; }
        public string DVDId { get; set; }
        public string Note1 { get; set; }
        public bool Note1isHtml { get; set; }
        public string Note2 { get; set; }
        public bool Note2isHtml { get; set; }
        public string Note3 { get; set; }
        public bool Note3isHtml { get; set; }
        public string Note4 { get; set; }
        public bool Note4isHtml { get; set; }
        public string Note5 { get; set; }
        public bool Note15sHtml { get; set; }
    
        public virtual tDVD tDVD { get; set; }
    }
}
