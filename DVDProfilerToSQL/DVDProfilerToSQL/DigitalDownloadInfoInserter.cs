using System;
using System.Text;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using DDI = DoenaSoft.DVDProfiler.DigitalDownloadInfo;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class DigitalDownloadInfoInserter
    {
        private static bool _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static DigitalDownloadInfoInserter()
        {
            _metaDataWasCreated = false;
        }

        public DigitalDownloadInfoInserter(Entity.CollectionEntities context, Entity.tDVD currentDVDEntity, Profiler.PluginData pluginData)
        {
            _context = context;
            _currentDVDEntity = currentDVDEntity;
            _pluginData = pluginData;
        }

        public void Insert()
        {
            if (_pluginData.Any?.Length == 1)
            {
                var ddi = DVDProfilerSerializer<DDI.DigitalDownloadInfo>.FromString(_pluginData.Any[0].OuterXml);

                Insert(ddi);
            }
        }

        private void Insert(DDI.DigitalDownloadInfo ddi)
        {
            var entity = new Entity.tDigitalDownloadInfo()
            {
                tDVD = _currentDVDEntity,
                Company = GetText(ddi.Company),
                Code = GetText(ddi.Code),
            };

            _context.tDigitalDownloadInfo.Add(entity);
        }

        private static string GetText(DDI.Text text)
        {
            if (text != null)
            {
                var result = string.IsNullOrEmpty(text.Base64Text)
                    ? text.Value
                    : Encoding.UTF8.GetString(Convert.FromBase64String(text.Base64Text));

                return result;
            }
            else
            {
                return null;
            }
        }
    }
}