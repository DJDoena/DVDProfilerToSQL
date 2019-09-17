using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class TagKey
    {
        private readonly Tag _tag;

        private readonly int _hashCode;

        internal Tag Tag
        {
            get
            {
                var tag = new Tag()
                {
                    FullName = _tag.FullName,
                    Name = _tag.Name,
                };

                return tag;
            }
        }

        internal TagKey(Tag tag)
        {
            _tag = new Tag()
            {
                FullName = tag.FullName,
                Name = tag.Name,
            };

            _hashCode = _tag.FullName.GetHashCode();
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
                var equals = _tag.FullName == other._tag.FullName;

                return equals;
            }
        }
    }
}