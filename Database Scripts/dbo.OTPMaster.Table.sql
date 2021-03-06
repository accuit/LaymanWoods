USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[OTPMaster]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OTPMaster](
	[OTPMasterID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[GUID] [varchar](500) NULL,
	[OTP] [varchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Attempts] [int] NULL,
 CONSTRAINT [PK_OTPMaster] PRIMARY KEY CLUSTERED 
(
	[OTPMasterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
