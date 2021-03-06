USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryMaster](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](32) NOT NULL,
	[CategoryCode] [varchar](50) NOT NULL,
	[CompanyID] [int] NULL,
	[WebPartType] [int] NOT NULL,
	[isMultiSelect] [bit] NOT NULL,
	[Title] [varchar](150) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CategoryMaster] ADD  DEFAULT ((0)) FOR [WebPartType]
GO
ALTER TABLE [dbo].[CategoryMaster] ADD  DEFAULT ((0)) FOR [isMultiSelect]
GO
