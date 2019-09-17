using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class UserHash : Hash<UserKey>
    {
        internal void Add(User user)
        {
            Add(new UserKey(user));
        }

        internal bool ContainsKey(User user) => ContainsKey(new UserKey(user));
    }
}