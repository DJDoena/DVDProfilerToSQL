using System;
using System.Collections.Generic;
using System.Text;
using DoenaSoft.DVDProfiler.DVDProfilerHelper;
using EN = DoenaSoft.DVDProfiler.EnhancedNotes;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class EnhancedNotesInserter
    {
        private static readonly HashSet<string> _metaDataWasCreated;

        private readonly Entity.CollectionEntities _context;

        private readonly Entity.tDVD _currentDVDEntity;

        private readonly Profiler.PluginData _pluginData;

        static EnhancedNotesInserter()
        {
            _metaDataWasCreated = new HashSet<string>();
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

                InsertMetaData(en);

                InsertPluginData(en);
            }
        }

        private void InsertMetaData(EN.EnhancedNotes en)
        {
            TryInsertMetaData(en.Note1, "Note1");
            TryInsertMetaData(en.Note2, "Note2");
            TryInsertMetaData(en.Note3, "Note3");
            TryInsertMetaData(en.Note4, "Note4");
            TryInsertMetaData(en.Note5, "Note5");
        }

        private void TryInsertMetaData(EN.Text text, string key)
        {
            if (text != null && !_metaDataWasCreated.Contains(key))
            {
                var entity = new Entity.tEnhancedNotesMetaData()
                {
                    EnhancedNotesFieldName = key,
                    Description = GetDisplayName(text),
                };

                _context.tEnhancedNotesMetaData.Add(entity);

                _metaDataWasCreated.Add(key);
            }
        }

        private static string GetDisplayName(EN.Text text)
        {
            var result = string.IsNullOrEmpty(text.Base64DisplayName)
                ? text.DisplayName
                : Encoding.UTF8.GetString(Convert.FromBase64String(text.Base64DisplayName));

            return result;
        }

        private void InsertPluginData(EN.EnhancedNotes en)
        {
            var entity = new Entity.tEnhancedNotes()
            {
                tDVD = _currentDVDEntity,
                Note1 = GetNote(en.Note1),
                Note1isHtml = GetIsHtml(en.Note1),
                Note2 = GetNote(en.Note2),
                Note2isHtml = GetIsHtml(en.Note2),
                Note3 = GetNote(en.Note3),
                Note3isHtml = GetIsHtml(en.Note3),
                Note4 = GetNote(en.Note4),
                Note4isHtml = GetIsHtml(en.Note4),
                Note5 = GetNote(en.Note5),
                Note5isHtml = GetIsHtml(en.Note5),
            };

            _context.tEnhancedNotes.Add(entity);
        }

        private string GetNote(EN.Text text)
        {
            if (text == null)
            {
                return null;
            }

            var result = string.IsNullOrEmpty(text.Base64Note)
                    ? text.Value
                    : Encoding.UTF8.GetString(Convert.FromBase64String(text.Base64Note));

            return result;
        }

        private bool GetIsHtml(EN.Text note)
        {
            var result = note != null
                ? note.IsHtml
                : false;

            return result;
        }
    }
}