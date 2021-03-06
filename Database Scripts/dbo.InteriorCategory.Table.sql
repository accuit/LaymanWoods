USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[InteriorCategory]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[InteriorCategory] ADD  DEFAULT ((1)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[InteriorCategory] ADD  DEFAULT ((1)) FOR [CompanyID]
GO
