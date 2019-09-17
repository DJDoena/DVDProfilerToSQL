using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class LocalityKey
    {
        internal int Id { get; }

        internal string Description { get; }

        internal LocalityKey(DVD dvd)
        {
            Id = dvd.ID_LocalityID;
            Description = dvd.ID_LocalityDesc;
        }

        public override int GetHashCode() => Id;

        public override bool Equals(object obj)
        {
            if (!(obj is LocalityKey other))
            {
                return false;
            }
            else
            {
                var equals = Id == other.Id;

                return equals;
            }
        }
    }
}