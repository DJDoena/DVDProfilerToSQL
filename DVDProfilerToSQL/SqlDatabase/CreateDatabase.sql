-- create Database into project's directory under the name "Collection.mdf"


USE [master]
GO
CREATE DATABASE [Collection]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Collection', FILENAME = N'D:\Git\DVDProfilerToSQL\DVDProfilerToSQL\SqlDatabase\Collection.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Collection_log', FILENAME = N'D:\Git\DVDProfilerToSQL\DVDProfilerToSQL\SqlDatabase\Collection_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Collection] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Collection].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Collection] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Collection] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Collection] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Collection] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Collection] SET ARITHABORT OFF 
GO
ALTER DATABASE [Collection] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Collection] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [Collection] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Collection] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Collection] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Collection] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Collection] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Collection] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Collection] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Collection] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Collection] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Collection] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Collection] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Collection] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Collection] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Collection] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Collection] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Collection] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Collection] SET  MULTI_USER 
GO
ALTER DATABASE [Collection] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Collection] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Collection] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Collection] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Collection] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Collection] SET QUERY_STORE = OFF
GO
USE [Collection]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Collection]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCollectionType](
	[CollectionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NULL,
	[IsPartOfOwnedCollection] [bit] NOT NULL,
 CONSTRAINT [PK_tCollectionType] PRIMARY KEY CLUSTERED 
(
	[CollectionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tEnhancedNotes](
	[EnhancedNotesId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Note1] [ntext] NULL,
	[Note1isHtml] [bit] NOT NULL,
	[Note2] [ntext] NULL,
	[Note2isHtml] [bit] NOT NULL,
	[Note3] [ntext] NULL,
	[Note3isHtml] [bit] NOT NULL,
	[Note4] [ntext] NULL,
	[Note4isHtml] [bit] NOT NULL,
	[Note5] [ntext] NULL,
	[Note15sHtml] [bit] NOT NULL,
 CONSTRAINT [PK_tEnhancedNotes] PRIMARY KEY CLUSTERED 
(
	[EnhancedNotesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVD](
	[DVDId] [nvarchar](50) NOT NULL,
	[UPC] [nvarchar](50) NOT NULL,
	[CollectionNumber] [nvarchar](50) NULL,
	[CollectionTypeId] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[DistTrait] [nvarchar](255) NULL,
	[OriginalTitle] [nvarchar](255) NULL,
	[ProductionYear] [int] NULL,
	[Released] [date] NULL,
	[RunningTime] [int] NULL,
	[Rating] [nvarchar](50) NULL,
	[CaseTypeId] [int] NULL,
	[CaseSlipCover] [bit] NULL,
	[SRPDenomination] [nvarchar](50) NULL,
	[SRPValue] [decimal](18, 2) NULL,
	[Overview] [ntext] NULL,
	[EasterEggs] [ntext] NULL,
	[SortTitle] [nvarchar](255) NOT NULL,
	[LastEdited] [datetime] NULL,
	[WishPriority] [int] NOT NULL,
	[Notes] [ntext] NULL,
 CONSTRAINT [PK_tDVD] PRIMARY KEY CLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vEnhancedNotes]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tEnhancedNotes.Note1, dbo.tEnhancedNotes.Note1isHtml, dbo.tEnhancedNotes.Note2, dbo.tEnhancedNotes.Note2isHtml, 
                         dbo.tEnhancedNotes.Note3, dbo.tEnhancedNotes.Note3isHtml, dbo.tEnhancedNotes.Note4, dbo.tEnhancedNotes.Note4isHtml, dbo.tEnhancedNotes.Note5, dbo.tEnhancedNotes.Note15sHtml
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tEnhancedNotes ON dbo.tDVD.DVDId = dbo.tEnhancedNotes.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tEnhancedPurchaseInfo](
	[EnhancedPurchaseInfoId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[OriginalPriceDenomination] [nvarchar](50) NULL,
	[OriginalPriceValue] [decimal](18, 2) NULL,
	[ShippingCostDenomination] [nvarchar](50) NULL,
	[ShippingCostValue] [decimal](18, 2) NULL,
	[CreditCardChargeDenomination] [nvarchar](50) NULL,
	[CreditCardChargeValue] [decimal](18, 2) NULL,
	[CreditCardFeesDenomination] [nvarchar](50) NULL,
	[CreditCardFeesValue] [decimal](18, 2) NULL,
	[DiscountDenomination] [nvarchar](50) NULL,
	[DiscountValue] [decimal](18, 2) NULL,
	[CustomsFeesDenomination] [nvarchar](50) NULL,
	[CustomsFeesValue] [decimal](18, 2) NULL,
	[CouponType] [nvarchar](100) NULL,
	[CouponCode] [nvarchar](100) NULL,
	[AdditionalPrice1Denomination] [nvarchar](50) NULL,
	[AdditionalPrice1Value] [decimal](18, 2) NULL,
	[AdditionalPrice2Denomination] [nvarchar](50) NULL,
	[AdditionalPrice2Value] [decimal](18, 2) NULL,
	[OrderDate] [date] NULL,
	[ShippingDate] [date] NULL,
	[DeliveryDate] [date] NULL,
	[AdditionalDate1] [date] NULL,
	[AdditionalDate2] [date] NULL,
 CONSTRAINT [PK_tEnhancedPurchaseInfo] PRIMARY KEY CLUSTERED 
(
	[EnhancedPurchaseInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vEnhancedPurchaseInfo]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tEnhancedPurchaseInfo.OriginalPriceDenomination, dbo.tEnhancedPurchaseInfo.OriginalPriceValue, 
                         dbo.tEnhancedPurchaseInfo.ShippingCostDenomination, dbo.tEnhancedPurchaseInfo.ShippingCostValue, dbo.tEnhancedPurchaseInfo.CreditCardChargeDenomination, dbo.tEnhancedPurchaseInfo.CreditCardChargeValue, 
                         dbo.tEnhancedPurchaseInfo.CreditCardFeesDenomination, dbo.tEnhancedPurchaseInfo.CreditCardFeesValue, dbo.tEnhancedPurchaseInfo.DiscountDenomination, dbo.tEnhancedPurchaseInfo.DiscountValue, 
                         dbo.tEnhancedPurchaseInfo.CustomsFeesDenomination, dbo.tEnhancedPurchaseInfo.CustomsFeesValue, dbo.tEnhancedPurchaseInfo.CouponType, dbo.tEnhancedPurchaseInfo.CouponCode, 
                         dbo.tEnhancedPurchaseInfo.AdditionalPrice1Denomination, dbo.tEnhancedPurchaseInfo.AdditionalPrice1Value, dbo.tEnhancedPurchaseInfo.AdditionalPrice2Denomination, dbo.tEnhancedPurchaseInfo.AdditionalPrice2Value, 
                         dbo.tEnhancedPurchaseInfo.OrderDate, dbo.tEnhancedPurchaseInfo.ShippingDate, dbo.tEnhancedPurchaseInfo.DeliveryDate, dbo.tEnhancedPurchaseInfo.AdditionalDate1, dbo.tEnhancedPurchaseInfo.AdditionalDate2
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tEnhancedPurchaseInfo ON dbo.tDVD.DVDId = dbo.tEnhancedPurchaseInfo.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxDisc](
	[DVDxDiscId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[DescriptionSideA] [nvarchar](255) NULL,
	[DescriptionSideB] [nvarchar](255) NULL,
	[DiscIDSideA] [nvarchar](50) NULL,
	[DiscIDSideB] [nvarchar](50) NULL,
	[LabelSideA] [nvarchar](255) NULL,
	[LabelSideB] [nvarchar](255) NULL,
	[DualLayeredSideA] [bit] NOT NULL,
	[DualLayeredSideB] [bit] NOT NULL,
	[DualSided] [bit] NOT NULL,
	[Location] [nvarchar](255) NULL,
	[Slot] [nvarchar](255) NULL,
 CONSTRAINT [PK_tDVDxDisc] PRIMARY KEY CLUSTERED 
(
	[DVDxDiscId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxDisc]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tDVDxDisc.DescriptionSideA, dbo.tDVDxDisc.LabelSideA, dbo.tDVDxDisc.DescriptionSideB, dbo.tDVDxDisc.LabelSideB, 
                         dbo.tDVDxDisc.Location, dbo.tDVDxDisc.Slot
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxDisc ON dbo.tDVD.DVDId = dbo.tDVDxDisc.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tEnhancedTitles](
	[EnhancedTitlesId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Title1] [ntext] NULL,
	[Title2] [ntext] NULL,
	[Title3] [ntext] NULL,
	[Title4] [ntext] NULL,
	[Title5] [ntext] NULL,
 CONSTRAINT [PK_tEnhancedTitles] PRIMARY KEY CLUSTERED 
(
	[EnhancedTitlesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vEnhancedTitles]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tEnhancedTitles.Title1, dbo.tEnhancedTitles.Title2, dbo.tEnhancedTitles.Title3, dbo.tEnhancedTitles.Title4, 
                         dbo.tEnhancedTitles.Title5
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tEnhancedTitles ON dbo.tDVD.DVDId = dbo.tEnhancedTitles.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tFeatures](
	[FeaturesId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[SceneAccess] [bit] NOT NULL,
	[Commentary] [bit] NOT NULL,
	[Trailer] [bit] NOT NULL,
	[PhotoGallery] [bit] NOT NULL,
	[DeletedScenes] [bit] NOT NULL,
	[MakingOf] [bit] NOT NULL,
	[ProductionNotes] [bit] NOT NULL,
	[Game] [bit] NOT NULL,
	[DVDROMContent] [bit] NOT NULL,
	[MultiAngle] [bit] NOT NULL,
	[MusicVideos] [bit] NOT NULL,
	[Interviews] [bit] NOT NULL,
	[StoryboardComparisons] [bit] NOT NULL,
	[Outtakes] [bit] NOT NULL,
	[ClosedCaptioned] [bit] NOT NULL,
	[THXCertified] [bit] NOT NULL,
	[PictureInPicture] [bit] NOT NULL,
	[BDLive] [bit] NOT NULL,
	[BonusTrailers] [bit] NOT NULL,
	[DigitalCopy] [bit] NOT NULL,
	[DBOX] [bit] NOT NULL,
	[CineChat] [bit] NOT NULL,
	[PlayAll] [bit] NOT NULL,
	[MovieIQ] [bit] NOT NULL,
	[OtherFeatures] [nvarchar](255) NULL,
 CONSTRAINT [PK_tFeatures] PRIMARY KEY CLUSTERED 
(
	[FeaturesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vFeatures]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tFeatures.SceneAccess, dbo.tFeatures.Commentary, dbo.tFeatures.Trailer, dbo.tFeatures.PhotoGallery, 
                         dbo.tFeatures.MakingOf, dbo.tFeatures.ProductionNotes, dbo.tFeatures.Game, dbo.tFeatures.DVDROMContent, dbo.tFeatures.MultiAngle, dbo.tFeatures.MusicVideos, dbo.tFeatures.Interviews, 
                         dbo.tFeatures.StoryboardComparisons, dbo.tFeatures.Outtakes, dbo.tFeatures.ClosedCaptioned, dbo.tFeatures.THXCertified, dbo.tFeatures.PictureInPicture, dbo.tFeatures.BDLive, dbo.tFeatures.BonusTrailers, 
                         dbo.tFeatures.DigitalCopy, dbo.tFeatures.DBOX, dbo.tFeatures.CineChat, dbo.tFeatures.PlayAll, dbo.tFeatures.MovieIQ, dbo.tFeatures.OtherFeatures
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tFeatures ON dbo.tDVD.DVDId = dbo.tFeatures.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tVideoStandard](
	[VideoStandardId] [int] IDENTITY(1,1) NOT NULL,
	[VideoStandard] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tVideoStandard] PRIMARY KEY CLUSTERED 
(
	[VideoStandardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tFormat](
	[FormatId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[AspectRatio] [nvarchar](50) NULL,
	[VideoStandardId] [int] NULL,
	[LetterBox] [bit] NOT NULL,
	[PanAndScan] [bit] NOT NULL,
	[FullFrame] [bit] NOT NULL,
	[16X9] [bit] NOT NULL,
	[DualSided] [bit] NOT NULL,
	[DualLayered] [bit] NOT NULL,
	[Color] [bit] NOT NULL,
	[BlackAndWhite] [bit] NOT NULL,
	[Colorized] [bit] NOT NULL,
	[Mixed] [bit] NOT NULL,
	[2D] [bit] NOT NULL,
	[3DAnaglyph] [bit] NOT NULL,
	[3DBluRay] [bit] NOT NULL,
	[HDR10] [bit] NULL,
	[DolbyVision] [bit] NULL,
 CONSTRAINT [PK_tFormat] PRIMARY KEY CLUSTERED 
(
	[FormatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vFormat]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tFormat.AspectRatio, dbo.tVideoStandard.VideoStandard, dbo.tFormat.LetterBox, dbo.tFormat.PanAndScan, 
                         dbo.tFormat.[16X9], dbo.tFormat.DualSided, dbo.tFormat.DualLayered, dbo.tFormat.Color, dbo.tFormat.BlackAndWhite, dbo.tFormat.Colorized, dbo.tFormat.Mixed, dbo.tFormat.[2D], dbo.tFormat.[3DAnaglyph], 
                         dbo.tFormat.[3DBluRay], dbo.tFormat.HDR10, dbo.tFormat.DolbyVision
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tFormat ON dbo.tDVD.DVDId = dbo.tFormat.DVDId LEFT OUTER JOIN
                         dbo.tVideoStandard ON dbo.tFormat.VideoStandardId = dbo.tVideoStandard.VideoStandardId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxGenre](
	[DVDxGenreId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[GenreId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxGenre] PRIMARY KEY CLUSTERED 
(
	[DVDxGenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tGenre](
	[GenreId] [int] IDENTITY(1,1) NOT NULL,
	[Genre] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tGenre] PRIMARY KEY CLUSTERED 
(
	[GenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxGenre]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tGenre.Genre
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxGenre ON dbo.tDVD.DVDId = dbo.tDVDxGenre.DVDId INNER JOIN
                         dbo.tGenre ON dbo.tDVDxGenre.GenreId = dbo.tGenre.GenreId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vGenreGrouped]
AS
SELECT        Genre, CollectionType, Count
FROM            (SELECT        Genre, CollectionType, COUNT(*) AS Count
                          FROM            dbo.vDVDxGenre
                          GROUP BY Genre, CollectionType) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tLoanInfo](
	[LoanInfoId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Loaned] [bit] NOT NULL,
	[Due] [date] NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_tLoanInfo] PRIMARY KEY CLUSTERED 
(
	[LoanInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](225) NOT NULL,
	[FirstName] [nvarchar](225) NOT NULL,
	[EMailAddress] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](255) NULL,
 CONSTRAINT [PK_tUser] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLoanInfo]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tUser.FirstName, dbo.tUser.LastName, dbo.tLoanInfo.Due, dbo.tUser.EMailAddress, dbo.tUser.PhoneNumber
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tLoanInfo ON dbo.tDVD.DVDId = dbo.tLoanInfo.DVDId INNER JOIN
                         dbo.tUser ON dbo.tLoanInfo.UserId = dbo.tUser.UserId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tLock](
	[LockId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Entire] [bit] NOT NULL,
	[Covers] [bit] NOT NULL,
	[Title] [bit] NOT NULL,
	[MediaType] [bit] NOT NULL,
	[Overview] [bit] NOT NULL,
	[Regions] [bit] NOT NULL,
	[Genres] [bit] NOT NULL,
	[SRP] [bit] NOT NULL,
	[Studios] [bit] NOT NULL,
	[DiscInformation] [bit] NOT NULL,
	[Cast] [bit] NOT NULL,
	[Crew] [bit] NOT NULL,
	[Features] [bit] NOT NULL,
	[AudioTracks] [bit] NOT NULL,
	[Subtitles] [bit] NOT NULL,
	[EasterEggs] [bit] NOT NULL,
	[RunningTime] [bit] NOT NULL,
	[ReleaseDate] [bit] NOT NULL,
	[ProductionYear] [bit] NOT NULL,
	[CaseType] [bit] NOT NULL,
	[VideoFormats] [bit] NOT NULL,
	[Rating] [bit] NOT NULL,
 CONSTRAINT [PK_tLock] PRIMARY KEY CLUSTERED 
(
	[LockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLock]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title AS DVDTitle, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tLock.Entire, dbo.tLock.Covers, dbo.tLock.Title, dbo.tLock.MediaType, dbo.tLock.Overview, dbo.tLock.Regions, 
                         dbo.tLock.Genres, dbo.tLock.SRP, dbo.tLock.Studios, dbo.tLock.DiscInformation, dbo.tLock.Cast, dbo.tLock.Crew, dbo.tLock.Features, dbo.tLock.AudioTracks, dbo.tLock.Subtitles, dbo.tLock.EasterEggs, dbo.tLock.RunningTime, 
                         dbo.tLock.ReleaseDate, dbo.tLock.ProductionYear, dbo.tLock.CaseType, dbo.tLock.VideoFormats, dbo.tLock.Rating
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tLock ON dbo.tDVD.DVDId = dbo.tLock.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPurchase](
	[PurchaseId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[PriceDenomination] [nvarchar](50) NULL,
	[PriceValue] [decimal](18, 2) NULL,
	[PurchasePlaceId] [int] NULL,
	[Date] [date] NULL,
	[ReceivedAsGift] [bit] NOT NULL,
	[GiftFromUserId] [int] NULL,
 CONSTRAINT [PK_tPurchase] PRIMARY KEY CLUSTERED 
(
	[PurchaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPurchasePlace](
	[PurchasePlaceId] [int] IDENTITY(1,1) NOT NULL,
	[Place] [nvarchar](255) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Website] [nvarchar](255) NULL,
 CONSTRAINT [PK_tPurchasePlace] PRIMARY KEY CLUSTERED 
(
	[PurchasePlaceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPurchase]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tPurchase.PriceDenomination, dbo.tPurchase.PriceValue, dbo.tPurchasePlace.Place, dbo.tPurchasePlace.Type AS PlaceType,
                          dbo.tPurchasePlace.Website, dbo.tPurchase.Date, dbo.tPurchase.ReceivedAsGift, dbo.tUser.FirstName, dbo.tUser.LastName
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tPurchase ON dbo.tDVD.DVDId = dbo.tPurchase.DVDId INNER JOIN
                         dbo.tPurchasePlace ON dbo.tPurchase.PurchasePlaceId = dbo.tPurchasePlace.PurchasePlaceId LEFT OUTER JOIN
                         dbo.tUser ON dbo.tPurchase.GiftFromUserId = dbo.tUser.UserId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPurchaseByMonth]
AS
SELECT        SUM(PriceValue) AS Price, PriceDenomination AS Denomination, MONTH(Date) AS Month, YEAR(Date) AS Year
FROM            dbo.vPurchase
WHERE        (PriceValue <> 0)
GROUP BY PriceDenomination, MONTH(Date), YEAR(Date)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPurchaseByYear]
AS
SELECT        SUM(PriceValue) AS Price, PriceDenomination AS Denomination, YEAR(Date) AS Year
FROM            dbo.vPurchase
WHERE        (PriceValue <> 0)
GROUP BY PriceDenomination, YEAR(Date)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tReview](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Film] [int] NOT NULL,
	[Video] [int] NOT NULL,
	[Audio] [int] NOT NULL,
	[Extras] [int] NOT NULL,
 CONSTRAINT [PK_tReview] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vReview]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tReview.Film, dbo.tReview.Video, dbo.tReview.Audio, dbo.tReview.Extras
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tReview ON dbo.tDVD.DVDId = dbo.tReview.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tLocality](
	[LocalityId] [int] NOT NULL,
	[Locality] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tLocality] PRIMARY KEY CLUSTERED 
(
	[LocalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDId](
	[DVDIdId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[IdBase] [nvarchar](50) NOT NULL,
	[VariantNum] [int] NOT NULL,
	[LocalityId] [int] NOT NULL,
	[IdType] [int] NOT NULL,
 CONSTRAINT [PK_tDVDId] PRIMARY KEY CLUSTERED 
(
	[DVDIdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCaseType](
	[CaseTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NULL,
 CONSTRAINT [PK_tCaseType] PRIMARY KEY CLUSTERED 
(
	[CaseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVD]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.UPC, dbo.tLocality.Locality, dbo.tDVD.CollectionNumber, dbo.tCollectionType.Type AS CollectionType, dbo.tCollectionType.IsPartOfOwnedCollection, dbo.tDVD.Title, dbo.tDVD.DistTrait, 
                         ISNULL(dbo.tDVD.OriginalTitle, dbo.tDVD.Title) AS OriginalTitle, dbo.tDVD.ProductionYear, dbo.tDVD.Released, dbo.tDVD.RunningTime, dbo.tDVD.Rating, dbo.tCaseType.Type AS CaseType, dbo.tDVD.CaseSlipCover, 
                         dbo.tDVD.SRPDenomination, dbo.tDVD.SRPValue, dbo.tDVD.Overview, dbo.tDVD.EasterEggs, dbo.tDVD.SortTitle, dbo.tDVD.LastEdited, dbo.tDVD.WishPriority, dbo.tDVD.Notes
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDId ON dbo.tDVD.DVDId = dbo.tDVDId.DVDId INNER JOIN
                         dbo.tLocality ON dbo.tDVDId.LocalityId = dbo.tLocality.LocalityId LEFT OUTER JOIN
                         dbo.tCaseType ON dbo.tDVD.CaseTypeId = dbo.tCaseType.CaseTypeId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDIdType](
	[DVDIdTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tDVDIdType] PRIMARY KEY CLUSTERED 
(
	[DVDIdTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDId]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tDVDIdType.Type AS IdType, dbo.tDVDId.IdBase, dbo.tLocality.Locality, dbo.tDVDId.VariantNum
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDId ON dbo.tDVD.DVDId = dbo.tDVDId.DVDId INNER JOIN
                         dbo.tLocality ON dbo.tDVDId.LocalityId = dbo.tLocality.LocalityId INNER JOIN
                         dbo.tDVDIdType ON dbo.tDVDId.IdType = dbo.tDVDIdType.Type
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tStudioAndMediaCompany](
	[StudioAndMediaCompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tStudioAndMediaCompany] PRIMARY KEY CLUSTERED 
(
	[StudioAndMediaCompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxStudio](
	[DVDxStudioId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[StudioId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxStudio] PRIMARY KEY CLUSTERED 
(
	[DVDxStudioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxStudio]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tStudioAndMediaCompany.Name AS Studio
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxStudio ON dbo.tDVD.DVDId = dbo.tDVDxStudio.DVDId INNER JOIN
                         dbo.tStudioAndMediaCompany ON dbo.tDVDxStudio.StudioId = dbo.tStudioAndMediaCompany.StudioAndMediaCompanyId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vStudioGrouped]
AS
SELECT        Studio, CollectionType, Count
FROM            (SELECT        Studio, vDVDxStudio.CollectionType, COUNT(*) AS Count
                          FROM            dbo.vDVDxStudio
                          GROUP BY Studio, vDVDxStudio.CollectionType) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxAudio](
	[DVDxAudioId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[AudioContentId] [int] NOT NULL,
	[AudioFormatId] [int] NULL,
	[AudioChannelsId] [int] NULL,
 CONSTRAINT [PK_tDVDxAudio] PRIMARY KEY CLUSTERED 
(
	[DVDxAudioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAudioChannels](
	[AudioChannelsId] [int] IDENTITY(1,1) NOT NULL,
	[Channels] [nvarchar](255) NULL,
 CONSTRAINT [PK_tAudioChannels] PRIMARY KEY CLUSTERED 
(
	[AudioChannelsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAudioContent](
	[AudioContentId] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](255) NULL,
 CONSTRAINT [PK_tAudioContent] PRIMARY KEY CLUSTERED 
(
	[AudioContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAudioFormat](
	[AudioFormatId] [int] IDENTITY(1,1) NOT NULL,
	[Format] [nvarchar](255) NULL,
 CONSTRAINT [PK_tAudioFormat] PRIMARY KEY CLUSTERED 
(
	[AudioFormatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxAudio]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tAudioContent.[Content] AS AudioContent, dbo.tAudioFormat.Format AS AudioFormat, 
                         dbo.tAudioChannels.Channels AS AudioChannels
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tCollectionType.CollectionTypeId = dbo.tDVD.CollectionTypeId INNER JOIN
                         dbo.tDVDxAudio ON dbo.tDVD.DVDId = dbo.tDVDxAudio.DVDId INNER JOIN
                         dbo.tAudioContent ON dbo.tDVDxAudio.AudioContentId = dbo.tAudioContent.AudioContentId LEFT OUTER JOIN
                         dbo.tAudioFormat ON dbo.tDVDxAudio.AudioFormatId = dbo.tAudioFormat.AudioFormatId LEFT OUTER JOIN
                         dbo.tAudioChannels ON dbo.tDVDxAudio.AudioChannelsId = dbo.tAudioChannels.AudioChannelsId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tParentDVDxChildDVD](
	[ParentDVDxChildDVDId] [int] IDENTITY(1,1) NOT NULL,
	[ParentDVDId] [nvarchar](50) NOT NULL,
	[ChildDVDId] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tDVDxDVD] PRIMARY KEY CLUSTERED 
(
	[ParentDVDxChildDVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vParentChildDVD]
AS
SELECT        tParentDVD.DVDId AS ParentDVDId, tParentDVD.Title AS ParentTitle, tParentDVD.DistTrait AS ParentDistTrait, tParentCollectionType.Type AS ParentCollectionType, tChildDVD.DVDId AS ChildDVDId, tChildDVD.Title AS ChildTitle, 
                         tChildDVD.DistTrait AS ChildDistTrait, tChildCollectionType.Type AS ChildCollectionType
FROM            dbo.tParentDVDxChildDVD INNER JOIN
                         dbo.tDVD AS tParentDVD ON dbo.tParentDVDxChildDVD.ParentDVDId = tParentDVD.DVDId INNER JOIN
                         dbo.tCollectionType AS tParentCollectionType ON tParentDVD.CollectionTypeId = tParentCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVD AS tChildDVD ON dbo.tParentDVDxChildDVD.ChildDVDId = tChildDVD.DVDId INNER JOIN
                         dbo.tCollectionType AS tChildCollectionType ON tChildDVD.CollectionTypeId = tChildCollectionType.CollectionTypeId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxCountryOfOrigin](
	[DVDxCountryOfOriginId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[CountryOfOriginId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxCountryOfOrigin] PRIMARY KEY CLUSTERED 
(
	[DVDxCountryOfOriginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCountryOfOrigin](
	[CountryOfOriginId] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](255) NULL,
 CONSTRAINT [PK_tCountryOfOrigin] PRIMARY KEY CLUSTERED 
(
	[CountryOfOriginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxCountryOfOrigin]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tCountryOfOrigin.Country AS CountryOfOrigin
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxCountryOfOrigin ON dbo.tDVD.DVDId = dbo.tDVDxCountryOfOrigin.DVDId INNER JOIN
                         dbo.tCountryOfOrigin ON dbo.tDVDxCountryOfOrigin.CountryOfOriginId = dbo.tCountryOfOrigin.CountryOfOriginId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCountryOfOriginGrouped]
AS
SELECT        CountryOfOrigin, CollectionType, Count
FROM            (SELECT        CountryOfOrigin, CollectionType, COUNT(*) AS Count
                          FROM            dbo.vDVDxCountryOfOrigin
                          GROUP BY CountryOfOrigin, CollectionType) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxMediaCompany](
	[DVDxMediaCompanyId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[MediaCompanyId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxMediaCompany] PRIMARY KEY CLUSTERED 
(
	[DVDxMediaCompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxMediaCompany]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tStudioAndMediaCompany.Name AS MediaCompany
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxMediaCompany ON dbo.tDVD.DVDId = dbo.tDVDxMediaCompany.DVDId INNER JOIN
                         dbo.tStudioAndMediaCompany ON dbo.tDVDxMediaCompany.MediaCompanyId = dbo.tStudioAndMediaCompany.StudioAndMediaCompanyId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vMediaCompanyGrouped]
AS
SELECT        MediaCompany, CollectionType, Count
FROM            (SELECT        MediaCompany, vDVDxmediacompany.CollectionType, COUNT(*) AS Count
                          FROM            dbo.vDVDxMediaCompany
                          GROUP BY MediaCompany, vDVDxmediacompany.CollectionType) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCastAndCrew](
	[CastAndCrewId] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](150) NULL,
	[MiddleName] [nvarchar](148) NULL,
	[FirstName] [nvarchar](150) NOT NULL,
	[BirthYear] [int] NULL,
 CONSTRAINT [PK_tCastAndCrew] PRIMARY KEY CLUSTERED 
(
	[CastAndCrewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxCrew](
	[DVDxCrewId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[CrewId] [int] NOT NULL,
	[CreditSubtypeId] [int] NOT NULL,
	[CreditedAs] [nvarchar](255) NULL,
	[Episode] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[CustomRole] [nvarchar](255) NULL,
 CONSTRAINT [PK_tDVDxCrew] PRIMARY KEY CLUSTERED 
(
	[DVDxCrewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCreditSubtype](
	[CreditSubtypeId] [int] IDENTITY(1,1) NOT NULL,
	[CreditTypeId] [int] NOT NULL,
	[Subtype] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tCreditSubtype] PRIMARY KEY CLUSTERED 
(
	[CreditSubtypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCreditType](
	[CreditTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tCreditType] PRIMARY KEY CLUSTERED 
(
	[CreditTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxCrew]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tDVDxCrew.OrderNumber, dbo.tCastAndCrew.LastName, dbo.tCastAndCrew.FirstName, dbo.tCastAndCrew.MiddleName, 
                         dbo.tCastAndCrew.BirthYear, dbo.tDVDxCrew.CreditedAs, dbo.tDVDxCrew.Episode, dbo.tDVDxCrew.[Group], dbo.tCreditType.Type AS CreditType, dbo.tCreditSubtype.Subtype AS CreditSubtype, dbo.tDVDxCrew.CustomRole
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxCrew ON dbo.tDVD.DVDId = dbo.tDVDxCrew.DVDId INNER JOIN
                         dbo.tCastAndCrew ON dbo.tDVDxCrew.CrewId = dbo.tCastAndCrew.CastAndCrewId INNER JOIN
                         dbo.tCreditSubtype ON dbo.tDVDxCrew.CreditSubtypeId = dbo.tCreditSubtype.CreditSubtypeId INNER JOIN
                         dbo.tCreditType ON dbo.tCreditSubtype.CreditTypeId = dbo.tCreditType.CreditTypeId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCollectionTypeGrouped]
AS
SELECT        CollectionType, IsPartOfOwnedCollection, Count
FROM            (SELECT        dbo.tCollectionType.Type AS CollectionType, dbo.tCollectionType.IsPartOfOwnedCollection, COUNT(*) AS Count
                          FROM            dbo.tCollectionType INNER JOIN
                                                    dbo.tDVD ON dbo.tCollectionType.CollectionTypeId = dbo.tDVD.CollectionTypeId
                          GROUP BY dbo.tCollectionType.Type, dbo.tCollectionType.IsPartOfOwnedCollection) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDigitalDownloadInfo](
	[DigitalDownloadInfoId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Company] [nvarchar](255) NOT NULL,
	[Code] [ntext] NOT NULL,
 CONSTRAINT [PK_tDigitalDownloadInfo] PRIMARY KEY CLUSTERED 
(
	[DigitalDownloadInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDigitalDownloadInfo]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tDigitalDownloadInfo.Company, dbo.tDigitalDownloadInfo.Code
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDigitalDownloadInfo ON dbo.tDVD.DVDId = dbo.tDigitalDownloadInfo.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxEvent](
	[DVDxEventId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[EventTypeId] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Note] [ntext] NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxEvent] PRIMARY KEY CLUSTERED 
(
	[DVDxEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tEventType](
	[EventTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_tEventType] PRIMARY KEY CLUSTERED 
(
	[EventTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxEvent]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tEventType.Type, dbo.tDVDxEvent.Timestamp, dbo.tUser.LastName, dbo.tUser.FirstName, dbo.tUser.EMailAddress, 
                         dbo.tUser.PhoneNumber, dbo.tDVDxEvent.Note
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxEvent ON dbo.tDVD.DVDId = dbo.tDVDxEvent.DVDId INNER JOIN
                         dbo.tEventType ON dbo.tDVDxEvent.EventTypeId = dbo.tEventType.EventTypeId INNER JOIN
                         dbo.tUser ON dbo.tDVDxEvent.UserId = dbo.tUser.UserId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxCast](
	[DVDxCastId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[CastId] [int] NOT NULL,
	[Role] [nvarchar](255) NULL,
	[CreditedAs] [nvarchar](255) NULL,
	[Voice] [bit] NOT NULL,
	[Uncredited] [bit] NOT NULL,
	[Puppeteer] [bit] NOT NULL,
	[Episode] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
 CONSTRAINT [PK_tDVDxCast] PRIMARY KEY CLUSTERED 
(
	[DVDxCastId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxCast]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tDVDxCast.OrderNumber, dbo.tCastAndCrew.LastName, dbo.tCastAndCrew.FirstName, dbo.tCastAndCrew.MiddleName, 
                         dbo.tCastAndCrew.BirthYear, dbo.tDVDxCast.Episode, dbo.tDVDxCast.[Group], dbo.tDVDxCast.Role, dbo.tDVDxCast.CreditedAs, dbo.tDVDxCast.Voice, dbo.tDVDxCast.Uncredited, dbo.tDVDxCast.Puppeteer
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxCast ON dbo.tDVD.DVDId = dbo.tDVDxCast.DVDId INNER JOIN
                         dbo.tCastAndCrew ON dbo.tDVDxCast.CastId = dbo.tCastAndCrew.CastAndCrewId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCastGrouped]
AS
SELECT        LastName, FirstName, MiddleName, BirthYear, CollectionType, Count
FROM            (SELECT        LastName, FirstName, MiddleName, BirthYear, CollectionType, COUNT(*) AS Count
                          FROM            dbo.vDVDxCast
                          GROUP BY CollectionType, LastName, FirstName, MiddleName, BirthYear) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPluginData](
	[PluginDataId] [int] IDENTITY(1,1) NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tPluginData] PRIMARY KEY CLUSTERED 
(
	[PluginDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxPluginData](
	[DVDxPluginDataId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[PluginDataId] [int] NOT NULL,
	[PluginData] [ntext] NULL,
 CONSTRAINT [PK_tDVDxPluginData] PRIMARY KEY CLUSTERED 
(
	[DVDxPluginDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxPluginData]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tPluginData.Name, dbo.tDVDxPluginData.PluginData
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxPluginData ON dbo.tDVD.DVDId = dbo.tDVDxPluginData.DVDId INNER JOIN
                         dbo.tPluginData ON dbo.tDVDxPluginData.PluginDataId = dbo.tPluginData.PluginDataId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxRegion](
	[DVDxRegionId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_tDVDxRegion] PRIMARY KEY CLUSTERED 
(
	[DVDxRegionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxRegion]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tDVDxRegion.Region
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxRegion ON dbo.tDVD.DVDId = dbo.tDVDxRegion.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tTag](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tTag] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxTag](
	[DVDxTagId] [int] IDENTITY(1,1) NOT NULL,
	[DVDid] [nvarchar](50) NOT NULL,
	[TagId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxTag] PRIMARY KEY CLUSTERED 
(
	[DVDxTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDVDxTag]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tTag.FullName AS Tag
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tDVDxTag ON dbo.tDVD.DVDId = dbo.tDVDxTag.DVDid INNER JOIN
                         dbo.tTag ON dbo.tDVDxTag.TagId = dbo.tTag.TagId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTagGrouped]
AS
SELECT        Tag, CollectionType, Count
FROM            (SELECT        Tag, CollectionType, COUNT(*) AS Count
                          FROM            dbo.vDVDxTag
                          GROUP BY CollectionType, Tag) AS itab
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tEnhancedFeatures](
	[EnhancedFeatureId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Feature1] [bit] NOT NULL,
	[Feature2] [bit] NOT NULL,
	[Feature3] [bit] NOT NULL,
	[Feature4] [bit] NOT NULL,
	[Feature5] [bit] NOT NULL,
	[Feature6] [bit] NOT NULL,
	[Feature7] [bit] NOT NULL,
	[Feature8] [bit] NOT NULL,
	[Feature9] [bit] NOT NULL,
	[Feature10] [bit] NOT NULL,
	[Feature11] [bit] NOT NULL,
	[Feature12] [bit] NOT NULL,
	[Feature13] [bit] NOT NULL,
	[Feature14] [bit] NOT NULL,
	[Feature15] [bit] NOT NULL,
	[Feature16] [bit] NOT NULL,
	[Feature17] [bit] NOT NULL,
	[Feature18] [bit] NOT NULL,
	[Feature19] [bit] NOT NULL,
	[Feature20] [bit] NOT NULL,
	[Feature21] [bit] NOT NULL,
	[Feature22] [bit] NOT NULL,
	[Feature23] [bit] NOT NULL,
	[Feature24] [bit] NOT NULL,
	[Feature25] [bit] NOT NULL,
	[Feature26] [bit] NOT NULL,
	[Feature27] [bit] NOT NULL,
	[Feature28] [bit] NOT NULL,
	[Feature29] [bit] NOT NULL,
	[Feature30] [bit] NOT NULL,
	[Feature31] [bit] NOT NULL,
	[Feature32] [bit] NOT NULL,
	[Feature33] [bit] NOT NULL,
	[Feature34] [bit] NOT NULL,
	[Feature35] [bit] NOT NULL,
	[Feature36] [bit] NOT NULL,
	[Feature37] [bit] NOT NULL,
	[Feature38] [bit] NOT NULL,
	[Feature39] [bit] NOT NULL,
	[Feature40] [bit] NOT NULL,
 CONSTRAINT [PK_tEnhancedFeatures] PRIMARY KEY CLUSTERED 
(
	[EnhancedFeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vEnhancedFeatures]
AS
SELECT        dbo.tDVD.DVDId, dbo.tDVD.Title, dbo.tDVD.DistTrait, dbo.tCollectionType.Type AS CollectionType, dbo.tEnhancedFeatures.Feature1, dbo.tEnhancedFeatures.Feature2, dbo.tEnhancedFeatures.Feature3, 
                         dbo.tEnhancedFeatures.Feature4, dbo.tEnhancedFeatures.Feature5, dbo.tEnhancedFeatures.Feature6, dbo.tEnhancedFeatures.Feature7, dbo.tEnhancedFeatures.Feature8, dbo.tEnhancedFeatures.Feature9, 
                         dbo.tEnhancedFeatures.Feature10, dbo.tEnhancedFeatures.Feature11, dbo.tEnhancedFeatures.Feature12, dbo.tEnhancedFeatures.Feature13, dbo.tEnhancedFeatures.Feature14, dbo.tEnhancedFeatures.Feature15, 
                         dbo.tEnhancedFeatures.Feature16, dbo.tEnhancedFeatures.Feature17, dbo.tEnhancedFeatures.Feature18, dbo.tEnhancedFeatures.Feature19, dbo.tEnhancedFeatures.Feature20, dbo.tEnhancedFeatures.Feature21, 
                         dbo.tEnhancedFeatures.Feature22, dbo.tEnhancedFeatures.Feature23, dbo.tEnhancedFeatures.Feature24, dbo.tEnhancedFeatures.Feature25, dbo.tEnhancedFeatures.Feature26, dbo.tEnhancedFeatures.Feature27, 
                         dbo.tEnhancedFeatures.Feature28, dbo.tEnhancedFeatures.Feature29, dbo.tEnhancedFeatures.Feature30, dbo.tEnhancedFeatures.Feature31, dbo.tEnhancedFeatures.Feature32, dbo.tEnhancedFeatures.Feature33, 
                         dbo.tEnhancedFeatures.Feature34, dbo.tEnhancedFeatures.Feature35, dbo.tEnhancedFeatures.Feature36, dbo.tEnhancedFeatures.Feature37, dbo.tEnhancedFeatures.Feature38, dbo.tEnhancedFeatures.Feature39, 
                         dbo.tEnhancedFeatures.Feature40
FROM            dbo.tDVD INNER JOIN
                         dbo.tCollectionType ON dbo.tDVD.CollectionTypeId = dbo.tCollectionType.CollectionTypeId INNER JOIN
                         dbo.tEnhancedFeatures ON dbo.tDVD.DVDId = dbo.tEnhancedFeatures.DVDId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDBVersion](
	[Version] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tDBVersion] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxMediaType](
	[DVDxMediaTypeId] [int] IDENTITY(1,1) NOT NULL,
	[DVDid] [nvarchar](50) NOT NULL,
	[MediaTypeId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxMediaType] PRIMARY KEY CLUSTERED 
(
	[DVDxMediaTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxMyLinks](
	[DVDxMyLinkId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[Url] [ntext] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxMyLinks] PRIMARY KEY CLUSTERED 
(
	[DVDxMyLinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDVDxSubtitle](
	[DVDxSubtitleId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[SubtitleId] [int] NOT NULL,
 CONSTRAINT [PK_tDVDxSubtitle] PRIMARY KEY CLUSTERED 
(
	[DVDxSubtitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tExclusions](
	[ExclusionId] [int] IDENTITY(1,1) NOT NULL,
	[DVDId] [nvarchar](50) NOT NULL,
	[MoviePick] [bit] NULL,
	[Mobile] [bit] NULL,
	[IPhone] [bit] NULL,
	[RemoteConnections] [bit] NULL,
	[DPOPublic] [bit] NULL,
	[DPOPrivate] [bit] NULL,
 CONSTRAINT [PK_tExclusions] PRIMARY KEY CLUSTERED 
(
	[ExclusionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tLinkCategory](
	[LinkCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tLinkCategory] PRIMARY KEY CLUSTERED 
(
	[LinkCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tMediaType](
	[MediyTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tMediaType] PRIMARY KEY CLUSTERED 
(
	[MediyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tSubtitle](
	[SubtitleId] [int] IDENTITY(1,1) NOT NULL,
	[Subtitle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tSubtitle] PRIMARY KEY CLUSTERED 
(
	[SubtitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tDBVersion] ([Version]) VALUES (N'4.0.0.0')
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tAudioChannels] ADD  CONSTRAINT [UK_tAudioChannels] UNIQUE NONCLUSTERED 
(
	[Channels] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tAudioContent] ADD  CONSTRAINT [UK_tAudioContent] UNIQUE NONCLUSTERED 
(
	[Content] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tAudioFormat] ADD  CONSTRAINT [UK_tAudioFormat] UNIQUE NONCLUSTERED 
(
	[Format] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tCaseType] ADD  CONSTRAINT [UK_tCaseType] UNIQUE NONCLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tCastAndCrew] ADD  CONSTRAINT [UK_tCastAndCrew] UNIQUE NONCLUSTERED 
(
	[FirstName] ASC,
	[MiddleName] ASC,
	[LastName] ASC,
	[BirthYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tCollectionType] ADD  CONSTRAINT [UK_tCollectionType] UNIQUE NONCLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tCountryOfOrigin] ADD  CONSTRAINT [UK_tCountryOfOrigin] UNIQUE NONCLUSTERED 
(
	[Country] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tCreditSubtype] ADD  CONSTRAINT [UK_tCreditSubtype] UNIQUE NONCLUSTERED 
(
	[CreditTypeId] ASC,
	[Subtype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tCreditType] ADD  CONSTRAINT [UK_tCreditType] UNIQUE NONCLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tDigitalDownloadInfo] ADD  CONSTRAINT [UK_tDigitalDownloadInfo] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tDVDId] ADD  CONSTRAINT [UK_tDVDId] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tDVDIdType] ADD  CONSTRAINT [UK_tDVDIdType] UNIQUE NONCLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tDVDxCast] ADD  CONSTRAINT [UK_tDVDxCast] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC,
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tDVDxCrew] ADD  CONSTRAINT [UK_tDVDxCrew] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC,
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tEnhancedFeatures] ADD  CONSTRAINT [UK_tEnhancedFeatures] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tEnhancedNotes] ADD  CONSTRAINT [UK_tEnhancedNotes] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tEnhancedPurchaseInfo] ADD  CONSTRAINT [UK_tEnhancedPurchaseInfo] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tEnhancedTitles] ADD  CONSTRAINT [UK_tEnhancedTitles] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tEventType] ADD  CONSTRAINT [UK_tEventType] UNIQUE NONCLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tExclusions] ADD  CONSTRAINT [UK_tExclusions] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tFeatures] ADD  CONSTRAINT [UK_tFeatures] UNIQUE NONCLUSTERED 
(
	[FeaturesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tFormat] ADD  CONSTRAINT [UK_tFormat] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tGenre] ADD  CONSTRAINT [UK_tGenre] UNIQUE NONCLUSTERED 
(
	[Genre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tLinkCategory] ADD  CONSTRAINT [UK_tLinkCategory] UNIQUE NONCLUSTERED 
(
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tLoanInfo] ADD  CONSTRAINT [UK_tLoanInfo] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tLocality] ADD  CONSTRAINT [UK_tLocality] UNIQUE NONCLUSTERED 
(
	[Locality] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tLock] ADD  CONSTRAINT [UK_tLock] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tMediaType] ADD  CONSTRAINT [UK_tMediaType] UNIQUE NONCLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tPluginData] ADD  CONSTRAINT [UK_tPluginData] UNIQUE NONCLUSTERED 
(
	[Guid] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tPurchase] ADD  CONSTRAINT [UK_tPurchase] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tPurchasePlace] ADD  CONSTRAINT [UK_tPurchasePlace] UNIQUE NONCLUSTERED 
(
	[Place] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tReview] ADD  CONSTRAINT [UK_tReview] UNIQUE NONCLUSTERED 
(
	[DVDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tStudioAndMediaCompany] ADD  CONSTRAINT [UK_tStudioAndMediaCompany] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tSubtitle] ADD  CONSTRAINT [UK_tSubtitle] UNIQUE NONCLUSTERED 
(
	[Subtitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tTag] ADD  CONSTRAINT [UK_tTag] UNIQUE NONCLUSTERED 
(
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [UK_tUser] UNIQUE NONCLUSTERED 
(
	[FirstName] ASC,
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[tVideoStandard] ADD  CONSTRAINT [UK_tVideoStandard] UNIQUE NONCLUSTERED 
(
	[VideoStandard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tCreditSubtype]  WITH CHECK ADD  CONSTRAINT [FK_CreditType] FOREIGN KEY([CreditTypeId])
REFERENCES [dbo].[tCreditType] ([CreditTypeId])
GO
ALTER TABLE [dbo].[tCreditSubtype] CHECK CONSTRAINT [FK_CreditType]
GO
ALTER TABLE [dbo].[tDigitalDownloadInfo]  WITH CHECK ADD  CONSTRAINT [FK_DigitalDownloadInfo] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDigitalDownloadInfo] CHECK CONSTRAINT [FK_DigitalDownloadInfo]
GO
ALTER TABLE [dbo].[tDVD]  WITH CHECK ADD  CONSTRAINT [FK_CaseType] FOREIGN KEY([CaseTypeId])
REFERENCES [dbo].[tCaseType] ([CaseTypeId])
GO
ALTER TABLE [dbo].[tDVD] CHECK CONSTRAINT [FK_CaseType]
GO
ALTER TABLE [dbo].[tDVD]  WITH CHECK ADD  CONSTRAINT [FK_CollectionType] FOREIGN KEY([CollectionTypeId])
REFERENCES [dbo].[tCollectionType] ([CollectionTypeId])
GO
ALTER TABLE [dbo].[tDVD] CHECK CONSTRAINT [FK_CollectionType]
GO
ALTER TABLE [dbo].[tDVDId]  WITH CHECK ADD  CONSTRAINT [FK_DVDId] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDId] CHECK CONSTRAINT [FK_DVDId]
GO
ALTER TABLE [dbo].[tDVDId]  WITH CHECK ADD  CONSTRAINT [FK_DVDIdType] FOREIGN KEY([IdType])
REFERENCES [dbo].[tDVDIdType] ([DVDIdTypeId])
GO
ALTER TABLE [dbo].[tDVDId] CHECK CONSTRAINT [FK_DVDIdType]
GO
ALTER TABLE [dbo].[tDVDId]  WITH CHECK ADD  CONSTRAINT [FK_Locality] FOREIGN KEY([LocalityId])
REFERENCES [dbo].[tLocality] ([LocalityId])
GO
ALTER TABLE [dbo].[tDVDId] CHECK CONSTRAINT [FK_Locality]
GO
ALTER TABLE [dbo].[tDVDxAudio]  WITH CHECK ADD  CONSTRAINT [FK_AudioChannels] FOREIGN KEY([AudioChannelsId])
REFERENCES [dbo].[tAudioChannels] ([AudioChannelsId])
GO
ALTER TABLE [dbo].[tDVDxAudio] CHECK CONSTRAINT [FK_AudioChannels]
GO
ALTER TABLE [dbo].[tDVDxAudio]  WITH CHECK ADD  CONSTRAINT [FK_AudioContents] FOREIGN KEY([AudioContentId])
REFERENCES [dbo].[tAudioContent] ([AudioContentId])
GO
ALTER TABLE [dbo].[tDVDxAudio] CHECK CONSTRAINT [FK_AudioContents]
GO
ALTER TABLE [dbo].[tDVDxAudio]  WITH CHECK ADD  CONSTRAINT [FK_AudioFormats] FOREIGN KEY([AudioFormatId])
REFERENCES [dbo].[tAudioFormat] ([AudioFormatId])
GO
ALTER TABLE [dbo].[tDVDxAudio] CHECK CONSTRAINT [FK_AudioFormats]
GO
ALTER TABLE [dbo].[tDVDxAudio]  WITH CHECK ADD  CONSTRAINT [FK_AudioList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxAudio] CHECK CONSTRAINT [FK_AudioList]
GO
ALTER TABLE [dbo].[tDVDxCast]  WITH CHECK ADD  CONSTRAINT [FK_Cast] FOREIGN KEY([CastId])
REFERENCES [dbo].[tCastAndCrew] ([CastAndCrewId])
GO
ALTER TABLE [dbo].[tDVDxCast] CHECK CONSTRAINT [FK_Cast]
GO
ALTER TABLE [dbo].[tDVDxCast]  WITH CHECK ADD  CONSTRAINT [FK_CastList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxCast] CHECK CONSTRAINT [FK_CastList]
GO
ALTER TABLE [dbo].[tDVDxCountryOfOrigin]  WITH CHECK ADD  CONSTRAINT [FK_CountryOfOrigin] FOREIGN KEY([CountryOfOriginId])
REFERENCES [dbo].[tCountryOfOrigin] ([CountryOfOriginId])
GO
ALTER TABLE [dbo].[tDVDxCountryOfOrigin] CHECK CONSTRAINT [FK_CountryOfOrigin]
GO
ALTER TABLE [dbo].[tDVDxCountryOfOrigin]  WITH CHECK ADD  CONSTRAINT [FK_CountryOfOriginList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxCountryOfOrigin] CHECK CONSTRAINT [FK_CountryOfOriginList]
GO
ALTER TABLE [dbo].[tDVDxCrew]  WITH CHECK ADD  CONSTRAINT [FK_CreditSubtype] FOREIGN KEY([CreditSubtypeId])
REFERENCES [dbo].[tCreditSubtype] ([CreditSubtypeId])
GO
ALTER TABLE [dbo].[tDVDxCrew] CHECK CONSTRAINT [FK_CreditSubtype]
GO
ALTER TABLE [dbo].[tDVDxCrew]  WITH CHECK ADD  CONSTRAINT [FK_Crew] FOREIGN KEY([CrewId])
REFERENCES [dbo].[tCastAndCrew] ([CastAndCrewId])
GO
ALTER TABLE [dbo].[tDVDxCrew] CHECK CONSTRAINT [FK_Crew]
GO
ALTER TABLE [dbo].[tDVDxCrew]  WITH CHECK ADD  CONSTRAINT [FK_CrewList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxCrew] CHECK CONSTRAINT [FK_CrewList]
GO
ALTER TABLE [dbo].[tDVDxDisc]  WITH CHECK ADD  CONSTRAINT [FK_DiscList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxDisc] CHECK CONSTRAINT [FK_DiscList]
GO
ALTER TABLE [dbo].[tDVDxEvent]  WITH CHECK ADD  CONSTRAINT [FK_EventList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxEvent] CHECK CONSTRAINT [FK_EventList]
GO
ALTER TABLE [dbo].[tDVDxEvent]  WITH CHECK ADD  CONSTRAINT [FK_EventType] FOREIGN KEY([EventTypeId])
REFERENCES [dbo].[tEventType] ([EventTypeId])
GO
ALTER TABLE [dbo].[tDVDxEvent] CHECK CONSTRAINT [FK_EventType]
GO
ALTER TABLE [dbo].[tDVDxEvent]  WITH CHECK ADD  CONSTRAINT [FK_EventUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tUser] ([UserId])
GO
ALTER TABLE [dbo].[tDVDxEvent] CHECK CONSTRAINT [FK_EventUser]
GO
ALTER TABLE [dbo].[tDVDxGenre]  WITH CHECK ADD  CONSTRAINT [FK_Genre] FOREIGN KEY([GenreId])
REFERENCES [dbo].[tGenre] ([GenreId])
GO
ALTER TABLE [dbo].[tDVDxGenre] CHECK CONSTRAINT [FK_Genre]
GO
ALTER TABLE [dbo].[tDVDxGenre]  WITH CHECK ADD  CONSTRAINT [FK_GenreList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxGenre] CHECK CONSTRAINT [FK_GenreList]
GO
ALTER TABLE [dbo].[tDVDxMediaCompany]  WITH CHECK ADD  CONSTRAINT [FK_MediaCompany] FOREIGN KEY([MediaCompanyId])
REFERENCES [dbo].[tStudioAndMediaCompany] ([StudioAndMediaCompanyId])
GO
ALTER TABLE [dbo].[tDVDxMediaCompany] CHECK CONSTRAINT [FK_MediaCompany]
GO
ALTER TABLE [dbo].[tDVDxMediaCompany]  WITH CHECK ADD  CONSTRAINT [FK_MediaCompanyList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxMediaCompany] CHECK CONSTRAINT [FK_MediaCompanyList]
GO
ALTER TABLE [dbo].[tDVDxMediaType]  WITH CHECK ADD  CONSTRAINT [FK_MediaType] FOREIGN KEY([MediaTypeId])
REFERENCES [dbo].[tMediaType] ([MediyTypeId])
GO
ALTER TABLE [dbo].[tDVDxMediaType] CHECK CONSTRAINT [FK_MediaType]
GO
ALTER TABLE [dbo].[tDVDxMediaType]  WITH CHECK ADD  CONSTRAINT [FK_MediaTypeList] FOREIGN KEY([DVDid])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxMediaType] CHECK CONSTRAINT [FK_MediaTypeList]
GO
ALTER TABLE [dbo].[tDVDxMyLinks]  WITH CHECK ADD  CONSTRAINT [FK_LinkCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[tLinkCategory] ([LinkCategoryId])
GO
ALTER TABLE [dbo].[tDVDxMyLinks] CHECK CONSTRAINT [FK_LinkCategory]
GO
ALTER TABLE [dbo].[tDVDxMyLinks]  WITH CHECK ADD  CONSTRAINT [FK_LinkList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxMyLinks] CHECK CONSTRAINT [FK_LinkList]
GO
ALTER TABLE [dbo].[tDVDxPluginData]  WITH CHECK ADD  CONSTRAINT [FK_PluginData] FOREIGN KEY([PluginDataId])
REFERENCES [dbo].[tPluginData] ([PluginDataId])
GO
ALTER TABLE [dbo].[tDVDxPluginData] CHECK CONSTRAINT [FK_PluginData]
GO
ALTER TABLE [dbo].[tDVDxPluginData]  WITH CHECK ADD  CONSTRAINT [FK_PluginList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxPluginData] CHECK CONSTRAINT [FK_PluginList]
GO
ALTER TABLE [dbo].[tDVDxRegion]  WITH CHECK ADD  CONSTRAINT [FK_RegionList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxRegion] CHECK CONSTRAINT [FK_RegionList]
GO
ALTER TABLE [dbo].[tDVDxStudio]  WITH CHECK ADD  CONSTRAINT [FK_StudioList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxStudio] CHECK CONSTRAINT [FK_StudioList]
GO
ALTER TABLE [dbo].[tDVDxSubtitle]  WITH CHECK ADD  CONSTRAINT [FK_Subtitle] FOREIGN KEY([SubtitleId])
REFERENCES [dbo].[tSubtitle] ([SubtitleId])
GO
ALTER TABLE [dbo].[tDVDxSubtitle] CHECK CONSTRAINT [FK_Subtitle]
GO
ALTER TABLE [dbo].[tDVDxSubtitle]  WITH CHECK ADD  CONSTRAINT [FK_SubtitleList] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxSubtitle] CHECK CONSTRAINT [FK_SubtitleList]
GO
ALTER TABLE [dbo].[tDVDxTag]  WITH CHECK ADD  CONSTRAINT [FK_Tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[tTag] ([TagId])
GO
ALTER TABLE [dbo].[tDVDxTag] CHECK CONSTRAINT [FK_Tag]
GO
ALTER TABLE [dbo].[tDVDxTag]  WITH CHECK ADD  CONSTRAINT [FK_TagList] FOREIGN KEY([DVDid])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tDVDxTag] CHECK CONSTRAINT [FK_TagList]
GO
ALTER TABLE [dbo].[tEnhancedFeatures]  WITH CHECK ADD  CONSTRAINT [FK_EnhancedFeatures] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tEnhancedFeatures] CHECK CONSTRAINT [FK_EnhancedFeatures]
GO
ALTER TABLE [dbo].[tEnhancedNotes]  WITH CHECK ADD  CONSTRAINT [FK_EnhancedNotes] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tEnhancedNotes] CHECK CONSTRAINT [FK_EnhancedNotes]
GO
ALTER TABLE [dbo].[tEnhancedPurchaseInfo]  WITH CHECK ADD  CONSTRAINT [FK_EnhancedPurchaseInfo] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tEnhancedPurchaseInfo] CHECK CONSTRAINT [FK_EnhancedPurchaseInfo]
GO
ALTER TABLE [dbo].[tEnhancedTitles]  WITH CHECK ADD  CONSTRAINT [FK_EnhancedTitles] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tEnhancedTitles] CHECK CONSTRAINT [FK_EnhancedTitles]
GO
ALTER TABLE [dbo].[tExclusions]  WITH CHECK ADD  CONSTRAINT [FK_tExclusions] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tExclusions] CHECK CONSTRAINT [FK_tExclusions]
GO
ALTER TABLE [dbo].[tFeatures]  WITH CHECK ADD  CONSTRAINT [FK_Features] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tFeatures] CHECK CONSTRAINT [FK_Features]
GO
ALTER TABLE [dbo].[tFormat]  WITH CHECK ADD  CONSTRAINT [FK_Format] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tFormat] CHECK CONSTRAINT [FK_Format]
GO
ALTER TABLE [dbo].[tFormat]  WITH CHECK ADD  CONSTRAINT [FK_VideoStandard] FOREIGN KEY([VideoStandardId])
REFERENCES [dbo].[tVideoStandard] ([VideoStandardId])
GO
ALTER TABLE [dbo].[tFormat] CHECK CONSTRAINT [FK_VideoStandard]
GO
ALTER TABLE [dbo].[tLoanInfo]  WITH CHECK ADD  CONSTRAINT [FK_LoanInfo] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tLoanInfo] CHECK CONSTRAINT [FK_LoanInfo]
GO
ALTER TABLE [dbo].[tLoanInfo]  WITH CHECK ADD  CONSTRAINT [FK_LoanInfoUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tUser] ([UserId])
GO
ALTER TABLE [dbo].[tLoanInfo] CHECK CONSTRAINT [FK_LoanInfoUser]
GO
ALTER TABLE [dbo].[tLock]  WITH CHECK ADD  CONSTRAINT [FK_Lock] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tLock] CHECK CONSTRAINT [FK_Lock]
GO
ALTER TABLE [dbo].[tParentDVDxChildDVD]  WITH CHECK ADD  CONSTRAINT [FK_ChildDVDId] FOREIGN KEY([ChildDVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tParentDVDxChildDVD] CHECK CONSTRAINT [FK_ChildDVDId]
GO
ALTER TABLE [dbo].[tParentDVDxChildDVD]  WITH CHECK ADD  CONSTRAINT [FK_ParentDVDId] FOREIGN KEY([ParentDVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tParentDVDxChildDVD] CHECK CONSTRAINT [FK_ParentDVDId]
GO
ALTER TABLE [dbo].[tPurchase]  WITH CHECK ADD  CONSTRAINT [FK_GiftUser] FOREIGN KEY([GiftFromUserId])
REFERENCES [dbo].[tUser] ([UserId])
GO
ALTER TABLE [dbo].[tPurchase] CHECK CONSTRAINT [FK_GiftUser]
GO
ALTER TABLE [dbo].[tPurchase]  WITH CHECK ADD  CONSTRAINT [FK_Purchase] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tPurchase] CHECK CONSTRAINT [FK_Purchase]
GO
ALTER TABLE [dbo].[tPurchase]  WITH CHECK ADD  CONSTRAINT [FK_PurchasePlace] FOREIGN KEY([PurchasePlaceId])
REFERENCES [dbo].[tPurchasePlace] ([PurchasePlaceId])
GO
ALTER TABLE [dbo].[tPurchase] CHECK CONSTRAINT [FK_PurchasePlace]
GO
ALTER TABLE [dbo].[tReview]  WITH CHECK ADD  CONSTRAINT [FK_Review] FOREIGN KEY([DVDId])
REFERENCES [dbo].[tDVD] ([DVDId])
GO
ALTER TABLE [dbo].[tReview] CHECK CONSTRAINT [FK_Review]
GO
ALTER TABLE [dbo].[tStudioAndMediaCompany]  WITH CHECK ADD  CONSTRAINT [FK_Studio] FOREIGN KEY([StudioAndMediaCompanyId])
REFERENCES [dbo].[tDVDxStudio] ([DVDxStudioId])
GO
ALTER TABLE [dbo].[tStudioAndMediaCompany] CHECK CONSTRAINT [FK_Studio]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[42] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1950
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCastGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCastGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[41] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3675
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCollectionTypeGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCollectionTypeGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCountryOfOriginGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCountryOfOriginGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[40] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 14
               Left = 84
               Bottom = 144
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 188
               Left = 333
               Bottom = 301
               Right = 556
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDigitalDownloadInfo"
            Begin Extent = 
               Top = 16
               Left = 352
               Bottom = 129
               Right = 522
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDigitalDownloadInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDigitalDownloadInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[14] 2[44] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 56
               Left = 68
               Bottom = 535
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 276
               Left = 363
               Bottom = 389
               Right = 586
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDId"
            Begin Extent = 
               Top = 55
               Left = 388
               Bottom = 260
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tLocality"
            Begin Extent = 
               Top = 129
               Left = 668
               Bottom = 245
               Right = 866
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCaseType"
            Begin Extent = 
               Top = 419
               Left = 354
               Bottom = 515
               Right = 524
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3315
         Alias = 2460
         Table = 3555
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[33] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 24
               Left = 21
               Bottom = 498
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 297
               Left = 315
               Bottom = 410
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDId"
            Begin Extent = 
               Top = 26
               Left = 349
               Bottom = 226
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tLocality"
            Begin Extent = 
               Top = 27
               Left = 651
               Bottom = 123
               Right = 821
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDIdType"
            Begin Extent = 
               Top = 211
               Left = 714
               Bottom = 307
               Right = 884
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 3390
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[21] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 23
               Left = 17
               Bottom = 308
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 405
               Left = 242
               Bottom = 518
               Right = 465
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxAudio"
            Begin Extent = 
               Top = 70
               Left = 279
               Bottom = 348
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAudioFormat"
            Begin Extent = 
               Top = 146
               Left = 692
               Bottom = 242
               Right = 862
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAudioContent"
            Begin Extent = 
               Top = 24
               Left = 691
               Bottom = 120
               Right = 861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAudioChannels"
            Begin Extent = 
               Top = 256
               Left = 688
               Bottom = 352
               Right = 858
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         C' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxAudio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'olumn = 1440
         Alias = 5295
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxAudio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxAudio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[26] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 41
               Left = 29
               Bottom = 171
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 206
               Left = 329
               Bottom = 319
               Right = 552
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxCast"
            Begin Extent = 
               Top = 42
               Left = 349
               Bottom = 172
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCastAndCrew"
            Begin Extent = 
               Top = 49
               Left = 670
               Bottom = 179
               Right = 840
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCast'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCast'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[35] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 192
               Left = 345
               Bottom = 305
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 25
               Left = 44
               Bottom = 288
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCountryOfOrigin"
            Begin Extent = 
               Top = 66
               Left = 672
               Bottom = 162
               Right = 860
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxCountryOfOrigin"
            Begin Extent = 
               Top = 38
               Left = 354
               Bottom = 151
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCountryOfOrigin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCountryOfOrigin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[33] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 19
               Left = 37
               Bottom = 318
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 283
               Left = 283
               Bottom = 396
               Right = 506
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxCrew"
            Begin Extent = 
               Top = 20
               Left = 325
               Bottom = 236
               Right = 495
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCastAndCrew"
            Begin Extent = 
               Top = 13
               Left = 656
               Bottom = 143
               Right = 826
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCreditSubtype"
            Begin Extent = 
               Top = 171
               Left = 622
               Bottom = 284
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCreditType"
            Begin Extent = 
               Top = 204
               Left = 865
               Bottom = 300
               Right = 1035
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Col' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCrew'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'umn = 3195
         Alias = 2985
         Table = 2820
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCrew'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxCrew'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 208
               Left = 317
               Bottom = 321
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 26
               Left = 50
               Bottom = 156
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxDisc"
            Begin Extent = 
               Top = 20
               Left = 379
               Bottom = 150
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1575
         Alias = 1395
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxDisc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxDisc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[6] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 354
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 226
               Left = 296
               Bottom = 339
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxEvent"
            Begin Extent = 
               Top = 8
               Left = 347
               Bottom = 188
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tEventType"
            Begin Extent = 
               Top = 6
               Left = 732
               Bottom = 102
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tUser"
            Begin Extent = 
               Top = 151
               Left = 723
               Bottom = 281
               Right = 893
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         O' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'r = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 318
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 178
               Left = 290
               Bottom = 291
               Right = 513
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxGenre"
            Begin Extent = 
               Top = 22
               Left = 343
               Bottom = 135
               Right = 513
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tGenre"
            Begin Extent = 
               Top = 32
               Left = 616
               Bottom = 128
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxGenre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxGenre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 315
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 149
               Left = 286
               Bottom = 262
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxMediaCompany"
            Begin Extent = 
               Top = 11
               Left = 329
               Bottom = 124
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tStudioAndMediaCompany"
            Begin Extent = 
               Top = 9
               Left = 669
               Bottom = 105
               Right = 909
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxMediaCompany'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxMediaCompany'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 317
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 186
               Left = 285
               Bottom = 299
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxPluginData"
            Begin Extent = 
               Top = 20
               Left = 305
               Bottom = 150
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPluginData"
            Begin Extent = 
               Top = 33
               Left = 606
               Bottom = 146
               Right = 776
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxPluginData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxPluginData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 241
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 156
               Left = 284
               Bottom = 269
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxRegion"
            Begin Extent = 
               Top = 10
               Left = 307
               Bottom = 123
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 300
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 184
               Left = 284
               Bottom = 297
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxStudio"
            Begin Extent = 
               Top = 23
               Left = 310
               Bottom = 136
               Right = 480
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tStudioAndMediaCompany"
            Begin Extent = 
               Top = 24
               Left = 563
               Bottom = 120
               Right = 803
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxStudio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxStudio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 264
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 171
               Left = 280
               Bottom = 284
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDVDxTag"
            Begin Extent = 
               Top = 23
               Left = 320
               Bottom = 136
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tTag"
            Begin Extent = 
               Top = 14
               Left = 581
               Bottom = 127
               Right = 751
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxTag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDVDxTag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 197
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 185
               Left = 282
               Bottom = 298
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tEnhancedFeatures"
            Begin Extent = 
               Top = 23
               Left = 319
               Bottom = 153
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedFeatures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedFeatures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 240
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 192
               Left = 276
               Bottom = 305
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tEnhancedNotes"
            Begin Extent = 
               Top = 8
               Left = 426
               Bottom = 138
               Right = 596
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 316
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 183
               Left = 269
               Bottom = 296
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tEnhancedPurchaseInfo"
            Begin Extent = 
               Top = 5
               Left = 462
               Bottom = 135
               Right = 722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedPurchaseInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedPurchaseInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 238
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 164
               Left = 297
               Bottom = 277
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tEnhancedTitles"
            Begin Extent = 
               Top = 5
               Left = 326
               Bottom = 135
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedTitles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vEnhancedTitles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 275
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 156
               Left = 262
               Bottom = 269
               Right = 485
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tFeatures"
            Begin Extent = 
               Top = 12
               Left = 304
               Bottom = 142
               Right = 521
            End
            DisplayFlags = 280
            TopColumn = 22
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vFeatures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vFeatures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 203
               Left = 256
               Bottom = 316
               Right = 479
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tFormat"
            Begin Extent = 
               Top = 26
               Left = 283
               Bottom = 156
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tVideoStandard"
            Begin Extent = 
               Top = 35
               Left = 554
               Bottom = 131
               Right = 730
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vFormat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vFormat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[3] 2[46] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vGenreGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vGenreGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 202
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 153
               Left = 263
               Bottom = 267
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tLoanInfo"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 136
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tUser"
            Begin Extent = 
               Top = 6
               Left = 471
               Bottom = 136
               Right = 641
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vLoanInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vLoanInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 188
               Left = 275
               Bottom = 301
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tLock"
            Begin Extent = 
               Top = 24
               Left = 314
               Bottom = 154
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 19
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2505
         Alias = 1710
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vLock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vLock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vMediaCompanyGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vMediaCompanyGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[8] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tParentDVDxChildDVD"
            Begin Extent = 
               Top = 141
               Left = 525
               Bottom = 254
               Right = 695
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tParentDVD"
            Begin Extent = 
               Top = 120
               Left = 286
               Bottom = 250
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tParentCollectionType"
            Begin Extent = 
               Top = 93
               Left = 0
               Bottom = 206
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tChildDVD"
            Begin Extent = 
               Top = 172
               Left = 745
               Bottom = 302
               Right = 932
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tChildCollectionType"
            Begin Extent = 
               Top = 163
               Left = 1007
               Bottom = 276
               Right = 1230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 3930
         Table = 3675
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vParentChildDVD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vParentChildDVD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vParentChildDVD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[22] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 234
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 268
               Left = 304
               Bottom = 381
               Right = 527
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPurchase"
            Begin Extent = 
               Top = 10
               Left = 311
               Bottom = 235
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPurchasePlace"
            Begin Extent = 
               Top = 10
               Left = 609
               Bottom = 140
               Right = 784
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tUser"
            Begin Extent = 
               Top = 168
               Left = 605
               Bottom = 298
               Right = 775
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4380
         Alias = 2115
         Table = 4665
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vPurchase"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 236
               Right = 361
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchaseByMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchaseByMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vPurchase"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchaseByYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPurchaseByYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDVD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCollectionType"
            Begin Extent = 
               Top = 166
               Left = 265
               Bottom = 279
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tReview"
            Begin Extent = 
               Top = 13
               Left = 264
               Bottom = 143
               Right = 434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vReview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vReview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 3315
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vStudioGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vStudioGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "itab"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTagGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTagGrouped'
GO
USE [master]
GO
ALTER DATABASE [Collection] SET  READ_WRITE 
GO
