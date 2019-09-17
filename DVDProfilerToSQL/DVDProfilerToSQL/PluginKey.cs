using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class PluginKey
    {
        private readonly PluginData _pluginData;

        private readonly int _hashCode;

        internal PluginData PluginData
        {
            get
            {
                var pluginData = new PluginData()
                {
                    ClassID = _pluginData.ClassID,
                    Name = _pluginData.Name,
                };

                return pluginData;
            }
        }

        internal PluginKey(PluginData pluginData)
        {
            _pluginData = new PluginData()
            {
                ClassID = pluginData.ClassID,
                Name = pluginData.Name,
            };

            _hashCode = _pluginData.ClassID.GetHashCode();
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
                var equals = _pluginData.ClassID == other._pluginData.ClassID;

                return equals;
            }
        }
    }
}