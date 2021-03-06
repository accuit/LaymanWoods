USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[InteriorAndCategoryMapping]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[isDefault] [bit] NOT NULL,
 CONSTRAINT [PK_Interior_CategoryMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
