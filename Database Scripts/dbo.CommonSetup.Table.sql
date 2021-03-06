USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[CommonSetup]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[CompanyID] [int] NULL,
	[Description] [varchar](200) NULL,
 CONSTRAINT [PK_CommonSetup] PRIMARY KEY CLUSTERED 
(
	[CommonSetupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
