USE [LaymanWoods]
GO
/****** Object:  Table [dbo].[DictionaryEncryptDecrypt]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DictionaryEncryptDecrypt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CharacterValue] [varchar](5) NOT NULL,
	[EncryptedValue] [varchar](5) NOT NULL
) ON [PRIMARY]
GO
