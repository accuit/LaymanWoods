USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[ContactEnquiry]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactEnquiry](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Mobile] [varchar](15) NOT NULL,
	[Message] [varchar](1000) NULL,
	[Address] [varchar](300) NULL,
	[City] [varchar](100) NULL,
	[Pincode] [varchar](10) NULL,
	[Status] [int] NULL,
	[CompanyID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ContactEnquiry] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactEnquiry] ADD  CONSTRAINT [DF_ContactEnquiry_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ContactEnquiry] ADD  CONSTRAINT [DF_Contact_CompanyID]  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[ContactEnquiry] ADD  CONSTRAINT [DF_ContactEnquiry_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
