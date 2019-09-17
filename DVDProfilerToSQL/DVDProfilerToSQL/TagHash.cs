using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class TagHash : Hash<TagKey>
    {
        internal void Add(Tag tag)
        {
            Add(new TagKey(tag));
        }

        internal bool ContainsKey(Tag tag) => ContainsKey(new TagKey(tag));
    }
}