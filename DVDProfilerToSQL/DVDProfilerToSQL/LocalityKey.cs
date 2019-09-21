using System;
using System.ComponentModel;
using System.Diagnostics;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    [ImmutableObject(true)]
    [DebuggerDisplay("{Id}: {Description}")]
    internal sealed class LocalityKey : IEquatable<LocalityKey>
    {
        public int Id { get; }

        public string Description { get; }

        public LocalityKey(Profiler.DVD profile)
        {
            Id = profile.ID_LocalityID;
            Description = profile.ID_LocalityDesc;
        }

        public override int GetHashCode() => Id;

        public override bool Equals(object obj) => Equals(obj as LocalityKey);

        public bool Equals(LocalityKey other)
        {
            if (other == null)
            {
                return false;
            }

            var equals = Id == other.Id;

            return equals;
        }
    }
}