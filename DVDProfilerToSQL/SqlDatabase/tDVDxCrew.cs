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
    
    public partial class tDVDxCrew
    {
        public int DVDxCrewId { get; set; }
        public string DVDId { get; set; }
        public int OrderNumber { get; set; }
        public int CrewId { get; set; }
        public int CreditSubtypeId { get; set; }
        public string CreditedAs { get; set; }
        public string Episode { get; set; }
        public string Group { get; set; }
        public string CustomRole { get; set; }
    
        public virtual tCastAndCrew tCastAndCrew { get; set; }
        public virtual tCreditSubtype tCreditSubtype { get; set; }
        public virtual tDVD tDVD { get; set; }
    }
}
