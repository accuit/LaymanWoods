USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
