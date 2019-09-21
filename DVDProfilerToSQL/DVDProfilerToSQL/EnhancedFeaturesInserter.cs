using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using EF = DoenaSoft.DVDProfiler.EnhancedFeatures;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancedFeaturesInserter
    {
        private static readonly HashSet<int> _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancedFeaturesInserter()
        {
            _metaDataWasCreated = new HashSet<int>();
        }

        public EnhancedFeaturesInserter(Entity.CollectionEntities context, Entity.tDVD currentDVDEntity, Profiler.PluginData pluginData)
        {
            _context = context;
            _currentDVDEntity = currentDVDEntity;
            _pluginData = pluginData;
        }

        public void Insert()
        {
            if (_pluginData.Any?.Length == 1)
            {
                var ef = DVDProfilerSerializer<EF.EnhancedFeatures>.FromString(_pluginData.Any[0].OuterXml);

                Insert(ef);
            }
        }

        private void Insert(EF.EnhancedFeatures ef)
        {
            var valid = ef.Feature?.Where(f => f != null).ToList();

            if (valid == null || valid.Count == 0)
            {
                return;
            }

            InsertMetaData(valid);

            InsertPluginData(valid);
        }

        private void InsertMetaData(IEnumerable<EF.Feature> features)
        {
            var filtered = features.Where(f => !_metaDataWasCreated.Contains(f.Index));

            foreach (var feature in filtered)
            {
                var entity = new Entity.tEnhancedFeaturesMetaData()
                {
                    EnhancedFeaturesFieldName = $"Feature{feature.Index}",
                    Description = GetDisplayName(feature),
                };

                _context.tEnhancedFeaturesMetaData.Add(entity);

                _metaDataWasCreated.Add(feature.Index);
            }
        }

        private static string GetDisplayName(EF.Feature feature)
        {
            if (feature != null)
            {
                var result = string.IsNullOrEmpty(feature.Base64DisplayName)
                    ? feature.DisplayName
                    : Encoding.UTF8.GetString(Convert.FromBase64String(feature.Base64DisplayName));

                return result;
            }
            else
            {
                return null;
            }
        }

        private void InsertPluginData(IEnumerable<EF.Feature> valid)
        {
            var entity = new Entity.tEnhancedFeatures()
            {
                tDVD = _currentDVDEntity,
                Feature1 = GetValue(valid, 1),
                Feature2 = GetValue(valid, 2),
                Feature3 = GetValue(valid, 3),
                Feature4 = GetValue(valid, 4),
                Feature5 = GetValue(valid, 5),
                Feature6 = GetValue(valid, 6),
                Feature7 = GetValue(valid, 7),
                Feature8 = GetValue(valid, 8),
                Feature9 = GetValue(valid, 9),
                Feature10 = GetValue(valid, 10),
                Feature11 = GetValue(valid, 11),
                Feature12 = GetValue(valid, 12),
                Feature13 = GetValue(valid, 13),
                Feature14 = GetValue(valid, 14),
                Feature15 = GetValue(valid, 15),
                Feature16 = GetValue(valid, 16),
                Feature17 = GetValue(valid, 17),
                Feature18 = GetValue(valid, 18),
                Feature19 = GetValue(valid, 19),
                Feature20 = GetValue(valid, 20),
                Feature21 = GetValue(valid, 21),
                Feature22 = GetValue(valid, 22),
                Feature23 = GetValue(valid, 23),
                Feature24 = GetValue(valid, 24),
                Feature25 = GetValue(valid, 25),
                Feature26 = GetValue(valid, 26),
                Feature27 = GetValue(valid, 27),
                Feature28 = GetValue(valid, 28),
                Feature29 = GetValue(valid, 29),
                Feature30 = GetValue(valid, 30),
                Feature31 = GetValue(valid, 31),
                Feature32 = GetValue(valid, 32),
                Feature33 = GetValue(valid, 33),
                Feature34 = GetValue(valid, 34),
                Feature35 = GetValue(valid, 35),
                Feature36 = GetValue(valid, 36),
                Feature37 = GetValue(valid, 37),
                Feature38 = GetValue(valid, 38),
                Feature39 = GetValue(valid, 39),
                Feature40 = GetValue(valid, 40),
            };

            _context.tEnhancedFeatures.Add(entity);
        }

        private static bool GetValue(IEnumerable<EF.Feature> features, int index)
        {
            var feature = features.FirstOrDefault(f => f.Index == index);

            var result = feature != null
                ? feature.Value
                : false;

            return result;
        }
    }
}