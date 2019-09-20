using System;
using System.ComponentModel;
using System.Diagnostics;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    [ImmutableObject(true)]
    [DebuggerDisplay("{FullName}")]
    internal sealed class TagKey : IEquatable<TagKey>
    {
        private readonly int _hashCode;

        public string FullName { get; }

        public string Name { get; }

        public TagKey(Tag tag)
        {
            FullName = tag.FullName ?? string.Empty;
            Name = tag.Name;

            _hashCode = FullName.ToLowerInvariant().GetHashCode();
        }

        public override int GetHashCode() => _hashCode;

        public override bool Equals(object obj) => Equals(obj as TagKey);

        public bool Equals(TagKey other)
        {
            if (other == null)
            {
                return false;
            }

            var equals = string.Equals(FullName, other.FullName, StringComparison.InvariantCultureIgnoreCase);

            return equals;
        }
    }
}