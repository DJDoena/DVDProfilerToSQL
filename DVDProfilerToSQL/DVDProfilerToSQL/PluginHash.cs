using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class PluginHash : Hash<PluginKey>
    {
        internal void Add(PluginData pluginData)
        {
            Add(new PluginKey(pluginData));
        }

        internal bool ContainsKey(PluginData pluginData) => ContainsKey(new PluginKey(pluginData));
    }
}