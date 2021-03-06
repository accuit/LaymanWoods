USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductMaster](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Title] [varchar](150) NOT NULL,
	[ImageUrl] [varchar](1000) NOT NULL,
	[CategoryCode] [varchar](10) NOT NULL,
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
 CONSTRAINT [PK_ProductMaster] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Product_Name] UNIQUE NONCLUSTERED 
(
	[ProductID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_ProductMaster_CategoryMaster] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [FK_ProductMaster_CategoryMaster]
GO
