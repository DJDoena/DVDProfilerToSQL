using System;
using System.Collections.Generic;
using System.Text;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using EPI = DoenaSoft.DVDProfiler.EnhancedPurchaseInfo;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancePurchaseInfoInserter
    {
        private static readonly HashSet<string> _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancePurchaseInfoInserter()
        {
            _metaDataWasCreated = new HashSet<string>();
        }

        public EnhancePurchaseInfoInserter(Entity.CollectionEntities context, Entity.tDVD currentDVDEntity, Profiler.PluginData pluginData)
        {
            _context = context;
            _currentDVDEntity = currentDVDEntity;
            _pluginData = pluginData;
        }

        public void Insert()
        {
            if (_pluginData.Any?.Length == 1)
            {
                var epi = DVDProfilerSerializer<EPI.EnhancedPurchaseInfo>.FromString(_pluginData.Any[0].OuterXml);

                InsertMetaData(epi);

                InsertPluginData(epi);
            }
        }

        private void InsertMetaData(EPI.EnhancedPurchaseInfo epi)
        {
            TryInsertMetaData(epi.OriginalPrice, "Price1");
            TryInsertMetaData(epi.ShippingCost, "Price2");
            TryInsertMetaData(epi.CreditCardCharge, "Price3");
            TryInsertMetaData(epi.CreditCardFees, "Price4");
            TryInsertMetaData(epi.Discount, "Price5");
            TryInsertMetaData(epi.CustomsFees, "Price6");
            TryInsertMetaData(epi.AdditionalPrice1, "Price7");
            TryInsertMetaData(epi.AdditionalPrice2, "Price8");

            TryInsertMetaData(epi.CouponCode, "CouponCode");
            TryInsertMetaData(epi.CouponType, "CouponType");

            TryInsertMetaData(epi.OrderDate, "Date1");
            TryInsertMetaData(epi.ShippingDate, "Date2");
            TryInsertMetaData(epi.DeliveryDate, "Date3");
            TryInsertMetaData(epi.AdditionalDate1, "Date4");
            TryInsertMetaData(epi.AdditionalDate2, "Date5");
        }

        private void TryInsertMetaData(EPI.Price price, string key)
        {
            if (price != null && !_metaDataWasCreated.Contains(key))
            {
                var entity = new Entity.tEnhancedPurchaseInfoMetaData()
                {
                    EnhancedPurchaseInfoFieldName = key,
                    Description = GetDisplayName(price),
                };

                _context.tEnhancedPurchaseInfoMetaData.Add(entity);

                _metaDataWasCreated.Add(key);
            }
        }

        private void TryInsertMetaData(EPI.Text text, string key)
        {
            if (text != null && !_metaDataWasCreated.Contains(key))
            {
                var entity = new Entity.tEnhancedPurchaseInfoMetaData()
                {
                    EnhancedPurchaseInfoFieldName = key,
                    Description = GetDisplayName(text),
                };

                _context.tEnhancedPurchaseInfoMetaData.Add(entity);

                _metaDataWasCreated.Add(key);
            }
        }

        private void TryInsertMetaData(EPI.Date date, string key)
        {
            if (date != null && !_metaDataWasCreated.Contains(key))
            {
                var entity = new Entity.tEnhancedPurchaseInfoMetaData()
                {
                    EnhancedPurchaseInfoFieldName = key,
                    Description = GetDisplayName(date),
                };

                _context.tEnhancedPurchaseInfoMetaData.Add(entity);

                _metaDataWasCreated.Add(key);
            }
        }

        private string GetDisplayName(EPI.Price price)
        {
            var result = string.IsNullOrEmpty(price.Base64DisplayName)
                ? price.DisplayName
                : Encoding.UTF8.GetString(Convert.FromBase64String(price.Base64DisplayName));

            return result;
        }

        private string GetDisplayName(EPI.Text text)
        {
            var result = string.IsNullOrEmpty(text.Base64DisplayName)
                ? text.DisplayName
                : Encoding.UTF8.GetString(Convert.FromBase64String(text.Base64DisplayName));

            return result;
        }

        private string GetDisplayName(EPI.Date date)
        {
            var result = string.IsNullOrEmpty(date.Base64DisplayName)
                ? date.DisplayName
                : Encoding.UTF8.GetString(Convert.FromBase64String(date.Base64DisplayName));

            return result;
        }

        private void InsertPluginData(EPI.EnhancedPurchaseInfo epi)
        {
            var entity = new Entity.tEnhancedPurchaseInfo()
            {
                tDVD = _currentDVDEntity,
                Price1Denomination = epi.OriginalPrice?.DenominationType,
                Price1Value = GetPriceValue(epi.OriginalPrice),
                Price2Denomination = epi.ShippingCost?.DenominationType,
                Price2Value = GetPriceValue(epi.ShippingCost),
                Price3Denomination = epi.CreditCardCharge?.DenominationType,
                Price3Value = GetPriceValue(epi.CreditCardCharge),
                Price4Denomination = epi.CreditCardFees?.DenominationType,
                Price4Value = GetPriceValue(epi.CreditCardFees),
                Price5Denomination = epi.Discount?.DenominationType,
                Price5Value = GetPriceValue(epi.Discount),
                Price6Denomination = epi.CustomsFees?.DenominationType,
                Price6Value = GetPriceValue(epi.CustomsFees),
                Price7Denomination = epi.AdditionalPrice1?.DenominationType,
                Price7Value = GetPriceValue(epi.AdditionalPrice1),
                Price8Denomination = epi.AdditionalPrice2?.DenominationType,
                Price8Value = GetPriceValue(epi.AdditionalPrice2),
                CouponCode = epi.CouponCode?.Value,
                CouponType = epi.CouponType?.Value,
                Date1 = epi.OrderDate?.Value,
                Date2 = epi.ShippingDate?.Value,
                Date3 = epi.DeliveryDate?.Value,
                Date4 = epi.AdditionalDate1?.Value,
                Date5 = epi.AdditionalDate2?.Value,
            };

            _context.tEnhancedPurchaseInfo.Add(entity);
        }

        private decimal? GetPriceValue(EPI.Price price)
        {
            var result = price != null
                ? (decimal)price.Value
                : (decimal?)null;

            return result;
        }
    }
}