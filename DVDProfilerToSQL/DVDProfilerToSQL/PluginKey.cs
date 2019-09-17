using System;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class PluginKey
    {
        private readonly int _hashCode;

        internal Guid ClassId { get; }

        internal string Name { get; }

        internal PluginKey(PluginData pluginData)
        {
            ClassId = Guid.Parse(pluginData.ClassID);

            Name = pluginData.Name;

            _hashCode = ClassId.GetHashCode();
        }

        public override int GetHashCode() => _hashCode;

        public override bool Equals(object obj)
        {
            if (!(obj is PluginKey other))
            {
                return false;
            }
            else
            {
                var equals = ClassId == other.ClassId;

                return equals;
            }
        }
    }
}