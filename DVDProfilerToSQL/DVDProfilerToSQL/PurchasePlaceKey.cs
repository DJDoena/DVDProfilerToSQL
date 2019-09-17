namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class PurchasePlaceKey
    {
        private readonly int _hashCode;

        internal string Place { get; }

        internal string Type { get; }

        internal string Website { get; }

        internal PurchasePlaceKey(string place, string type, string website)
        {
            Place = place;
            Type = type;
            Website = website;

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