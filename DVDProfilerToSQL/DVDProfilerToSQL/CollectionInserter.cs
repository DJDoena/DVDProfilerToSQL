using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using DoenaSoft.DVDProfiler.DVDProfilerXML;
using DDI = DoenaSoft.DVDProfiler.DigitalDownloadInfo;
using EF = DoenaSoft.DVDProfiler.EnhancedFeatures;
using EN = DoenaSoft.DVDProfiler.EnhancedNotes;
using Entity = DoenaSoft.DVDProfiler.SQLDatabase;
using EPI = DoenaSoft.DVDProfiler.EnhancedPurchaseInfo;
using ET = DoenaSoft.DVDProfiler.EnhancedTitles;
using Profiler = DoenaSoft.DVDProfiler.DVDProfilerXML.Version400;

namespace DoenaSoft.DVDProfiler.DVDProfilerToSQL
{
    internal sealed class CollectionInserter : IProgressReporter
    {
        private readonly IBaseData _baseData;

        private readonly Entity.CollectionEntities _context;

        private readonly Dictionary<string, Entity.tDVD> _dvdHash;

        private int _maxProgress;

        private int _currentProgress;

        private Entity.tDVD _currentDVDEntity;

        public CollectionInserter(IBaseData baseData, Entity.CollectionEntities context)
        {
            _baseData = baseData;
            _context = context;

            _dvdHash = new Dictionary<string, Entity.tDVD>();
        }

        public event EventHandler<EventArgs<int>> ProgressMaxChanged;

        public event EventHandler<EventArgs<int>> ProgressValueChanged;

        public event EventHandler<EventArgs<string>> Feedback;

        internal void Insert(IEnumerable<Profiler.DVD> profiles)
        {
            if (profiles == null)
            {
                return;
            }

            var valid = profiles.Where(IsNotNull).Where(dvd => !string.IsNullOrEmpty(dvd.ID)).ToList();

            _maxProgress = valid.Count;

            ReportStart();

            var counter = 0;

            foreach (var profile in valid)
            {
                Insert(profile);

                if (((++counter) % 100) == 0)
                {
                    _context.ChangeTracker.DetectChanges();
                    _context.SaveChanges();
                }
            }

            _context.ChangeTracker.DetectChanges();
            _context.SaveChanges();

            _currentDVDEntity = null;

            foreach (var profile in valid)
            {
                InsertBoxSetChildren(profile);
            }

            _context.ChangeTracker.DetectChanges();
            _context.SaveChanges();

            ReportFinish();
        }

        private void Insert(Profiler.DVD profile)
        {
            InsertDVD(profile);

            _dvdHash.Add(profile.ID, _currentDVDEntity);

            InsertAudio(profile.AudioList);

            InsertCast(profile.CastList);
            InsertCountriesOfOrigin(profile.CountryOfOriginList);
            InsertCrew(profile.CrewList);
            InsertDiscs(profile.DiscList);
            InsertDVDId(profile);
            InsertEvents(profile.EventList);
            InsertExclusions(profile.Exclusions);
            InsertFeatures(profile.Features);
            InsertFormat(profile.Format, profile.MediaTypes);
            InsertGenres(profile.GenreList);
            InsertLinks(profile.MyLinks?.UserLinkList);
            InsertLoanInfo(profile.LoanInfo);
            InsertLock(profile.Locks);
            InsertMediaCompanies(profile.MediaCompanyList);
            InsertMediaTypes(profile.MediaTypes);
            InsertPluginData(profile.PluginCustomData);
            InsertPurchase(profile.PurchaseInfo);
            InsertRegions(profile.RegionList);
            InsertReview(profile.Review);
            InsertStudios(profile.StudioList);
            InsertSubtitles(profile.SubtitleList);
            InsertTags(profile.TagList);
        }

        private void InsertDVD(Profiler.DVD profile)
        {
            _currentDVDEntity = new Entity.tDVD()
            {
                DVDId = profile.ID,
                CaseSlipCover = profile.CaseSlipCoverSpecified ? profile.CaseSlipCover : (bool?)null,
                CollectionNumber = profile.CollectionNumber,
                DistTrait = profile.Edition,
                EasterEggs = profile.EasterEggs,
                LastEdited = profile.LastEditedSpecified ? profile.LastEdited : (DateTime?)null,
                Notes = profile.Notes,
                OriginalTitle = profile.OriginalTitle,
                Overview = profile.Overview,
                ProductionYear = profile.ProductionYear != 0 ? profile.ProductionYear : (int?)null,
                Rating = profile.Rating,
                Released = profile.ReleasedSpecified ? profile.Released : (DateTime?)null,
                RunningTime = profile.RunningTime != 0 ? profile.RunningTime : (int?)null,
                SortTitle = profile.SortTitle,
                SRPDenomination = profile.SRP?.Value != 0 ? profile.SRP.DenominationType : null,
                SRPValue = profile.SRP?.Value != 0 ? (decimal)profile.SRP.Value : (decimal?)null,
                tCaseType = !string.IsNullOrEmpty(profile.CaseType) ? _baseData.CaseType[profile.CaseType] : null,
                tCollectionType = _baseData.CollectionType[profile.CollectionType],
                Title = profile.Title,
                UPC = profile.UPC,
                WishPriority = profile.WishPriority,
            };

            _context.tDVD.Add(_currentDVDEntity);

            IncreaseCurrent();
        }

        private void InsertAudio(IEnumerable<Profiler.AudioTrack> audioTracks)
        {
            if (audioTracks == null)
            {
                return;
            }

            var valid = audioTracks.Where(IsNotNull).ToList();

            IncreaseMax(valid.Count);

            foreach (var audioTrack in valid)
            {
                var entity = new Entity.tDVDxAudio()
                {
                    tDVD = _currentDVDEntity,
                    tAudioContent = _baseData.AudioContent[audioTrack.Content],
                    tAudioFormat = !string.IsNullOrEmpty(audioTrack.Format) ? _baseData.AudioFormat[audioTrack.Format] : null,
                    tAudioChannels = !string.IsNullOrEmpty(audioTrack.Channels) ? _baseData.AudioChannels[audioTrack.Channels] : null,
                };

                _context.tDVDxAudio.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertCast(IEnumerable<object> castList)
        {
            if (castList == null)
            {
                return;
            }

            var valid = castList.Where(IsNotNull).Where(c => c is Profiler.CastMember || c is Profiler.Divider).ToList();

            var count = valid.OfType<Profiler.CastMember>().Count();

            IncreaseMax(count);

            string currentEpisode = null;

            string currentGroup = null;

            var orderNumber = 0;

            foreach (var castEntry in castList)
            {
                if (castEntry is Profiler.CastMember castMember)
                {
                    InsertCastMember(castMember, currentEpisode, currentGroup, ref orderNumber);
                }
                else
                {
                    GetDividerData((Profiler.Divider)castEntry, ref currentEpisode, ref currentGroup);
                }
            }
        }

        private void InsertCountriesOfOrigin(IEnumerable<string> countriesOfOrigin)
        {
            if (countriesOfOrigin == null)
            {
                return;
            }

            var valid = countriesOfOrigin.Where(IsNotEmpty).ToList();

            IncreaseMax(valid.Count);

            foreach (var countryOfOrigin in valid)
            {
                var entity = new Entity.tDVDxCountryOfOrigin()
                {
                    tDVD = _currentDVDEntity,
                    tCountryOfOrigin = _baseData.CountryOfOrigin[countryOfOrigin],
                };

                _context.tDVDxCountryOfOrigin.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertCrew(IEnumerable<object> crewList)
        {
            if (crewList == null)
            {
                return;
            }

            var valid = crewList.Where(IsNotNull).Where(c => c is Profiler.CrewMember || c is Profiler.CrewDivider).ToList();

            var count = valid.OfType<Profiler.CrewMember>().Count();

            IncreaseMax(count);

            string currentEpisode = null;

            string currentGroup = null;

            string currentCreditType = null;

            var orderNumber = 0;

            foreach (var crewEntry in crewList)
            {
                if (crewEntry is Profiler.CrewMember crewMember)
                {
                    InsertCrewMember(crewMember, currentEpisode, ref currentGroup, ref currentCreditType, ref orderNumber);
                }
                else
                {
                    GetDividerData((Profiler.CrewDivider)crewEntry, ref currentEpisode, ref currentGroup);
                }
            }
        }

        private void InsertDiscs(IEnumerable<Profiler.Disc> discs)
        {
            if (discs == null)
            {
                return;
            }

            var valid = discs.Where(IsNotNull).ToList();

            IncreaseMax(valid.Count);

            foreach (var disc in valid)
            {
                var entity = new Entity.tDVDxDisc()
                {
                    tDVD = _currentDVDEntity,
                    DescriptionSideA = disc.DescriptionSideA,
                    DescriptionSideB = disc.DescriptionSideB,
                    DiscIDSideA = disc.DiscIDSideA,
                    DiscIDSideB = disc.DiscIDSideB,
                    DualLayeredSideA = disc.DualLayeredSideA,
                    DualLayeredSideB = disc.DualLayeredSideB,
                    DualSided = disc.DualSided,
                    LabelSideA = disc.LabelSideA,
                    LabelSideB = disc.LabelSideB,
                    Location = disc.Location,
                    Slot = disc.Slot,
                };

                _context.tDVDxDisc.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertDVDId(Profiler.DVD profile)
        {
            IncreaseMax();

            var entity = new Entity.tDVDId()
            {
                tDVD = _currentDVDEntity,
                IdBase = profile.ID_Base,
                tDVDIdType = _baseData.DVDIdType[profile.ID_Type],
                tLocality = _baseData.Locality[new LocalityKey(profile)],
                VariantNum = (short)profile.ID_VariantNum,
            };

            _context.tDVDId.Add(entity);

            IncreaseCurrent();
        }

        private void InsertEvents(IEnumerable<Profiler.Event> events)
        {
            if (events == null)
            {
                return;
            }

            var valid = events.Where(IsNotNull).ToList();

            IncreaseMax(valid.Count);

            foreach (var anEvent in events)
            {
                var entity = new Entity.tDVDxEvent()
                {
                    tDVD = _currentDVDEntity,
                    tEventType = _baseData.EventType[anEvent.Type],
                    Note = anEvent.Note,
                    Timestamp = anEvent.Timestamp,
                    tUser = _baseData.User[new UserKey(anEvent.User)],
                };

                _context.tDVDxEvent.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertExclusions(Profiler.Exclusions exclusions)
        {
            if (exclusions == null)
            {
                return;
            }

            var entity = new Entity.tExclusions()
            {
                tDVD = _currentDVDEntity,
                DPOPrivate = exclusions.DPOPrivateSpecified ? exclusions.DPOPrivate : (bool?)null,
                DPOPublic = exclusions.DPOPublicSpecified ? exclusions.DPOPublic : (bool?)null,
                IPhone = exclusions.iPhoneSpecified ? exclusions.iPhone : (bool?)null,
                Mobile = exclusions.MobileSpecified ? exclusions.Mobile : (bool?)null,
                MoviePick = exclusions.MoviePickSpecified ? exclusions.MoviePick : (bool?)null,
                RemoteConnections = exclusions.RemoteConnectionsSpecified ? exclusions.RemoteConnections : (bool?)null,
            };

            _context.tExclusions.Add(entity);
        }

        private void InsertFeatures(Profiler.Features features)
        {
            if (features == null)
            {
                return;
            }

            IncreaseMax();

            var entity = new Entity.tFeatures()
            {
                tDVD = _currentDVDEntity,
                BDLive = features.BDLive,
                BonusTrailers = features.BonusTrailers,
                CineChat = features.CineChat,
                ClosedCaptioned = features.ClosedCaptioned,
                Commentary = features.Commentary,
                DBOX = features.DBOX,
                DeletedScenes = features.DeletedScenes,
                DigitalCopy = features.DigitalCopy,
                DVDROMContent = features.DVDROMContent,
                Game = features.Game,
                Interviews = features.Interviews,
                MakingOf = features.MakingOf,
                MovieIQ = features.MovieIQ,
                MultiAngle = features.MultiAngle,
                MusicVideos = features.MusicVideos,
                OtherFeatures = features.OtherFeatures,
                Outtakes = features.Outtakes,
                PhotoGallery = features.PhotoGallery,
                PictureInPicture = features.PIP,
                PlayAll = features.PlayAll,
                ProductionNotes = features.ProductionNotes,
                SceneAccess = features.SceneAccess,
                StoryboardComparisons = features.StoryboardComparisons,
                THXCertified = features.THXCertified,
                Trailer = features.Trailer,
            };

            _context.tFeatures.Add(entity);

            IncreaseCurrent();
        }

        private void InsertGenres(IEnumerable<string> genres)
        {
            if (genres == null)
            {
                return;
            }

            var valid = genres.Where(IsNotEmpty).ToList();

            IncreaseMax(valid.Count);

            foreach (var genre in valid)
            {
                var entity = new Entity.tDVDxGenre()
                {
                    tDVD = _currentDVDEntity,
                    tGenre = _baseData.Genre[genre],
                };

                _context.tDVDxGenre.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertFormat(Profiler.Format format, Profiler.MediaTypes mediaTypes)
        {
            if (format == null)
            {
                return;
            }

            IncreaseMax();

            var entity = new Entity.tFormat()
            {
                tDVD = _currentDVDEntity,
                AspectRatio = format.AspectRatio,
                BlackAndWhite = format.Color?.BlackAndWhite ?? false,
                C16X9 = format.Enhanced16X9,
                C2D = format.Dimensions?.Dim2D ?? false,
                C3DAnaglyph = format.Dimensions?.Dim3DAnaglyph ?? false,
                C3DBluRay = format.Dimensions?.Dim3DBluRay ?? false,
                Color = format.Color?.Color ?? false,
                Colorized = format.Color?.Colorized ?? false,
                DolbyVision = format.DynamicRange?.DRDolbyVision,
                DualLayered = format.DualLayered,
                DualSided = format.DualSided,
                FullFrame = format.FullFrame,
                HDR10 = format.DynamicRange?.DRHDR10,
                LetterBox = format.LetterBox,
                Mixed = format.Color?.Mixed ?? false,
                PanAndScan = format.PanAndScan,
                tVideoStandard = !IsHDFormat(mediaTypes) ? _baseData.VideoStandard[format.VideoStandard] : null,
            };

            _context.tFormat.Add(entity);

            IncreaseCurrent();
        }

        private void InsertLinks(IEnumerable<Profiler.UserLink> links)
        {
            if (links == null)
            {
                return;
            }

            var valid = links.Where(IsNotNull).ToList();

            IncreaseMax(valid.Count);

            foreach (var link in links)
            {
                var entity = new Entity.tDVDxMyLinks()
                {
                    tDVD = _currentDVDEntity,
                    Description = link.Description,
                    tLinkCategory = _baseData.LinkCategory[link.Category],
                    Url = link.URL,
                };

                _context.tDVDxMyLinks.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertLoanInfo(Profiler.LoanInfo loanInfo)
        {
            if (loanInfo == null)
            {
                return;
            }

            IncreaseMax();

            var entity = new Entity.tLoanInfo()
            {
                tDVD = _currentDVDEntity,
                Loaned = loanInfo.Loaned,
                Due = loanInfo.DueSpecified ? loanInfo.Due : (DateTime?)null,
                tUser = TryGetUser(loanInfo.User),
            };

            _context.tLoanInfo.Add(entity);

            IncreaseCurrent();
        }

        private void InsertLock(Profiler.Locks locks)
        {
            if (locks == null)
            {
                return;
            }

            IncreaseMax();

            var entity = new Entity.tLock()
            {
                tDVD = _currentDVDEntity,
                AudioTracks = locks.AudioTracks,
                CaseType = locks.CaseType,
                Cast = locks.Cast,
                Covers = locks.Covers,
                Crew = locks.Crew,
                DiscInformation = locks.DiscInformation,
                EasterEggs = locks.EasterEggs,
                Entire = locks.Entire,
                Features = locks.Features,
                Genres = locks.Genres,
                MediaType = locks.MediaType,
                Overview = locks.Overview,
                ProductionYear = locks.ProductionYear,
                Rating = locks.Rating,
                Regions = locks.Regions,
                ReleaseDate = locks.ReleaseDate,
                RunningTime = locks.RunningTime,
                SRP = locks.SRP,
                Studios = locks.Studios,
                Subtitles = locks.Subtitles,
                Title = locks.Title,
                VideoFormats = locks.VideoFormats,
            };

            _context.tLock.Add(entity);

            IncreaseCurrent();
        }

        private void InsertMediaCompanies(IEnumerable<string> mediaCompanies)
        {
            if (mediaCompanies == null)
            {
                return;
            }

            var valid = mediaCompanies.Where(IsNotEmpty).ToList();

            IncreaseMax(valid.Count);

            foreach (var mediaCompany in valid)
            {
                var entity = new Entity.tDVDxMediaCompany()
                {
                    tDVD = _currentDVDEntity,
                    tStudioAndMediaCompany = _baseData.StudioAndMediaCompany[mediaCompany],
                };

                _context.tDVDxMediaCompany.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertMediaTypes(Profiler.MediaTypes mediaTypes)
        {
            if (mediaTypes == null)
            {
                return;
            }

            if (mediaTypes.DVD)
            {
                InsertMediaType("DVD");
            }

            if (mediaTypes.BluRay)
            {
                InsertMediaType("Blu-ray");
            }

            if (mediaTypes.HDDVD)
            {
                InsertMediaType("HD-DVD");
            }

            if (mediaTypes.UltraHD)
            {
                InsertMediaType("Ultra HD");
            }

            if (!string.IsNullOrEmpty(mediaTypes.CustomMediaType))
            {
                InsertMediaType(mediaTypes.CustomMediaType);
            }
        }

        private void InsertPluginData(IEnumerable<Profiler.PluginData> pluginDataList)
        {
            if (pluginDataList == null)
            {
                return;
            }

            var valid = pluginDataList.Where(IsNotNull).ToList();

            IncreaseMax(valid.Count);

            foreach (var pluginData in valid)
            {
                InsertPluginData(pluginData);

                IncreaseCurrent();
            }
        }

        private void InsertPurchase(Profiler.PurchaseInfo purchaseInfo)
        {
            if (purchaseInfo == null)
            {
                return;
            }

            IncreaseMax();

            var entity = new Entity.tPurchase()
            {
                tDVD = _currentDVDEntity,
                Date = purchaseInfo.DateSpecified ? purchaseInfo.Date : (DateTime?)null,
                PriceDenomination = purchaseInfo.Price?.Value != 0 ? purchaseInfo.Price.DenominationType : null,
                PriceValue = purchaseInfo.Price?.Value != 0 ? (decimal)purchaseInfo.Price.Value : (decimal?)null,
                ReceivedAsGift = purchaseInfo.ReceivedAsGift,
                tPurchasePlace = !string.IsNullOrEmpty(purchaseInfo.Place) ? _baseData.PurchasePlace[new PurchasePlaceKey(purchaseInfo)] : null,
                tUser = purchaseInfo.ReceivedAsGift && UserKey.IsValid(purchaseInfo.GiftFrom) ? _baseData.User[new UserKey(purchaseInfo.GiftFrom)] : null,
            };

            _context.tPurchase.Add(entity);

            IncreaseCurrent();
        }

        private void InsertRegions(IEnumerable<string> regions)
        {
            if (regions == null)
            {
                return;
            }

            var valid = regions.Where(IsNotEmpty).ToList();

            IncreaseMax(valid.Count);

            foreach (var region in valid)
            {
                var entity = new Entity.tDVDxRegion()
                {
                    tDVD = _currentDVDEntity,
                    Region = region,
                };

                _context.tDVDxRegion.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertReview(Profiler.Review review)
        {
            if (review == null)
            {
                return;
            }

            IncreaseMax();

            var entity = new Entity.tReview()
            {
                tDVD = _currentDVDEntity,
                Audio = review.Audio,
                Extras = review.Extras,
                Film = review.Film,
                Video = review.Video,
            };

            _context.tReview.Add(entity);

            IncreaseCurrent();
        }

        private void InsertStudios(IEnumerable<string> studios)
        {
            if (studios == null)
            {
                return;
            }

            var valid = studios.Where(IsNotEmpty).ToList();

            IncreaseMax(valid.Count);

            foreach (var studio in valid)
            {
                var entity = new Entity.tDVDxStudio()
                {
                    tDVD = _currentDVDEntity,
                    tStudioAndMediaCompany = _baseData.StudioAndMediaCompany[studio],
                };

                _context.tDVDxStudio.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertSubtitles(IEnumerable<string> subtitles)
        {
            if (subtitles == null)
            {
                return;
            }

            var valid = subtitles.Where(IsNotEmpty).ToList();

            IncreaseMax(valid.Count);

            foreach (var subtitle in valid)
            {
                var entity = new Entity.tDVDxSubtitle()
                {
                    tDVD = _currentDVDEntity,
                    tSubtitle = _baseData.Subtitle[subtitle],
                };

                _context.tDVDxSubtitle.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertTags(IEnumerable<Profiler.Tag> tags)
        {
            if (tags == null)
            {
                return;
            }

            var valid = tags.Where(IsNotNull).ToList();

            IncreaseMax(valid.Count);

            foreach (var tag in valid)
            {
                var entity = new Entity.tDVDxTag()
                {
                    tDVD = _currentDVDEntity,
                    tTag = _baseData.Tag[new TagKey(tag)],
                };

                _context.tDVDxTag.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertBoxSetChildren(Profiler.DVD parentProfile)
        {
            var childIds = parentProfile.BoxSet?.ContentList;

            if (childIds == null)
            {
                return;
            }

            var valid = childIds.Where(IsNotEmpty).Where(id => _dvdHash.ContainsKey(id)).ToList();

            IncreaseMax(valid.Count);

            foreach (var childId in valid)
            {
                var entity = new Entity.tParentDVDxChildDVD()
                {
                    tParentDVD = _dvdHash[parentProfile.ID],
                    tChildDVD = _dvdHash[childId],
                };

                _context.tParentDVDxChildDVD.Add(entity);

                IncreaseCurrent();
            }
        }

        private void InsertCastMember(Profiler.CastMember castMember, string currentEpisode, string currentGroup, ref int orderNumber)
        {
            var entity = new Entity.tDVDxCast()
            {
                tDVD = _currentDVDEntity,
                CreditedAs = castMember.CreditedAs,
                Episode = currentEpisode,
                Group = currentGroup,
                OrderNumber = ++orderNumber,
                Puppeteer = castMember.Puppeteer,
                Role = castMember.Role,
                tCastAndCrew = _baseData.CastAndCrew[new PersonKey(castMember)],
                Uncredited = castMember.Uncredited,
                Voice = castMember.Voice,
            };

            _context.tDVDxCast.Add(entity);

            IncreaseCurrent();
        }

        private void InsertCrewMember(Profiler.CrewMember crewMember, string currentEpisode, ref string currentGroup, ref string currentCreditType, ref int orderNumber)
        {
            if (currentCreditType != crewMember.CreditType)
            {
                currentCreditType = crewMember.CreditType;

                currentGroup = null;
            }

            var entity = new Entity.tDVDxCrew()
            {
                tDVD = _currentDVDEntity,
                CreditedAs = crewMember.CreditedAs,
                CustomRole = crewMember.CustomRole,
                Episode = currentEpisode,
                Group = currentGroup,
                OrderNumber = ++orderNumber,
                tCastAndCrew = _baseData.CastAndCrew[new PersonKey(crewMember)],
                tCreditSubtype = _baseData.CreditSubtype[crewMember.CreditType ?? string.Empty][crewMember.CreditSubtype ?? string.Empty],
            };

            _context.tDVDxCrew.Add(entity);

            IncreaseCurrent();
        }

        private void GetDividerData(Profiler.Divider divider, ref string currentEpisode, ref string currentGroup)
        {
            if (divider.Type == Profiler.DividerType.Episode)
            {
                currentEpisode = divider.Caption;

                currentGroup = null;
            }
            else if (divider.Type == Profiler.DividerType.Group)
            {
                currentGroup = divider.Caption;
            }
            else if (divider.Type == Profiler.DividerType.EndDiv)
            {
                if (currentGroup != null)
                {
                    currentGroup = null;
                }
                else
                {
                    currentEpisode = null;
                }
            }
            else
            {
                throw new ArgumentException($"Unknown enum value '{divider.Type.ToString()}'", nameof(divider));
            }
        }

        private Entity.tUser TryGetUser(Profiler.User user)
        {
            if (UserKey.IsInvalid(user))
            {
                return null;
            }

            var result = _baseData.User[new UserKey(user)];

            return result;
        }

        private void InsertMediaType(string mediaType)
        {
            IncreaseMax();

            var entity = new Entity.tDVDxMediaType()
            {
                tDVD = _currentDVDEntity,
                tMediaType = _baseData.MediaType[mediaType],
            };

            _context.tDVDxMediaType.Add(entity);

            IncreaseCurrent();
        }

        private void InsertPluginData(Profiler.PluginData pluginData)
        {
            switch (pluginData.ClassID)
            {
                case (EPI.ClassGuid.ClassIDBraced):
                    {
                        (new EnhancePurchaseInfoInserter(_context, _currentDVDEntity, pluginData)).Insert();

                        break;
                    }
                case (EN.ClassGuid.ClassIDBraced):
                    {
                        (new EnhancedNotesInserter(_context, _currentDVDEntity, pluginData)).Insert();

                        break;
                    }
                case (ET.ClassGuid.ClassIDBraced):
                    {
                        (new EnhancedTitlesInserter(_context, _currentDVDEntity, pluginData)).Insert();

                        break;
                    }
                case (DDI.ClassGuid.ClassIDBraced):
                    {
                        (new DigitalDownloadInfoInserter(_context, _currentDVDEntity, pluginData)).Insert();

                        break;
                    }
                case (EF.ClassGuid.ClassIDBraced):
                    {
                        (new EnhancedFeaturesInserter(_context, _currentDVDEntity, pluginData)).Insert();

                        break;
                    }
                default:
                    {
                        InsertGeneralPluginData(pluginData);

                        break;
                    }
            }
        }

        private void InsertGeneralPluginData(Profiler.PluginData pluginData)
        {
            var entity = new Entity.tDVDxPluginData()
            {
                tDVD = _currentDVDEntity,
                PluginData = GetPluginData(pluginData.Any),
                tPluginData = _baseData.PluginData[new PluginDataKey(pluginData)],
            };

            _context.tDVDxPluginData.Add(entity);
        }

        private static string GetPluginData(IEnumerable<XmlNode> xmlNodes)
        {
            if (xmlNodes == null)
            {
                return null;
            }

            var valid = xmlNodes.Where(IsNotNull).Where(n => !string.IsNullOrWhiteSpace(n.OuterXml));

            var sb = new StringBuilder();

            foreach (var xmlNode in valid)
            {
                sb.AppendLine(xmlNode.OuterXml);
            }

            return sb.ToString();
        }

        private static bool IsNotEmpty(string value) => !string.IsNullOrWhiteSpace(value);

        private static bool IsNotNull(object value) => value != null;

        private static bool IsHDFormat(Profiler.MediaTypes mediaTypes) => (mediaTypes != null) && (mediaTypes.BluRay || mediaTypes.HDDVD || mediaTypes.UltraHD);

        private void ReportStart()
        {
            if (_maxProgress > 0)
            {
                ReportMax();
            }

            Feedback?.Invoke(this, new EventArgs<string>("DVD"));
        }

        private void IncreaseCurrent()
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

        private void IncreaseMax(int count)
        {
            _maxProgress += count;

            ReportMax();
        }

        private void ReportMax()
        {
            ProgressMaxChanged?.Invoke(this, new EventArgs<int>(_maxProgress));
        }
    }
}