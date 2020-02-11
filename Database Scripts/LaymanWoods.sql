USE [master]
GO
/****** Object:  Database [LaymanWoods]    Script Date: 2/11/2020 6:58:28 PM ******/
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
/****** Object:  User [WebDatabaseUser]    Script Date: 2/11/2020 6:58:39 PM ******/
CREATE USER [WebDatabaseUser] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [WebDatabaseUser]
GO
/****** Object:  UserDefinedFunction [dbo].[DecryptStr]    Script Date: 2/11/2020 6:58:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[EncryptStr]    Script Date: 2/11/2020 6:58:46 PM ******/
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
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 2/11/2020 6:59:14 PM ******/
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
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommonSetup]    Script Date: 2/11/2020 6:59:16 PM ******/
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
/****** Object:  Table [dbo].[DictionaryEncryptDecrypt]    Script Date: 2/11/2020 6:59:17 PM ******/
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
/****** Object:  Table [dbo].[Emails]    Script Date: 2/11/2020 6:59:17 PM ******/
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
/****** Object:  Table [dbo].[EmailTemplate]    Script Date: 2/11/2020 6:59:18 PM ******/
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
/****** Object:  Table [dbo].[OTPMaster]    Script Date: 2/11/2020 6:59:18 PM ******/
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
/****** Object:  Table [dbo].[ProductHelp]    Script Date: 2/11/2020 6:59:18 PM ******/
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
	[CategoryID] [int] NULL,
 CONSTRAINT [PK_ProductHelp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 2/11/2020 6:59:19 PM ******/
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
 CONSTRAINT [PK_ProductMaster] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 2/11/2020 6:59:19 PM ******/
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
SET IDENTITY_INSERT [dbo].[CategoryMaster] ON 

INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (1, N'Accessories', N'100', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (2, N'Ply and Board', N'101', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (3, N'Inner Laminates', N'102', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (4, N'Outer Finish', N'103', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (5, N'Hinges', N'104', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (6, N'Channels', N'105', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (7, N'Baskets', N'106', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (8, N'Handles', N'107', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (9, N'Labour Work', N'200', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (10, N'Others', N'300', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (11, N'Paint', N'400', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (12, N'Tiles', N'500', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (13, N'Plaster Of Paris (POP)', N'600', 1)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryName], [CategoryCode], [CompanyID]) VALUES (14, N'Stone (Granite and Marble)', N'700', 1)
SET IDENTITY_INSERT [dbo].[CategoryMaster] OFF
SET IDENTITY_INSERT [dbo].[CommonSetup] ON 

INSERT [dbo].[CommonSetup] ([CommonSetupID], [MainType], [SubType], [DisplayText], [DisplayValue], [ParentID], [IsDeleted], [CreatedDate], [ModifiedDate], [CompanyID], [Description]) VALUES (1, N'Measurement Unit', NULL, N'Number', 1, 1, 0, CAST(N'2020-10-01T00:00:00.000' AS DateTime), NULL, 1, N'Measurement Units')
INSERT [dbo].[CommonSetup] ([CommonSetupID], [MainType], [SubType], [DisplayText], [DisplayValue], [ParentID], [IsDeleted], [CreatedDate], [ModifiedDate], [CompanyID], [Description]) VALUES (3, NULL, NULL, N'Feet', 2, 1, 0, CAST(N'2020-10-01T00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[CommonSetup] ([CommonSetupID], [MainType], [SubType], [DisplayText], [DisplayValue], [ParentID], [IsDeleted], [CreatedDate], [ModifiedDate], [CompanyID], [Description]) VALUES (4, NULL, NULL, N'Inches', 3, 1, 0, CAST(N'2020-10-01T00:00:00.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[CommonSetup] ([CommonSetupID], [MainType], [SubType], [DisplayText], [DisplayValue], [ParentID], [IsDeleted], [CreatedDate], [ModifiedDate], [CompanyID], [Description]) VALUES (5, NULL, N'Area', N'Sq. Feet', 4, 1, 0, CAST(N'2020-10-01T00:00:00.000' AS DateTime), NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[CommonSetup] OFF
INSERT [dbo].[EmailTemplate] ([TemplateID], [Name], [Body], [Subject], [IsActive]) VALUES (1, N'Forget Password', N'<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

<head>
  <!-- NAME: 1 COLUMN -->
  <!--[if gte mso 15]>
      <xml>
        <o:OfficeDocumentSettings>
          <o:AllowPNG/>
          <o:PixelsPerInch>96</o:PixelsPerInch>
        </o:OfficeDocumentSettings>
      </xml>
    <![endif]-->
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Reset Your Lingo Password</title>
  <!--[if !mso]>
      <!-- -->
  <link href=''https://fonts.googleapis.com/css?family=Asap:400,400italic,700,700italic'' rel=''stylesheet'' type=''text/css''>
  <!--<![endif]-->
  <style type="text/css">
    @media only screen and (min-width:768px){
          .templateContainer{
              width:600px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          body,table,td,p,a,li,blockquote{
              -webkit-text-size-adjust:none !important;
          }
  
  }   @media only screen and (max-width: 480px){
          body{
              width:100% !important;
              min-width:100% !important;
          }
  
  }   @media only screen and (max-width: 480px){
          #bodyCell{
              padding-top:10px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImage{
              width:100% !important;
          }
  
  }   @media only screen and (max-width: 480px){
         
   .mcnCaptionTopContent,.mcnCaptionBottomContent,.mcnTextContentContainer,.mcnBoxedTextContentContainer,.mcnImageGroupContentContainer,.mcnCaptionLeftTextContentContainer,.mcnCaptionRightTextContentContainer,.mcnCaptionLeftImageContentContainer,.mcnCaptionRightImageContentContainer,.mcnImageCardLeftTextContentContainer,.mcnImageCardRightTextContentContainer{
              max-width:100% !important;
              width:100% !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnBoxedTextContentContainer{
              min-width:100% !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImageGroupContent{
              padding:9px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnCaptionLeftContentOuter
   .mcnTextContent,.mcnCaptionRightContentOuter .mcnTextContent{
              padding-top:9px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImageCardTopImageContent,.mcnCaptionBlockInner
   .mcnCaptionTopContent:last-child .mcnTextContent{
              padding-top:18px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImageCardBottomImageContent{
              padding-bottom:9px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImageGroupBlockInner{
              padding-top:0 !important;
              padding-bottom:0 !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImageGroupBlockOuter{
              padding-top:9px !important;
              padding-bottom:9px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnTextContent,.mcnBoxedTextContentColumn{
              padding-right:18px !important;
              padding-left:18px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcnImageCardLeftImageContent,.mcnImageCardRightImageContent{
              padding-right:18px !important;
              padding-bottom:0 !important;
              padding-left:18px !important;
          }
  
  }   @media only screen and (max-width: 480px){
          .mcpreview-image-uploader{
              display:none !important;
              width:100% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Heading 1
      @tip Make the first-level headings larger in size for better readability
   on small screens.
      */
          h1{
              /*@editable*/font-size:20px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Heading 2
      @tip Make the second-level headings larger in size for better
   readability on small screens.
      */
          h2{
              /*@editable*/font-size:20px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Heading 3
      @tip Make the third-level headings larger in size for better readability
   on small screens.
      */
          h3{
              /*@editable*/font-size:18px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Heading 4
      @tip Make the fourth-level headings larger in size for better
   readability on small screens.
      */
          h4{
              /*@editable*/font-size:16px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Boxed Text
      @tip Make the boxed text larger in size for better readability on small
   screens. We recommend a font size of at least 16px.
      */
          .mcnBoxedTextContentContainer
   .mcnTextContent,.mcnBoxedTextContentContainer .mcnTextContent p{
              /*@editable*/font-size:16px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Preheader Visibility
      @tip Set the visibility of the email''s preheader on small screens. You
   can hide it to save space.
      */
          #templatePreheader{
              /*@editable*/display:block !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Preheader Text
      @tip Make the preheader text larger in size for better readability on
   small screens.
      */
          #templatePreheader .mcnTextContent,#templatePreheader
   .mcnTextContent p{
              /*@editable*/font-size:12px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Header Text
      @tip Make the header text larger in size for better readability on small
   screens.
      */
          #templateHeader .mcnTextContent,#templateHeader .mcnTextContent p{
              /*@editable*/font-size:16px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Body Text
      @tip Make the body text larger in size for better readability on small
   screens. We recommend a font size of at least 16px.
      */
          #templateBody .mcnTextContent,#templateBody .mcnTextContent p{
              /*@editable*/font-size:16px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }   @media only screen and (max-width: 480px){
      /*
      @tab Mobile Styles
      @section Footer Text
      @tip Make the footer content text larger in size for better readability
   on small screens.
      */
          #templateFooter .mcnTextContent,#templateFooter .mcnTextContent p{
              /*@editable*/font-size:12px !important;
              /*@editable*/line-height:150% !important;
          }
  
  }
  </style>
</head>

<body style="-ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 background-color: #fed149; height: 100%; margin: 0; padding: 0; width: 100%">
  <center>
    <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" id="bodyTable" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; background-color: #fed149; height: 100%; margin: 0; padding: 0; width:
 100%" width="100%">
      <tr>
        <td align="center" id="bodyCell" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; border-top: 0;
 height: 100%; margin: 0; padding: 0; width: 100%" valign="top">
          <!-- BEGIN TEMPLATE // -->
          <!--[if gte mso 9]>
              <table align="center" border="0" cellspacing="0" cellpadding="0" width="600" style="width:600px;">
                <tr>
                  <td align="center" valign="top" width="600" style="width:600px;">
                  <![endif]-->
          <table border="0" cellpadding="0" cellspacing="0" class="templateContainer" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; max-width:
 600px; border: 0" width="100%">
            <tr>
              <td id="templatePreheader" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #fed149;
 border-top: 0; border-bottom: 0; padding-top: 16px; padding-bottom: 8px" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" class="mcnTextBlock" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 min-width:100%;" width="100%">
                  <tbody class="mcnTextBlockOuter">
                    <tr>
                      <td class="mcnTextBlockInner" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%" valign="top">
                        <table align="left" border="0" cellpadding="0" cellspacing="0" class="mcnTextContentContainer" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; min-width:100%;" width="100%">
                          <tbody>
                            <tr>
                              <td class="mcnTextContent" style=''mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; word-break: break-word;
 color: #2a2a2a; font-family: "Asap", Helvetica, sans-serif; font-size: 12px;
 line-height: 150%; text-align: left; padding-top:9px; padding-right: 18px;
 padding-bottom: 9px; padding-left: 18px;'' valign="top">
                                <a href="https://www.lingoapp.com" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color: #2a2a2a;
 font-weight: normal; text-decoration: none" target="_blank" title="Lingo is the
 best way to organize, share and use all your visual assets in one place -
 all on your desktop.">
                                  <img align="none" alt="Lingo is the best way to
 organize, share and use all your visual assets in one place - all on your desktop." height="32" src="https://static.lingoapp.com/assets/images/email/lingo-logo.png" style="-ms-interpolation-mode: bicubic; border: 0; outline: none;
 text-decoration: none; height: auto; width: 107px; height: 32px; margin: 0px;" width="107" />
                                </a>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
            <tr>
              <td id="templateHeader" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #f7f7ff;
 border-top: 0; border-bottom: 0; padding-top: 16px; padding-bottom: 0" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" class="mcnImageBlock" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 min-width:100%;" width="100%">
                  <tbody class="mcnImageBlockOuter">
                    <tr>
                      <td class="mcnImageBlockInner" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding:0px" valign="top">
                        <table align="left" border="0" cellpadding="0" cellspacing="0" class="mcnImageContentContainer" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; min-width:100%;" width="100%">
                          <tbody>
                            <tr>
                              <td class="mcnImageContent" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-right: 0px;
 padding-left: 0px; padding-top: 0; padding-bottom: 0; text-align:center;" valign="top">
                                <a class="" href="https://www.lingoapp.com" style="mso-line-height-rule:
 exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color:
 #f57153; font-weight: normal; text-decoration: none" target="_blank" title="">
                                  <a class="" href="https://www.lingoapp.com/" style="mso-line-height-rule:
 exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color:
 #f57153; font-weight: normal; text-decoration: none" target="_blank" title="">
                                    <img align="center" alt="Forgot your password?" class="mcnImage" src="https://static.lingoapp.com/assets/images/email/il-password-reset@2x.png" style="-ms-interpolation-mode: bicubic; border: 0; height: auto; outline: none;
 text-decoration: none; vertical-align: bottom; max-width:1200px; padding-bottom:
 0; display: inline !important; vertical-align: bottom;" width="600"></img>
                                  </a>
                                </a>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
            <tr>
              <td id="templateBody" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #f7f7ff;
 border-top: 0; border-bottom: 0; padding-top: 0; padding-bottom: 0" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" class="mcnTextBlock" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; min-width:100%;" width="100%">
                  <tbody class="mcnTextBlockOuter">
                    <tr>
                      <td class="mcnTextBlockInner" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%" valign="top">
                        <table align="left" border="0" cellpadding="0" cellspacing="0" class="mcnTextContentContainer" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; min-width:100%;" width="100%">
                          <tbody>
                            <tr>
                              <td class="mcnTextContent" style=''mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; word-break: break-word;
 color: #2a2a2a; font-family: "Asap", Helvetica, sans-serif; font-size: 16px;
 line-height: 150%; text-align: center; padding-top:9px; padding-right: 18px;
 padding-bottom: 9px; padding-left: 18px;'' valign="top">

                                <h1 class="null" style=''color: #2a2a2a; font-family: "Asap", Helvetica,
 sans-serif; font-size: 32px; font-style: normal; font-weight: bold; line-height:
 125%; letter-spacing: 2px; text-align: center; display: block; margin: 0;
 padding: 0''><span style="text-transform:uppercase">Forgot</span></h1>


                                <h2 class="null" style=''color: #2a2a2a; font-family: "Asap", Helvetica,
 sans-serif; font-size: 24px; font-style: normal; font-weight: bold; line-height:
 125%; letter-spacing: 1px; text-align: center; display: block; margin: 0;
 padding: 0''><span style="text-transform:uppercase">your password?</span></h2>

                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <table border="0" cellpadding="0" cellspacing="0" class="mcnTextBlock" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace:
 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 min-width:100%;" width="100%">
                  <tbody class="mcnTextBlockOuter">
                    <tr>
                      <td class="mcnTextBlockInner" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%" valign="top">
                        <table align="left" border="0" cellpadding="0" cellspacing="0" class="mcnTextContentContainer" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; min-width:100%;" width="100%">
                          <tbody>
                            <tr>
                              <td class="mcnTextContent" style=''mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; word-break: break-word;
 color: #2a2a2a; font-family: "Asap", Helvetica, sans-serif; font-size: 16px;
 line-height: 150%; text-align: center; padding-top:9px; padding-right: 18px;
 padding-bottom: 9px; padding-left: 18px;'' valign="top">Not to worry, we got you! Let’s get you a new password.
                                <br></br>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <table border="0" cellpadding="0" cellspacing="0" class="mcnButtonBlock" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 min-width:100%;" width="100%">
                  <tbody class="mcnButtonBlockOuter">
                    <tr>
                      <td align="center" class="mcnButtonBlockInner" style="mso-line-height-rule:
 exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 padding-top:18px; padding-right:18px; padding-bottom:18px; padding-left:18px;" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" class="mcnButtonBlock" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; min-width:100%;" width="100%">
                          <tbody class="mcnButtonBlockOuter">
                            <tr>
                              <td align="center" class="mcnButtonBlockInner" style="mso-line-height-rule:
 exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 padding-top:0; padding-right:18px; padding-bottom:18px; padding-left:18px;" valign="top">
                                <table border="0" cellpadding="0" cellspacing="0" class="mcnButtonContentContainer" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 border-collapse: separate !important;border-radius: 48px;background-color:
 #F57153;">
                                  <tbody>
                                    <tr>
                                      <td align="center" class="mcnButtonContent" style="mso-line-height-rule:
 exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;
 font-family: ''Asap'', Helvetica, sans-serif; font-size: 16px; padding-top:24px;
 padding-right:48px; padding-bottom:24px; padding-left:48px;" valign="middle">
                                        <a class="mcnButton " href="#" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; display: block; color: #f57153;
 font-weight: normal; text-decoration: none; font-weight: normal;letter-spacing:
 1px;line-height: 100%;text-align: center;text-decoration: none;color:
 #FFFFFF; text-transform:uppercase;" target="_blank" title="Review Lingo kit
 invitation">Reset password</a>
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <table border="0" cellpadding="0" cellspacing="0" class="mcnImageBlock" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; min-width:100%;" width="100%">
                  <tbody class="mcnImageBlockOuter">
                    <tr>
                      <td class="mcnImageBlockInner" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding:0px" valign="top">
                        <table align="left" border="0" cellpadding="0" cellspacing="0" class="mcnImageContentContainer" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; min-width:100%;" width="100%">
                          <tbody>
                            <tr>
                              <td class="mcnImageContent" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; padding-right: 0px;
 padding-left: 0px; padding-top: 0; padding-bottom: 0; text-align:center;" valign="top"></td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
            <tr>
              <td id="templateFooter" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #fed149;
 border-top: 0; border-bottom: 0; padding-top: 8px; padding-bottom: 80px" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" class="mcnTextBlock" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; min-width:100%;" width="100%">
                  <tbody class="mcnTextBlockOuter">
                    <tr>
                      <td class="mcnTextBlockInner" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%" valign="top">
                        <table align="center" bgcolor="#F7F7FF" border="0" cellpadding="32" cellspacing="0" class="card" style="border-collapse: collapse; mso-table-lspace: 0;
 mso-table-rspace: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust:
 100%; background:#F7F7FF; margin:auto; text-align:left; max-width:600px;
 font-family: ''Asap'', Helvetica, sans-serif;" text-align="left" width="100%">
                          <tr>
                            <td style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%">

                              <h3 style=''color: #2a2a2a; font-family: "Asap", Helvetica, sans-serif;
 font-size: 20px; font-style: normal; font-weight: normal; line-height: 125%;
 letter-spacing: normal; text-align: center; display: block; margin: 0; padding:
 0; text-align: left; width: 100%; font-size: 16px; font-weight: bold; ''>What
 is Lingo?</h3>

                              <p style=''margin: 10px 0; padding: 0; mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color: #2a2a2a;
 font-family: "Asap", Helvetica, sans-serif; font-size: 12px; line-height: 150%;
 text-align: left; text-align: left; font-size: 14px; ''>Lingo is a visual asset manager made for collaboration. Build a central library for your team''s visual assets. Empower creation and ensure consistency from your desktop.
                              </p>
                              <div style="padding-bottom: 18px;">
                                <a href="https://www.lingoapp.com" style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; color: #f57153; font-weight: normal; text-decoration: none;
 font-size: 14px; color:#F57153; text-decoration:none;" target="_blank" title="Learn more about Lingo">Learn More ?</a>
                              </div>
                            </td>
                          </tr>
                        </table>
                        <table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; mso-table-lspace: 0; mso-table-rspace: 0;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; min-width:100%;" width="100%">
                          <tbody>
                            <tr>
                              <td style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; padding-top: 24px; padding-right: 18px;
 padding-bottom: 24px; padding-left: 18px; color: #7F6925; font-family: ''Asap'',
 Helvetica, sans-serif; font-size: 12px;" valign="top">
                                <div style="text-align: center;">Made with
                                  <a href="https://thenounproject.com/" style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; color: #f57153; font-weight: normal; text-decoration:
 none" target="_blank">
                                    <img align="none" alt="Heart icon" height="10" src="https://static.lingoapp.com/assets/images/email/made-with-heart.png" style="-ms-interpolation-mode: bicubic; border: 0; height: auto; outline: none;
 text-decoration: none; width: 10px; height: 10px; margin: 0px;" width="10" />
                                  </a>by
                                  <a href="https://thenounproject.com/" style="mso-line-height-rule: exactly;
 -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color: #f57153;
 font-weight: normal; text-decoration: none; color:#7F6925;" target="_blank" title="Noun Project - Icons for Everything">Noun Project</a>in Culver City, CA 90232</div>
                              </td>
                            </tr>
                            <tbody></tbody>
                          </tbody>
                        </table>
                        <table align="center" border="0" cellpadding="12" style="border-collapse:
 collapse; mso-table-lspace: 0; mso-table-rspace: 0; -ms-text-size-adjust:
 100%; -webkit-text-size-adjust: 100%; ">
                          <tbody>
                            <tr>
                              <td style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%">
                                <a href="https://twitter.com/@lingo_app" style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; color: #f57153; font-weight: normal; text-decoration: none" target="_blank">
                                  <img alt="twitter" height="32" src="https://static.lingoapp.com/assets/images/email/twitter-ic-32x32-email@2x.png" style="-ms-interpolation-mode: bicubic; border: 0; height: auto; outline: none; text-decoration:
 none" width="32" />
                                </a>
                              </td>
                              <td style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%">
                                <a href="https://www.instagram.com/lingo_app/" style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; color: #f57153; font-weight: normal; text-decoration:
 none" target="_blank">
                                  <img alt="Instagram" height="32" src="https://static.lingoapp.com/assets/images/email/instagram-ic-32x32-email@2x.png" style="-ms-interpolation-mode: bicubic; border: 0; height: auto; outline: none;
 text-decoration: none" width="32" />
                                </a>
                              </td>
                              <td style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%">
                                <a href="https://medium.com/@lingo_app" style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; color: #f57153; font-weight: normal; text-decoration: none" target="_blank">
                                  <img alt="medium" height="32" src="https://static.lingoapp.com/assets/images/email/medium-ic-32x32-email@2x.png" style="-ms-interpolation-mode: bicubic; border: 0; height: auto; outline: none; text-decoration: none" width="32" />
                                </a>
                              </td>
                              <td style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%">
                                <a href="https://www.facebook.com/Lingoapp/" style="mso-line-height-rule: exactly; -ms-text-size-adjust: 100%;
 -webkit-text-size-adjust: 100%; color: #f57153; font-weight: normal; text-decoration: none" target="_blank">
                                  <img alt="facebook" height="32" src="https://static.lingoapp.com/assets/images/email/facebook-ic-32x32-email@2x.png" style="-ms-interpolation-mode: bicubic; border: 0; height: auto; outline: none;
 text-decoration: none" width="32" />
                                </a>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </table>
          <!--[if gte mso 9]>
                  </td>
                </tr>
              </table>
            <![endif]-->
          <!-- // END TEMPLATE -->
        </td>
      </tr>
    </table>
  </center>
</body>

</html>', N'Reset your password', 1)
SET IDENTITY_INSERT [dbo].[OTPMaster] ON 

INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (1, 100, N'123edbea-d090-491d-874b-a11a7e7c4c48', N'120894', CAST(N'2020-01-23T23:00:44.553' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (2, 0, N'ffaa288d-9ff4-4bbd-9f6c-a4436c9e200b', N'123456', CAST(N'2020-01-28T20:05:03.733' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (3, 0, N'7019e43e-12a4-4eb5-a5c8-7a5e6bd651e4', N'218645', CAST(N'2020-01-28T21:52:23.903' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (4, 0, N'15af2b1f-84c6-48cb-9d8e-613b1f974b61', N'290278', CAST(N'2020-01-28T22:07:23.737' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (5, 0, N'f07ecd0d-0072-449a-a785-6fab7126cf8e', N'369700', CAST(N'2020-01-28T23:05:08.380' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (6, 0, N'4293a857-dbc7-49e7-b9ef-101e36bbb9c9', N'118846', CAST(N'2020-01-28T23:13:39.743' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (7, 0, N'f236b9ad-bad1-48cd-9b00-9d36e38cb737', N'495145', CAST(N'2020-01-28T23:49:36.640' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (8, 0, N'c6ea928b-f4f4-4854-b257-c7522bd21f87', N'808493', CAST(N'2020-02-09T18:38:02.267' AS DateTime), 0)
INSERT [dbo].[OTPMaster] ([OTPMasterID], [UserID], [GUID], [OTP], [CreatedDate], [Attempts]) VALUES (9, 0, N'c6ea928b-f4f4-4854-b257-c7522bd21f87', N'808493', CAST(N'2020-02-09T18:38:02.703' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[OTPMaster] OFF
SET IDENTITY_INSERT [dbo].[ProductHelp] ON 

INSERT [dbo].[ProductHelp] ([ID], [ProductID], [Title], [ImageUrl], [Description], [AdditionalInfo], [Specification], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [CompanyID], [CategoryID]) VALUES (1, 3, N'Sainik Ply', NULL, N'<div _ngcontent-dll-c3="" class="description"><p _ngcontent-dll-c3="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec posuere odio.Phasellus odio lectus, ultrices non pretium ac, mollis id elit.</p><p _ngcontent-dll-c3="">Fusce tempor tellus non felis tempus vestibulum. Donec molestie purus sem. Suspendisse a neque quam.</p><p _ngcontent-dll-c3="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec posuere odio.Phasellus odio lectus, ultrices non pretium ac, mollis id elit.</p></div> <ul _ngcontent-dll-c3="" class="arrow-style"><li _ngcontent-dll-c3="">Type: Analog Watch</li><li _ngcontent-dll-c3="">Dial: Round Dial</li><li _ngcontent-dll-c3="">Strap: Leatherette</li></ul>', N'<p _ngcontent-dll-c3="">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repudiandae odit iste exercitationem praesentium deleniti nostrum laborum rem id nihil tempora. Adipisci ea commodi unde nam placeat cupiditate quasi a ducimus rem consequuntur ex eligendi minima voluptatem assumenda voluptas quidem sit maiores odio velit voluptate.</p> <ul _ngcontent-dll-c3="" class="arrow-style"><li _ngcontent-dll-c3="">Type: Analog Watch</li><li _ngcontent-dll-c3="">Dial: Round Dial</li><li _ngcontent-dll-c3="">Strap: Leatherette</li><li _ngcontent-dll-c3="">Clasp Type: Buckle</li><li _ngcontent-dll-c3="">Occasion: Casual</li><li _ngcontent-dll-c3="">Movement: PC21 Movement</li><li _ngcontent-dll-c3="">Others: One Year Warranty</li><li _ngcontent-dll-c3="">Style Tip: Try with polo tees and Yepme chinos!</li></ul>', NULL, CAST(N'2020-02-08T21:05:50.833' AS DateTime), 0, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[ProductHelp] ([ID], [ProductID], [Title], [ImageUrl], [Description], [AdditionalInfo], [Specification], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [CompanyID], [CategoryID]) VALUES (2, 4, N'Century CLUB PRIME  Help', NULL, N'<div _ngcontent-dll-c3="" class="description"><p _ngcontent-dll-c3="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec posuere odio.Phasellus odio lectus, ultrices non pretium ac, mollis id elit.</p><p _ngcontent-dll-c3="">Fusce tempor tellus non felis tempus vestibulum. Donec molestie purus sem. Suspendisse a neque quam.</p><p _ngcontent-dll-c3="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec posuere odio.Phasellus odio lectus, ultrices non pretium ac, mollis id elit.</p></div> <ul _ngcontent-dll-c3="" class="arrow-style"><li _ngcontent-dll-c3="">Type: Analog Watch</li><li _ngcontent-dll-c3="">Dial: Round Dial</li><li _ngcontent-dll-c3="">Strap: Leatherette</li></ul>', N'<p _ngcontent-dll-c3="">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repudiandae odit iste exercitationem praesentium deleniti nostrum laborum rem id nihil tempora. Adipisci ea commodi unde nam placeat cupiditate quasi a ducimus rem consequuntur ex eligendi minima voluptatem assumenda voluptas quidem sit maiores odio velit voluptate.</p> <ul _ngcontent-dll-c3="" class="arrow-style"><li _ngcontent-dll-c3="">Type: Analog Watch</li><li _ngcontent-dll-c3="">Dial: Round Dial</li><li _ngcontent-dll-c3="">Strap: Leatherette</li><li _ngcontent-dll-c3="">Clasp Type: Buckle</li><li _ngcontent-dll-c3="">Occasion: Casual</li><li _ngcontent-dll-c3="">Movement: PC21 Movement</li><li _ngcontent-dll-c3="">Others: One Year Warranty</li><li _ngcontent-dll-c3="">Style Tip: Try with polo tees and Yepme chinos!</li></ul>', NULL, CAST(N'2020-02-08T21:05:50.833' AS DateTime), 0, NULL, NULL, 0, 1, NULL)
SET IDENTITY_INSERT [dbo].[ProductHelp] OFF
SET IDENTITY_INSERT [dbo].[ProductMaster] ON 

INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (3, N'Century Sainik
', N'Century Sainik
 Ply Board', N'NA', N'101', N'Century MR', N'Century MR', 1, NULL, NULL, CAST(73.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (4, N'Century CLUB PRIME
', N'Century CLUB PRIME
', N'NA', N'101', N'Century CLUB PRIME
', N'Century CLUB PRIME
', 1, NULL, NULL, CAST(94.00 AS Decimal(18, 2)), CAST(N'2020-10-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (24, N'Century Popular MR
', N'Century Popular MR
', N'NA', N'101', N'Century Popular MR
', NULL, 1, NULL, NULL, CAST(105.00 AS Decimal(18, 2)), CAST(N'2020-10-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (41, N'Century MARINE', N'Century MARINE', N'NA', N'101', N'Century MARINE', N'Century MARINE', 1, N'', N'', CAST(118.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (42, N'Bhutan TUFF', N'Bhutan TUFF', N'NA', N'101', N'Bhutan TUFF', N'Bhutan TUFF', 1, N'', N'', CAST(68.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (43, N'Green Ply', N'Green Ply', N'NA', N'101', N'Green Ply', N'Green Ply', 1, N'', N'', CAST(105.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (44, N'CENTURY HDHMR', N'CENTURY HDHMR', N'NA', N'101', N'CENTURY HDHMR', N'CENTURY HDHMR', 1, N'', N'', CAST(70.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (45, N'VENUS BWR', N'VENUS BWR', N'NA', N'101', N'VENUS BWR', N'VENUS BWR', 1, N'', N'', CAST(65.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (46, N'Non Branded A', N'Non Branded A', N'NA', N'101', N'Non Branded A', N'Non Branded A', 1, N'', N'', CAST(52.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (47, N'Non Branded B', N'Non Branded B', N'NA', N'101', N'Non Branded B', N'Non Branded B', 1, N'', N'', CAST(45.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 2, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (48, N'Mica Liner .6mm', N'Mica Liner .6mm', N'NA', N'102', N'Mica Liner .6mm', N'Mica Liner .6mm', 1, N'', N'', CAST(280.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 3, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (49, N'NON-Branded Liner .72mm', N'NON-Branded Liner .72mm', N'NA', N'102', N'NON-Branded Liner .72mm', N'NON-Branded Liner .72mm', 1, N'', N'', CAST(370.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 3, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (50, N'Mica Branded Liner .72mm', N'Mica Branded Liner .72mm', N'NA', N'102', N'Mica Branded Liner .72mm', N'Mica Branded Liner .72mm', 1, N'', N'', CAST(450.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 3, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (51, N'Laminate Mica Plain .8mm', N'Laminate Mica Plain .8mm', N'NA', N'103', N'Laminate Mica Plain .8mm', N'Laminate Mica Plain .8mm', 1, N'', N'', CAST(750.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (52, N'Laminate Mica GLOSS .8mm', N'Laminate Mica GLOSS .8mm', N'NA', N'103', N'Laminate Mica GLOSS .8mm', N'Laminate Mica GLOSS .8mm', 1, N'', N'', CAST(900.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (53, N'Laminate Mica PLAIN 1mm', N'Laminate Mica PLAIN 1mm', N'NA', N'103', N'Laminate Mica PLAIN 1mm', N'Laminate Mica PLAIN 1mm', 1, N'', N'', CAST(1200.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (54, N'Laminate Mica Texture 1mm', N'Laminate Mica Texture 1mm', N'NA', N'103', N'Laminate Mica Texture 1mm', N'Laminate Mica Texture 1mm', 1, N'', N'', CAST(1400.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (55, N'Laminate Mica Hi Gloss', N'Laminate Mica Hi Gloss', N'NA', N'103', N'Laminate Mica Hi Gloss', N'Laminate Mica Hi Gloss', 1, N'', N'', CAST(1900.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (56, N'Laminate PVC 1.25 mm', N'Laminate PVC 1.25 mm', N'NA', N'103', N'Laminate PVC 1.25 mm', N'Laminate PVC 1.25 mm', 1, N'', N'', CAST(1900.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (57, N'Laminate Acrylic 1 mm', N'Laminate Acrylic 1 mm', N'NA', N'103', N'Laminate Acrylic 1 mm', N'Laminate Acrylic 1 mm', 1, N'', N'', CAST(2200.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (58, N'Laminate Acrylic 1.5 mm', N'Laminate Acrylic 1.5 mm', N'NA', N'103', N'Laminate Acrylic 1.5 mm', N'Laminate Acrylic 1.5 mm', 1, N'', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (59, N'Laminate PRINTED', N'Laminate PRINTED', N'NA', N'103', N'Laminate PRINTED', N'Laminate PRINTED', 1, N'', N'', CAST(3000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (60, N'Laminate Metallic', N'Laminate Metallic', N'NA', N'103', N'Laminate Metallic', N'Laminate Metallic', 1, N'', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (61, N'Duco', N'Duco', N'NA', N'103', N'Duco', N'Duco', 1, N'', N'', CAST(300.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (62, N'PU/Veener+Polish', N'PU/Veener+Polish', N'NA', N'103', N'PU/Veener+Polish', N'PU/Veener+Polish', 1, N'', N'', CAST(450.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 4, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (63, N'Hettich Soft Close', N'Hettich Soft Close', N'NA', N'104', N'Hettich Soft Close', N'Hettich Soft Close', 1, N'', N'', CAST(370.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (64, N'Hettich Normal', N'Hettich Normal', N'NA', N'104', N'Hettich Normal', N'Hettich Normal', 1, N'', N'', CAST(68.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (65, N'INOX Soft Close', N'INOX Soft Close', N'NA', N'104', N'INOX Soft Close', N'INOX Soft Close', 1, N'', N'', CAST(180.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (66, N'INOX Normal', N'INOX Normal', N'NA', N'104', N'INOX Normal', N'INOX Normal', 1, N'', N'', CAST(55.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (67, N'Godjrej Soft Close', N'Godjrej Soft Close', N'NA', N'104', N'Godjrej Soft Close', N'Godjrej Soft Close', 1, N'', N'', CAST(280.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (68, N'Godjrej Normal', N'Godjrej Normal', N'NA', N'104', N'Godjrej Normal', N'Godjrej Normal', 1, N'', N'', CAST(55.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (69, N'EBCO Soft Close', N'EBCO Soft Close', N'NA', N'104', N'EBCO Soft Close', N'EBCO Soft Close', 1, N'', N'', CAST(200.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (70, N'EBCO Normal', N'EBCO Normal', N'NA', N'104', N'EBCO Normal', N'EBCO Normal', 1, N'', N'', CAST(55.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (71, N'Century Soft Close', N'Century Soft Close', N'NA', N'104', N'Century Soft Close', N'Century Soft Close', 1, N'', N'', CAST(160.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (72, N'Century Normal', N'Century Normal', N'NA', N'104', N'Century Normal', N'Century Normal', 1, N'', N'', CAST(50.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 5, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (106, N'Hettich Soft Close', N'Hettich Soft Close', N'NA', N'105', N'Hettich Soft Close', N'Hettich Soft Close', 1, N'', N'', CAST(700.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (107, N'Hettich Normal', N'Hettich Normal', N'NA', N'105', N'Hettich Normal', N'Hettich Normal', 1, N'', N'', CAST(390.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (108, N'INOX Soft Close', N'INOX Soft Close', N'NA', N'105', N'INOX Soft Close', N'INOX Soft Close', 1, N'', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (109, N'INOX Normal', N'INOX Normal', N'NA', N'105', N'INOX Normal', N'INOX Normal', 1, N'', N'', CAST(300.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (110, N'Godjrej Soft Close', N'Godjrej Soft Close', N'NA', N'105', N'Godjrej Soft Close', N'Godjrej Soft Close', 1, N'', N'', CAST(580.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (111, N'Godjrej Normal', N'Godjrej Normal', N'NA', N'105', N'Godjrej Normal', N'Godjrej Normal', 1, N'', N'', CAST(290.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (112, N'EBCO Soft Close', N'EBCO Soft Close', N'NA', N'105', N'EBCO Soft Close', N'EBCO Soft Close', 1, N'', N'', CAST(500.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (113, N'EBCO Normal', N'EBCO Normal', N'NA', N'105', N'EBCO Normal', N'EBCO Normal', 1, N'', N'', CAST(300.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (114, N'Century Soft Close', N'Century Soft Close', N'NA', N'105', N'Century Soft Close', N'Century Soft Close', 1, N'', N'', CAST(450.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (115, N'Century Normal', N'Century Normal', N'NA', N'105', N'Century Normal', N'Century Normal', 1, N'', N'', CAST(200.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (116, N'INOX Ennotech', N'INOX Ennotech', N'NA', N'105', N'INOX Ennotech', N'INOX Ennotech', 1, N'', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (117, N'Hettich Ennotech', N'Hettich Ennotech', N'NA', N'105', N'Hettich Ennotech', N'Hettich Ennotech', 1, N'', N'', CAST(3600.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 6, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (118, N'Hettich Baskets', N'Hettich Baskets', N'NA', N'106', N'Hettich Baskets', N'Hettich Baskets', 1, N'', N'', CAST(2500.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 7, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (119, N'Colors Baskets', N'Colors Baskets', N'NA', N'106', N'Colors Baskets', N'Colors Baskets', 1, N'', N'', CAST(800.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 7, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (120, N'Branded 8 Inches', N'Branded 8 Inches', N'NA', N'107', N'Branded 8 Inches', N'Branded 8 Inches', 1, N'', N'', CAST(350.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 8, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (121, N'PROFILE HANDLES', N'PROFILE HANDLES', N'NA', N'107', N'PROFILE HANDLES', N'PROFILE HANDLES', 1, N'', N'', CAST(200.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 8, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (122, N'Non-Branded 6 Inches', N'Non-Branded 6 Inches', N'NA', N'107', N'Non-Branded 6 Inches', N'Non-Branded 6 Inches', 1, N'', N'', CAST(80.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 8, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (123, N'TALL UNIT', N'TALL UNIT', N'NA', N'100', N'TALL UNIT', N'TALL UNIT', 1, N'', N'', CAST(16000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (124, N'Rolling Shutter', N'Rolling Shutter', N'NA', N'100', N'Rolling Shutter', N'Rolling Shutter', 1, N'', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (125, N'OVEN UNIT', N'OVEN UNIT', N'NA', N'100', N'OVEN UNIT', N'OVEN UNIT', 1, N'', N'', CAST(30000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (126, N'MAGIC CORNER', N'MAGIC CORNER', N'NA', N'100', N'MAGIC CORNER', N'MAGIC CORNER', 1, N'', N'', CAST(9000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (127, N'GLASS SHUTTERS', N'GLASS SHUTTERS', N'NA', N'100', N'GLASS SHUTTERS', N'GLASS SHUTTERS', 1, N'', N'', CAST(5000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (128, N'LIFT Ups', N'LIFT Ups', N'NA', N'100', N'LIFT Ups', N'LIFT Ups', 1, N'', N'', CAST(10000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (129, N'CHIMNEY', N'CHIMNEY', N'NA', N'100', N'CHIMNEY', N'CHIMNEY', 1, N'', N'', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 1, 1, 2)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (130, N'KITCHEN TILES', N'KITCHEN TILES', N'NA', N'500', N'KITCHEN TILES', N'KITCHEN TILES', 1, N'', N'', CAST(130.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 1, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (131, N'BASIC', N'BASIC', N'NA', N'700', N'BASIC', N'BASIC', 1, N'', N'', CAST(130.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (132, N'BLACK GALAXY', N'BLACK GALAXY', N'NA', N'700', N'BLACK GALAXY', N'BLACK GALAXY', 1, N'', N'', CAST(260.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (133, N'QUARTZ', N'QUARTZ', N'NA', N'700', N'QUARTZ', N'QUARTZ', 1, N'', N'', CAST(350.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (134, N'NANO', N'NANO', N'NA', N'700', N'NANO', N'NANO', 1, N'', N'', CAST(450.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (135, N'IMPORTED', N'IMPORTED', N'NA', N'700', N'IMPORTED', N'IMPORTED', 1, N'', N'', CAST(600.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (136, N'Carpenter Contractor Manually', N'Carpenter Contractor Manually', N'NA', N'200', N'Carpenter Contractor Manually', N'Carpenter Contractor Manually', 1, N'', N'', CAST(250.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 9, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (137, N'Factory Made', N'Factory Made', N'NA', N'200', N'Factory Made', N'Factory Made', 1, N'', N'', CAST(350.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 9, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (138, N'Others', N'Miscellaneous', N'NA', N'300', N'Others', N'Miscellaneous', 1, N'', N'', CAST(145.00 AS Decimal(18, 2)), CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL, 0, 0, 1, 10, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (1004, N'OBD DISTAMPER
', N'OBD DISTAMPER
', N'NA', N'400', N'OBD DISTAMPER
', N'OBD DISTAMPER
', 1, NULL, NULL, CAST(12.00 AS Decimal(18, 2)), CAST(N'2020-02-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 11, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (1010, N'PUTTY + TRACTOR EMULSION DISTAMPER
', N'PUTTY + TRACTOR EMULSION DISTAMPER
', N'NA', N'400', N'PUTTY + TRACTOR EMULSION DISTAMPER
', N'PUTTY + TRACTOR EMULSION DISTAMPER
', 1, NULL, NULL, CAST(22.00 AS Decimal(18, 2)), CAST(N'2020-02-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 11, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (1011, N'PUTTY + ASIAN ROYAL SHINE
', N'PUTTY + ASIAN ROYAL SHINE
', N'NA', N'400', N'PUTTY + ASIAN ROYAL SHINE
', N'PUTTY + ASIAN ROYAL SHINE
', 1, NULL, NULL, CAST(45.00 AS Decimal(18, 2)), CAST(N'2020-02-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 11, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (1012, N'PUTTY + DULEX VELVET TOUCH
', N'PUTTY + DULEX VELVET TOUCH
', N'NA', N'400', N'PUTTY + DULEX VELVET TOUCH
', N'PUTTY + DULEX VELVET TOUCH
', 1, NULL, NULL, CAST(45.00 AS Decimal(18, 2)), CAST(N'2020-02-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 11, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (1013, N'Basic Tiles 2x2
', N'Basic Tiles 2x2
', N'NA', N'500', N'Basic Tiles 2x2
', N'Basic Tiles 2x2
', 1, NULL, NULL, CAST(110.00 AS Decimal(18, 2)), CAST(N'2020-02-01T00:00:00.000' AS DateTime), 1, NULL, NULL, 0, 1, 12, 1, 4)
INSERT [dbo].[ProductMaster] ([ProductID], [Name], [Title], [ImageUrl], [CategoryCode], [BasicModelCode], [BasicModelName], [Color], [SKUCode], [SKUName], [MRP], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsDeleted], [IsActive], [CategoryID], [CompanyID], [MeasurementUnit]) VALUES (1015, N'Basic Tiles 2x4
', N'Basic Tiles 2x4
', N'NA', N'500', N'Basic Tiles 2x4
', N'Basic Tiles 2x4
', 1, NULL, NULL, CAST(150.00 AS Decimal(18, 2)), CAST(N'2020-02-01T00:00:00.000' AS DateTime), 0, NULL, NULL, 0, 1, 12, 1, 4)
SET IDENTITY_INSERT [dbo].[ProductMaster] OFF
ALTER TABLE [dbo].[Emails] ADD  CONSTRAINT [UserMaster_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[EmailTemplate] ADD  CONSTRAINT [DF_EmailTemplate_IsActive]  DEFAULT ((0)) FOR [IsActive]
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
