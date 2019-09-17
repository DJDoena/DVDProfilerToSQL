using System;
using System.Collections.Generic;
using System.Linq;
using DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class DataInserter : IProgressReporter
    {
        private readonly IBaseData _baseData;

        private readonly Entity.CollectionEntities _context;

        private readonly Dictionary<string, Entity.tDVD> _dvdHash;

        private int _maxProgress;

        private int _currentProgress;

        private Entity.tDVD _currentDVDEntity;

        public DataInserter(IBaseData baseData, Entity.CollectionEntities context)
        {
            _baseData = baseData;
            _context = context;

            _dvdHash = new Dictionary<string, Entity.tDVD>();
        }

        public event EventHandler<EventArgs<int>> ProgressMaxChanged;

        public event EventHandler<EventArgs<int>> ProgressValueChanged;

        public event EventHandler<EventArgs<string>> Feedback;

        internal void Insert(IEnumerable<DVD> dvds)
        {
            _maxProgress = dvds.Count();

            ReportStart();

            foreach (var dvd in dvds)
            {
                if (string.IsNullOrEmpty(dvd.ID))
                {
                    continue;
                }

                Insert(dvd);
            }

            ReportFinish();
        }

        private void Insert(DVD dvd)
        {
            InsertDVD(dvd);

            _dvdHash.Add(dvd.ID, _currentDVDEntity);

            InsertDVDId(dvd);

            InsertReview(dvd.Review);

            InsertLoanInfo(dvd.LoanInfo);

            InsertFeatures(dvd.Features);

            InsertFormat(dvd.Format);

            InsertPurchase(dvd.PurchaseInfo);

            InsertLock(dvd.Locks);

            InsertMediaTypes(dvd.MediaTypes);

            InsertGenres(dvd.GenreList ?? Enumerable.Empty<string>());

            InsertRegions(dvd.RegionList ?? Enumerable.Empty<string>());

            InsertStudios(dvd.StudioList ?? Enumerable.Empty<string>());

            InsertMediaCompanies(dvd.MediaCompanyList ?? Enumerable.Empty<string>());

            InsertAudio(dvd.AudioList ?? Enumerable.Empty<AudioTrack>());

            InsertSubtitles(dvd.SubtitleList ?? Enumerable.Empty<string>());

            InsertCast(dvd.CastList ?? Enumerable.Empty<object>());

            InsertCrew(dvd.CrewList ?? Enumerable.Empty<object>());

            InsertDiscs(dvd.DiscList ?? Enumerable.Empty<Disc>());

            InsertEvents(dvd.EventList ?? Enumerable.Empty<Event>());

            InsertTags(dvd.TagList ?? Enumerable.Empty<Tag>());

            InsertLinks(dvd.MyLinks?.UserLinkList ?? Enumerable.Empty<UserLink>());

            InsertPluginData(dvd.PluginCustomData ?? Enumerable.Empty<PluginData>());

            InsertCountriesOfOrigin(dvd.CountryOfOriginList ?? Enumerable.Empty<string>());
        }

        private void InsertDVD(DVD dvd)
        {
            _currentDVDEntity = new Entity.tDVD()
            {
                DVDId = dvd.ID,
                UPC = dvd.UPC,
                CollectionNumber = dvd.CollectionNumber,
                tCollectionType = _baseData.CollectionType[dvd.CollectionType],
                Title = dvd.Title,
                DistTrait = dvd.Edition,
                OriginalTitle = dvd.OriginalTitle,
                ProductionYear = dvd.ProductionYear != 0 ? dvd.ProductionYear : (int?)null,
                Released = dvd.ReleasedSpecified ? dvd.Released : (DateTime?)null,
                RunningTime = dvd.RunningTime != 0 ? dvd.RunningTime : (int?)null,
                Rating = dvd.Rating,
                tCaseType = !string.IsNullOrEmpty(dvd.CaseType) ? _baseData.CaseType[dvd.CaseType] : null,
                CaseSlipCover = dvd.CaseSlipCoverSpecified ? dvd.CaseSlipCover : (bool?)null,
                SRPValue = dvd.SRP.Value != 0 ? (decimal)dvd.SRP.Value : (decimal?)null,
                SRPDenomination = dvd.SRP.Value != 0 ? dvd.SRP.DenominationType : null,
                Overview = dvd.Overview,
                EasterEggs = dvd.EasterEggs,
                SortTitle = dvd.SortTitle,
                LastEdited = dvd.LastEditedSpecified ? dvd.LastEdited : (DateTime?)null,
                WishPriority = dvd.WishPriority,
                Notes = dvd.Notes,
            };

            _context.tDVD.Add(_currentDVDEntity);

            ReportCurrent();
        }

        private void InsertDVDId(DVD dvd)
        {
            IncreaseMax();

            var entity = new Entity.tDVDId()
            {
                tDVD = _currentDVDEntity,
                IdBase = dvd.ID_Base,
                VariantNum = (short)dvd.ID_VariantNum,
                tLocality = _baseData.Locality[new LocalityKey(dvd)],
                tDVDIdType = _baseData.DVDIdType[dvd.ID_Type],
            };

            _context.tDVDId.Add(entity);

            ReportCurrent();
        }

        private void InsertReview(Review review)
        {
            IncreaseMax();

            var entity = new Entity.tReview()
            {
                tDVD = _currentDVDEntity,
                Film = review.Film,
                Video = review.Video,
                Audio = review.Audio,
                Extras = review.Extras,
            };

            _context.tReview.Add(entity);

            ReportCurrent();
        }



        private void InsertLoanInfo(LoanInfo loanInfo)
        {
            IncreaseMax();


            ReportCurrent();
        }

        private void InsertFeatures(Features features)
        {
            IncreaseMax();


            ReportCurrent();
        }

        private void InsertFormat(Format format)
        {
            IncreaseMax();


            ReportCurrent();
        }

        private void InsertPurchase(PurchaseInfo purchaseInfo)
        {
            IncreaseMax();


            ReportCurrent();
        }

        private void InsertLock(Locks locks)
        {
            IncreaseMax();


            ReportCurrent();
        }

        private void InsertMediaTypes(MediaTypes mediaTypes)
        {
            IncreaseMax();


            ReportCurrent();

        }

        private void InsertGenres(IEnumerable<string> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertRegions(IEnumerable<string> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertStudios(IEnumerable<string> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertMediaCompanies(IEnumerable<string> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertAudio(IEnumerable<AudioTrack> enumerable)
        {

        }

        private void InsertSubtitles(IEnumerable<string> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertCast(IEnumerable<object> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();

        }

        private void InsertCrew(IEnumerable<object> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertDiscs(IEnumerable<Disc> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertEvents(IEnumerable<Event> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertTags(IEnumerable<Tag> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertLinks(IEnumerable<UserLink> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertPluginData(IEnumerable<PluginData> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void InsertCountriesOfOrigin(IEnumerable<string> enumerable)
        {
            _maxProgress += enumerable.Count();

            ReportMax();
        }

        private void ReportStart()
        {
            ReportMax();

            Feedback?.Invoke(this, new EventArgs<string>("DVD"));
        }

        private void ReportCurrent()
        {
            ProgressValueChanged?.Invoke(this, new EventArgs<int>(_currentProgress++));
        }

        private void ReportFinish()
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(0));
        }

        private void IncreaseMax()
        {
            _maxProgress++;

            ReportMax();
        }

        private void ReportMax()
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(_maxProgress));
        }
    }
}