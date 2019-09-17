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
    
    public partial class tFormat
    {
        public int FormatId { get; set; }
        public string DVDId { get; set; }
        public string AspectRatio { get; set; }
        public Nullable<int> VideoStandardId { get; set; }
        public bool LetterBox { get; set; }
        public bool PanAndScan { get; set; }
        public bool FullFrame { get; set; }
        public bool C16X9 { get; set; }
        public bool DualSided { get; set; }
        public bool DualLayered { get; set; }
        public bool Color { get; set; }
        public bool BlackAndWhite { get; set; }
        public bool Colorized { get; set; }
        public bool Mixed { get; set; }
        public bool C2D { get; set; }
        public bool C3DAnaglyph { get; set; }
        public bool C3DBluRay { get; set; }
        public Nullable<bool> HDR10 { get; set; }
        public Nullable<bool> DolbyVision { get; set; }
    
        public virtual tDVD tDVD { get; set; }
        public virtual tVideoStandard tVideoStandard { get; set; }
    }
}
