using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal class UserKey
    {
        private readonly int _hashCode;

        internal string LastName { get; }

        internal string FirstName { get; }

        internal string EmailAddress { get; }

        internal string PhoneNumber { get; }

        internal UserKey(User user)
        {
            LastName = user.LastName;
            FirstName = user.FirstName;
            EmailAddress = user.EmailAddress;
            PhoneNumber = user.PhoneNumber;

            _hashCode = LastName.GetHashCode() ^ FirstName.GetHashCode();
        }

        public override int GetHashCode() => _hashCode;

        public override bool Equals(object obj)
        {
            if (!(obj is UserKey other))
            {
                return false;
            }
            else
            {
                var equals = LastName == other.LastName && FirstName == other.FirstName;

                return equals;
            }
        }
    }
}