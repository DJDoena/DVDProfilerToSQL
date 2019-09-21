using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using EPI = DoenaSoft.DVDProfiler.EnhancedPurchaseInfo;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancePurchaseInfoInserter
    {
        private static bool _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancePurchaseInfoInserter()
        {
            _metaDataWasCreated = false;
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

                Insert(epi);
            }
        }

        private void Insert(EPI.EnhancedPurchaseInfo epi)
        {
        }
    }
}