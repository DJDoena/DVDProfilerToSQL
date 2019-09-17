using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class TagKey
    {
        private readonly int _hashCode;

        internal string FullName { get; }

        internal string Name { get; }

        internal TagKey(Tag tag)
        {
            FullName = tag.FullName;
            Name = tag.Name;

            _hashCode = FullName.GetHashCode();
        }

        public override int GetHashCode() => _hashCode;

        public override bool Equals(object obj)
        {
            if (!(obj is TagKey other))
            {
                return false;
            }
            else
            {
                var equals = FullName == other.FullName;

                return equals;
            }
        }
    }
}