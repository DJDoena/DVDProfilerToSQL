using DoenaSoft.DVDProfiler.DVDProfilerXML;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class PersonHash : Hash<PersonKey>
    {
        internal void Add(IPerson person)
        {
            Add(new PersonKey(person));
        }

        internal bool ContainsKey(IPerson person) => ContainsKey(new PersonKey(person));
    }
}