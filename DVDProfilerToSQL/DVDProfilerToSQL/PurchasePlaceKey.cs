using System;
using System.ComponentModel;
using System.Diagnostics;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    [ImmutableObject(true)]
    [DebuggerDisplay("{Place}")]
    internal sealed class PurchasePlaceKey : IEquatable<PurchasePlaceKey>
    {
        private readonly int _hashCode;

        public string Place { get; }

        public string Type { get; }

        public string Website { get; }

        public PurchasePlaceKey(PurchaseInfo purchaseInfo)
        {
            Place = purchaseInfo.Place ?? string.Empty;
            Type = purchaseInfo.Type;
            Website = purchaseInfo.Website;

            _hashCode = Place.ToLowerInvariant().GetHashCode();
        }

        public override int GetHashCode() => _hashCode;

        public override bool Equals(object obj) => Equals(obj as PurchasePlaceKey);

        public bool Equals(PurchasePlaceKey other)
        {
            if (other == null)
            {
                return false;
            }

            var equals = string.Equals(Place, other.Place, StringComparison.InvariantCultureIgnoreCase);

            return equals;
        }
    }
}