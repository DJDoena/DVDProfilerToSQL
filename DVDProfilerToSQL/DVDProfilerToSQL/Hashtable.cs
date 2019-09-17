using System.Collections.Generic;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal class Hashtable<TKey> : Dictionary<TKey, int>
    {
        internal Hashtable(int capacity)
            : base(capacity)
        {
        }

        internal void Add(TKey key)
        {
            Add(key, EntityProcessor.IdCounter++);
        }
    }
}