using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal class UserKey
    {
        private readonly User _user;

        private readonly int _hashCode;

        internal User User
        {
            get
            {
                var user = new User()
                {
                    EmailAddress = _user.EmailAddress,
                    FirstName = _user.FirstName,
                    LastName = _user.LastName,
                    PhoneNumber = _user.PhoneNumber,
                };

                return user;
            }
        }

        internal UserKey(User user)
        {
            _user = new User()
            {
                EmailAddress = user.EmailAddress,
                FirstName = user.FirstName,
                LastName = user.LastName,
                PhoneNumber = user.PhoneNumber,
            };

            _hashCode = _user.LastName.GetHashCode() ^ _user.FirstName.GetHashCode();
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
                var equals = (_user.LastName == other._user.LastName) && (_user.FirstName == other._user.FirstName);

                return equals;
            }
        }
    }
}