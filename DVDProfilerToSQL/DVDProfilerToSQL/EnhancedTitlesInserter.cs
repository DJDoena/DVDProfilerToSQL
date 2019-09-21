using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using ET = DoenaSoft.DVDProfiler.EnhancedTitles;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancedTitlesInserter
    {
        private static bool _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancedTitlesInserter()
        {
            _metaDataWasCreated = false;
        }

        public EnhancedTitlesInserter(Entity.CollectionEntities context, Entity.tDVD currentDVDEntity, Profiler.PluginData pluginData)
        {
            _context = context;
            _currentDVDEntity = currentDVDEntity;
            _pluginData = pluginData;
        }

        public void Insert()
        {
            if (_pluginData.Any?.Length == 1)
            {
                var et = DVDProfilerSerializer<ET.EnhancedTitles>.FromString(_pluginData.Any[0].OuterXml);

                Insert(et);
            }
        }

        private void Insert(ET.EnhancedTitles et)
        {

        }
    }
}