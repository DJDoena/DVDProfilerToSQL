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
            else if (left is null && right is object)
            {
                return false;
            }
            else
            {
                var equals = string.Equals(left.DVDId, right.DVDId, System.StringComparison.InvariantCulture);

                return equals;
            }
        }

        public int GetHashCode(tDVD obj) => (obj?.DVDId ?? string.Empty).GetHashCode();
    }
}
