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
    
    public partial class vEnhancedPurchaseInfo
    {
        public string DVDId { get; set; }
        public string Title { get; set; }
        public string DistTrait { get; set; }
        public string CollectionType { get; set; }
        public string OriginalPriceDenomination { get; set; }
        public Nullable<decimal> OriginalPriceValue { get; set; }
        public string ShippingCostDenomination { get; set; }
        public Nullable<decimal> ShippingCostValue { get; set; }
        public string CreditCardChargeDenomination { get; set; }
        public Nullable<decimal> CreditCardChargeValue { get; set; }
        public string CreditCardFeesDenomination { get; set; }
        public Nullable<decimal> CreditCardFeesValue { get; set; }
        public string DiscountDenomination { get; set; }
        public Nullable<decimal> DiscountValue { get; set; }
        public string CustomsFeesDenomination { get; set; }
        public Nullable<decimal> CustomsFeesValue { get; set; }
        public string CouponType { get; set; }
        public string CouponCode { get; set; }
        public string AdditionalPrice1Denomination { get; set; }
        public Nullable<decimal> AdditionalPrice1Value { get; set; }
        public string AdditionalPrice2Denomination { get; set; }
        public Nullable<decimal> AdditionalPrice2Value { get; set; }
        public Nullable<System.DateTime> OrderDate { get; set; }
        public Nullable<System.DateTime> ShippingDate { get; set; }
        public Nullable<System.DateTime> DeliveryDate { get; set; }
        public Nullable<System.DateTime> AdditionalDate1 { get; set; }
        public Nullable<System.DateTime> AdditionalDate2 { get; set; }
    }
}
