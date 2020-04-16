USE [master]
GO
/****** Object:  Database [LaymanWoods]    Script Date: 13-Apr-20 11:28:02 AM ******/
CREATE DATABASE [LaymanWoods]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LaymanWoods', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\LaymanWoods.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LaymanWoods_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\LaymanWoods_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LaymanWoods] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LaymanWoods].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LaymanWoods] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LaymanWoods] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LaymanWoods] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LaymanWoods] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LaymanWoods] SET ARITHABORT OFF 
GO
ALTER DATABASE [LaymanWoods] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LaymanWoods] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LaymanWoods] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LaymanWoods] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LaymanWoods] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LaymanWoods] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LaymanWoods] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LaymanWoods] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LaymanWoods] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LaymanWoods] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LaymanWoods] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LaymanWoods] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LaymanWoods] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LaymanWoods] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LaymanWoods] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LaymanWoods] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LaymanWoods] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LaymanWoods] SET RECOVERY FULL 
GO
ALTER DATABASE [LaymanWoods] SET  MULTI_USER 
GO
ALTER DATABASE [LaymanWoods] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LaymanWoods] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LaymanWoods] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LaymanWoods] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LaymanWoods] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LaymanWoods', N'ON'
GO
ALTER DATABASE [LaymanWoods] SET QUERY_STORE = OFF
GO
USE [LaymanWoods]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [LaymanWoods]
GO
/****** Object:  User [WebDatabaseUser]    Script Date: 13-Apr-20 11:28:02 AM ******/
CREATE USER [WebDatabaseUser] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [WebDatabaseUser]
GO
/****** Object:  UserDefinedFunction [dbo].[DecryptStr]    Script Date: 13-Apr-20 11:28:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[DecryptStr](@EncyptedString VARCHAR(400))
Returns VARCHAR(200)
AS
BEGIN
/*Declare Initial Variable(s) and table(s)*/
DECLARE @DecyptedString VARCHAR(200)
DECLARE @EncDecTbl TABLE
(
   ID INT IDENTITY,
   CharacterValue VARCHAR(5),
   EncryptedValue VARCHAR(5)
)
IF(@EncyptedString IS NOT NULL AND @EncyptedString<>'')
BEGIN

   DECLARE @Counter INT
   DECLARE @Characterlength INT

   --:: Set length for character set as per dictionary
   SET @Characterlength=2 
   
   --:: reverse string
   SET @EncyptedString=REVERSE(@EncyptedString)
   SET @Counter=1

   --:: Insert set of characters list into table variable after spliting the string
   WHILE(@Counter<=LEN(@EncyptedString))
   BEGIN
      INSERT INTO @EncDecTbl (EncryptedValue) 
      VALUES (SUBSTRING(@EncyptedString,@Counter,@Characterlength))   
      SET @Counter=@Counter+@Characterlength   
   end

   --:: Update plain character with respect to encrypted set of characters in table variable
   UPDATE A 
     SET A.CharacterValue=B.CharacterValue
     FROM @EncDecTbl A
     Inner Join dbo.DictionaryEncryptDecrypt B with (nolock)
     ON A.EncryptedValue COLLATE Latin1_General_CS_AS =B.EncryptedValue COLLATE Latin1_General_CS_AS
    
    --:: Merge rows into a string
    SELECT @DecyptedString=
        (
         SELECT CharacterValue
          FROM @EncDecTbl
           FOR XML PATH(''),type
       )
       .value('.','VARCHAR(200)') 
END
  Return @DecyptedString
End


GO
/****** Object:  UserDefinedFunction [dbo].[EncryptStr]    Script Date: 13-Apr-20 11:28:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[EncryptStr](@DecryptedString VARCHAR(200))
Returns VARCHAR(400)
As
BEGIN
DECLARE @EncryptedString VARCHAR(400) 

--:: To Handle blank value
IF(@DecryptedString='')
Begin

	Select @EncryptedString=EncryptedValue
		FROM dbo.DictionaryEncryptDecrypt B WITH (NOLOCK)
	Where CharacterValue = ''

End

Else IF(@DecryptedString IS NOT NULL)
BEGIN

   /*Declare Initial Variable(s) and table(s)*/
   DECLARE @counter INT
   SET @counter=1
   
   DECLARE @EncDecTbl TABLE
   (
      ID INT IDENTITY,
      CharacterValue VARCHAR(5),
      EncryptedValue VARCHAR(5)
    )


   WHILE(@counter<=len(@DecryptedString))
   BEGIN
      --:: Insert characters list into table variable after spliting the string
      INSERT INTO @EncDecTbl (CharacterValue) VALUES (SUBSTRING(@DecryptedString,@counter,1))  
      SET @counter=@counter+1   
   END

   --:: Update encrypted set of characters  with respect to  plain character in table variable
   UPDATE A 
      SET A.EncryptedValue=B.EncryptedValue
   FROM @EncDecTbl A
   Inner Join dbo.DictionaryEncryptDecrypt B WITH (NOLOCK)
   ON A.CharacterValue COLLATE Latin1_General_CS_AS =B.CharacterValue   COLLATE Latin1_General_CS_AS      
   
   --:: Merge rows into a string
   SELECT @EncryptedString=
        (
         SELECT EncryptedValue
          FROM @EncDecTbl
           FOR XML PATH(''),type
       )
       .value('.','VARCHAR(400)')
       

END
   --:: reverse string
   Return REVERSE(@EncryptedString)
END



GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 13-Apr-20 11:28:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 13-Apr-20 11:28:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoryMaster](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](32) NOT NULL,
	[CategoryCode] [varchar](50) NOT NULL,
	[CompanyID] [int] NULL,
	[WebPartType] [int] NOT NULL,
	[isMultiSelect] [bit] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommonSetup]    Script Date: 13-Apr-20 11:28:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CommonSetup](
	[CommonSetupID] [int] IDENTITY(1,1) NOT NULL,
	[MainType] [varchar](200) NULL,
	[SubType] [varchar](200) NULL,
	[DisplayText] [varchar](200) NULL,
	[DisplayValue] [tinyint] NULL,
	[ParentID] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CompanyID] [int] NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[CommonSetup] ADD [Description] [varchar](200) NULL
 CONSTRAINT [PK_CommonSetup] PRIMARY KEY CLUSTERED 
(
	[CommonSetupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DictionaryEncryptDecrypt]    Script Date: 13-Apr-20 11:28:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DictionaryEncryptDecrypt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CharacterValue] [varchar](5) NOT NULL,
	[EncryptedValue] [varchar](5) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Emails]    Script Date: 13-Apr-20 11:28:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Emails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[UserID] [int] NULL,
	[TemplateID] [int] NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](50) NULL,
	[Mobile] [varchar](20) NULL,
	[EmailAddress] [varchar](150) NULL,
	[Message] [varchar](1500) NULL,
	[Status] [int] NOT NULL,
	[ProductID] [int] NULL,
	[Address] [varchar](300) NULL,
	[Pincode] [varchar](30) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Emails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailTemplate]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailTemplate](
	[TemplateID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Body] [varchar](max) NULL,
	[Subject] [varchar](500) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InteriorAndCategoryMapping]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InteriorAndCategoryMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InteriorID] [int] NOT NULL,
	[CategoryCode] [varchar](50) NOT NULL,
	[ProductID] [int] NULL,
	[Multiplier] [decimal](18, 2) NOT NULL,
	[Divisor] [decimal](18, 2) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[WebPartType] [int] NOT NULL,
	[isMultiSelect] [bit] NOT NULL,
	[isDefault] [int] NOT NULL,
 CONSTRAINT [PK_Interior_CategoryMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InteriorCategory]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InteriorCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Image] [varchar](1500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CompanyID] [int] NOT NULL,
 CONSTRAINT [PK_InteriorCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InteriorProducts]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[InteriorProducts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Image] [varchar](1500) NULL,
	[InteriorCategoryID] [int] NULL,
	[Type] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CompanyID] [int] NOT NULL,
 CONSTRAINT [PK_InteriorProducts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OTPMaster]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OTPMaster](
	[OTPMasterID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[GUID] [varchar](500) NULL,
	[OTP] [varchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Attempts] [int] NULL,
 CONSTRAINT [PK_OTPMaster] PRIMARY KEY CLUSTERED 
(
	[OTPMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductHelp]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProductHelp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Title] [varchar](150) NOT NULL,
	[ImageUrl] [varchar](1000) NULL,
	[Description] [varchar](max) NOT NULL,
	[AdditionalInfo] [varchar](1000) NULL,
	[Specification] [varchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[CategoryID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[ProductHelp] ADD [CategoryCode] [varchar](50) NULL
 CONSTRAINT [PK_ProductHelp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 13-Apr-20 11:28:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProductMaster](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Title] [varchar](150) NOT NULL,
	[ImageUrl] [varchar](1000) NOT NULL,
	[CategoryCode] [varchar](10) NOT NULL,
	[BasicModelCode] [varchar](50) NULL,
	[BasicModelName] [varchar](100) NULL,
	[Color] [int] NOT NULL,
	[SKUCode] [varchar](50) NULL,
	[SKUName] [varchar](50) NULL,
	[MRP] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[MeasurementUnit] [int] NULL,
	[IsDefault] [bit] NULL,
	[Multiplier] [decimal](18, 2) NULL,
	[Divisor] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ProductMaster] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 13-Apr-20 11:28:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[UserCode] [varchar](50) NULL,
	[EmplCode] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](100) NOT NULL,
	[MySingleID] [varchar](50) NULL,
	[Mobile_Calling] [varchar](50) NULL,
	[Mobile_SD] [varchar](50) NULL,
	[EmailID] [varchar](150) NULL,
	[IsSSOLogin] [bit] NOT NULL,
	[UserCommunicationGroup] [varchar](50) NULL,
	[ProductTypeID] [int] NULL,
	[EnrollmentDate] [datetime] NULL,
	[AccountStatus] [int] NOT NULL,
	[IsOfflineProfile] [bit] NOT NULL,
	[ProfilePictureFileName] [varchar](120) NULL,
	[Address] [varchar](300) NULL,
	[Pincode] [varchar](30) NULL,
	[AlternateEmailID] [varchar](150) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[IsPinRegistered] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[AndroidRegistrationId] [varchar](1000) NULL,
	[DistrictCode] [varchar](100) NULL,
	[DistrictName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CategoryMaster] ADD  DEFAULT ((0)) FOR [WebPartType]
GO
ALTER TABLE [dbo].[CategoryMaster] ADD  DEFAULT ((0)) FOR [isMultiSelect]
GO
ALTER TABLE [dbo].[Emails] ADD  CONSTRAINT [UserMaster_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[EmailTemplate] ADD  CONSTRAINT [DF_EmailTemplate_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((1)) FOR [Multiplier]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((1)) FOR [Divisor]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((0)) FOR [WebPartType]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((0)) FOR [isMultiSelect]
GO
ALTER TABLE [dbo].[InteriorAndCategoryMapping] ADD  DEFAULT ((0)) FOR [isDefault]
GO
ALTER TABLE [dbo].[InteriorCategory] ADD  DEFAULT ((1)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[InteriorCategory] ADD  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[InteriorProducts] ADD  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [dbo].[InteriorProducts] ADD  DEFAULT ((1)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[InteriorProducts] ADD  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_Company]  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  CONSTRAINT [DF_ProductMaster_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  CONSTRAINT [DF_ProductMaster_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  CONSTRAINT [DF_ProductMaster_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  CONSTRAINT [DF_ProductMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  CONSTRAINT [DF_ProductMaster_Company]  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  CONSTRAINT [DF_ProductMaster_MeasurementUnit]  DEFAULT ((1)) FOR [MeasurementUnit]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [Multiplier]
GO
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [Divisor]
GO
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [DF_UserMaster_Password]  DEFAULT ('_#^~!875(~$8') FOR [Password]
GO
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [DF_UserMaster_IsOfflineProfile]  DEFAULT ((0)) FOR [IsOfflineProfile]
GO
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [DF_UserMaster_IsPinRegistered]  DEFAULT ((0)) FOR [IsPinRegistered]
GO
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [DF_UserMaster_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [UserMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[InteriorProducts]  WITH CHECK ADD  CONSTRAINT [FK_InteriorProducts_InteriorCategory] FOREIGN KEY([InteriorCategoryID])
REFERENCES [dbo].[InteriorCategory] ([ID])
GO
ALTER TABLE [dbo].[InteriorProducts] CHECK CONSTRAINT [FK_InteriorProducts_InteriorCategory]
GO
ALTER TABLE [dbo].[ProductHelp]  WITH CHECK ADD  CONSTRAINT [FK_ProductHelp_CategoryMaster] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductHelp] CHECK CONSTRAINT [FK_ProductHelp_CategoryMaster]
GO
ALTER TABLE [dbo].[ProductHelp]  WITH CHECK ADD  CONSTRAINT [FK_ProductHelp_ProductMaster] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductMaster] ([ProductID])
GO
ALTER TABLE [dbo].[ProductHelp] CHECK CONSTRAINT [FK_ProductHelp_ProductMaster]
GO
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_ProductMaster_CategoryMaster] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [FK_ProductMaster_CategoryMaster]
GO
USE [master]
GO
ALTER DATABASE [LaymanWoods] SET  READ_WRITE 
GO
