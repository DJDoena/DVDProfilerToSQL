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
    
    public partial class tDVDxPluginData
    {
        public int DVDxPluginDataId { get; set; }
        public string DVDId { get; set; }
        public int PluginDataId { get; set; }
        public string PluginData { get; set; }
    
        public virtual tPluginData tPluginData { get; set; }
        public virtual tDVD tDVD { get; set; }
    }
}
