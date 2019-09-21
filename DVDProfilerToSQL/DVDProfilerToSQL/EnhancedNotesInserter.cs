using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using EN = DoenaSoft.DVDProfiler.EnhancedNotes;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancedNotesInserter
    {
        private static bool _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancedNotesInserter()
        {
            _metaDataWasCreated = false;
        }

        public EnhancedNotesInserter(Entity.CollectionEntities context, Entity.tDVD currentDVDEntity, Profiler.PluginData pluginData)
        {
            _context = context;
            _currentDVDEntity = currentDVDEntity;
            _pluginData = pluginData;
        }

        public void Insert()
        {
            if (_pluginData.Any?.Length == 1)
            {
                var en = DVDProfilerSerializer<EN.EnhancedNotes>.FromString(_pluginData.Any[0].OuterXml);

                Insert(en);
            }
        }

        private void Insert(EN.EnhancedNotes en)
        {

        }
    }
}