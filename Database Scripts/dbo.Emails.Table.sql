USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[Emails]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Emails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[UserID] [int] NULL,
	[TemplateID] [int] NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](50) NULL,
	[Mobile] [varchar](20) NULL,
	[EmailAddress] [varchar](150) NULL,
	[Message] [varchar](1500) NULL,
	[Status] [int] NOT NULL,
	[ProductID] [int] NULL,
	[Address] [varchar](300) NULL,
	[Pincode] [varchar](30) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Emails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Emails] ADD  CONSTRAINT [UserMaster_Status]  DEFAULT ((1)) FOR [Status]
GO
