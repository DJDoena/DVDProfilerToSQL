using System;
using System.Collections.Generic;
using System.Text;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using ET = DoenaSoft.DVDProfiler.EnhancedTitles;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancedTitlesInserter
    {
        private static readonly HashSet<string> _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancedTitlesInserter()
        {
            _metaDataWasCreated = new HashSet<string>();
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

                InsertMetaData(et);

                InsertPluginData(et);
            }
        }

        private void InsertMetaData(ET.EnhancedTitles et)
        {
            TryInsertMetaData(et.InternationalEnglishTitle, "Title1");
            TryInsertMetaData(et.AlternateOriginalTitle, "Title2");
            TryInsertMetaData(et.NonLatinLettersTitle, "Title3");
            TryInsertMetaData(et.AdditionalTitle1, "Title4");
            TryInsertMetaData(et.AdditionalTitle2, "Title5");
        }

        private void TryInsertMetaData(ET.Text text, string key)
        {
            if (text != null && !_metaDataWasCreated.Contains(key))
            {
                var entity = new Entity.tEnhancedTitlesMetaData()
                {
                    EnhancedTitlesFieldName = key,
                    Description = GetDisplayName(text),
                };

                _context.tEnhancedTitlesMetaData.Add(entity);

                _metaDataWasCreated.Add(key);
            }
        }

        private static string GetDisplayName(ET.Text text)
        {
            var result = string.IsNullOrEmpty(text.Base64DisplayName)
                ? text.DisplayName
                : Encoding.UTF8.GetString(Convert.FromBase64String(text.Base64DisplayName));

            return result;
        }

        private void InsertPluginData(ET.EnhancedTitles et)
        {
            var entity = new Entity.tEnhancedTitles()
            {
                tDVD = _currentDVDEntity,
                Title1 = GetTitle(et.InternationalEnglishTitle),
                Title2 = GetTitle(et.AlternateOriginalTitle),
                Title3 = GetTitle(et.NonLatinLettersTitle),
                Title4 = GetTitle(et.AdditionalTitle1),
                Title5 = GetTitle(et.AdditionalTitle2),
            };

            _context.tEnhancedTitles.Add(entity);
        }

        private string GetTitle(ET.Text text)
        {
            if (text == null)
            {
                return null;
            }

            var result = string.IsNullOrEmpty(text.Base64Title)
                ? text.Value
                : Encoding.UTF8.GetString(Convert.FromBase64String(text.Base64Title));

            return result;
        }
    }
}