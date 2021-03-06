USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[InteriorProducts]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[InteriorProducts] ADD  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [dbo].[InteriorProducts] ADD  DEFAULT ((1)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[InteriorProducts] ADD  DEFAULT ((1)) FOR [CompanyID]
GO
ALTER TABLE [dbo].[InteriorProducts]  WITH CHECK ADD  CONSTRAINT [FK_InteriorProducts_InteriorCategory] FOREIGN KEY([InteriorCategoryID])
REFERENCES [dbo].[InteriorCategory] ([ID])
GO
ALTER TABLE [dbo].[InteriorProducts] CHECK CONSTRAINT [FK_InteriorProducts_InteriorCategory]
GO
