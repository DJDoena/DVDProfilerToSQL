using System.Collections.Generic;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal class Hash<TKey> : HashSet<TKey>
    {
        public bool ContainsKey(TKey key) => Contains(key);
    }
}