USE [LaymanWoods]
GO
/****** Object:  User [adm]    Script Date: 21-Jun-20 12:49:32 PM ******/
CREATE USER [adm] FOR LOGIN [adm] WITH DEFAULT_SCHEMA=[adm]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [adm]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [adm]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [adm]
GO
ALTER ROLE [db_datareader] ADD MEMBER [adm]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [adm]
GO
