using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class PurchasePlaceKey
    {
        private readonly int _hashCode;

        internal string Place { get; }

        internal string Type { get; }

        internal string Website { get; }

        internal PurchasePlaceKey(PurchaseInfo purchaseInfo)
        {
            Place = purchaseInfo.Place;
            Type = purchaseInfo.Type;
            Website = purchaseInfo.Website;

            _hashCode = Place.GetHashCode();
        }

        public override int GetHashCode() => _hashCode;

        public override bool Equals(object obj)
        {
            if (!(obj is PurchasePlaceKey other))
            {
                return false;
            }
            else
            {
                var equals = Place == other.Place
                    && Type == other.Type
                    && Website == other.Website;

                return equals;
            }
        }
    }
}