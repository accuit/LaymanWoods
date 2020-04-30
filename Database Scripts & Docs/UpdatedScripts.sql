USE [LaymanWoods]
GO

INSERT INTO [dbo].[ProductMaster] VALUES(
 'Evershine Ennotech' ,'Evershine Ennotech' ,'NA' ,'105' ,'Evershine Ennotech' ,1 ,NULL ,NULL ,3500 , GetDate() ,1 ,NULL ,NULL ,0 ,1,6,1,2)
GO


INSERT [dbo].[CategoryMaster] ([CategoryName], [CategoryCode], [CompanyID], [WebPartType], [isMultiSelect], [Title]) VALUES ( N'Kitchen Tiles', N'501', 1, 1, 0, N'Kitchen Tiles')
INSERT [dbo].[CategoryMaster] ([CategoryName], [CategoryCode], [CompanyID], [WebPartType], [isMultiSelect], [Title]) VALUES ( N'Granite Tiles', N'502', 1, 1, 0, N'Granite Tiles')









