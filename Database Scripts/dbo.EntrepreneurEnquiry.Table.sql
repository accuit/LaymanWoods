USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[EntrepreneurEnquiry]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntrepreneurEnquiry](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Mobile] [varchar](15) NOT NULL,
	[Profession] [varchar](100) NULL,
	[Location] [varchar](50) NULL,
	[Investment] [decimal](9, 2) NOT NULL,
	[Message] [varchar](1000) NULL,
	[Address] [varchar](300) NULL,
	[City] [varchar](100) NULL,
	[Pincode] [varchar](10) NULL,
	[Status] [int] NULL,
	[CompanyID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_[EntrepreneurEnquiry] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EntrepreneurEnquiry] ADD  CONSTRAINT [DF_EntrepreneurEnquiry_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[EntrepreneurEnquiry] ADD  CONSTRAINT [DF_Entrepreneur_CompanyID]  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[EntrepreneurEnquiry] ADD  CONSTRAINT [DF_Entrepreneur_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
