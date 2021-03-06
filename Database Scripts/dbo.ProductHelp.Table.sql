USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[ProductHelp]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[CategoryCode] [varchar](50) NULL,
 CONSTRAINT [PK_ProductHelp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ProductHelp] ADD  CONSTRAINT [DF_ProductHelp_Company]  DEFAULT ((1)) FOR [CompanyID]
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
