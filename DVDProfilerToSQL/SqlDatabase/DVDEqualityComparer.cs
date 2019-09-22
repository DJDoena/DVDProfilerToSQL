using System.Collections.Generic;

namespace DoenaSoft.DVDProfiler.SQLDatabase
{
    public sealed class DVDEqualityComparer : IEqualityComparer<tDVD>
    {
        public bool Equals(tDVD left, tDVD right)
        {
            if (ReferenceEquals(left, right))
            {
                return true;
            }
            else if (ReferenceEquals(left, null) && !ReferenceEquals(right, null))
            {
                return false;
            }

            var result = string.Equals(left.DVDId, right.DVDId, System.StringComparison.InvariantCulture);

            return result;
        }

        public int GetHashCode(tDVD obj) => (obj?.DVDId ?? string.Empty).GetHashCode();
    }
}
