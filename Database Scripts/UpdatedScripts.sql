USE [LaymanWoods]
GO

INSERT INTO [dbo].[ProductMaster] VALUES(
 'Evershine Ennotech' ,'Evershine Ennotech' ,'NA' ,'105' ,'Evershine Ennotech' ,1 ,NULL ,NULL ,3500 , GetDate() ,1 ,NULL ,NULL ,0 ,1,6,1,2)
GO

INSERT INTO [dbo].[ProductMaster] VALUES(
 'Blum Ennotech' ,'Blum Ennotech' ,'NA' ,'105' ,'Blum Ennotech','Blum Ennotech' ,1 ,NULL ,NULL ,3800 , GetDate() ,1 ,NULL ,NULL ,0 ,1,6,1,2)
GO

INSERT INTO [dbo].[ProductMaster] VALUES(
 'INOX Ennotech' ,'Inox Ennotech' ,'NA' ,'105' ,'Inox Ennotech', 'Inox Ennotech' ,1 ,NULL ,NULL ,2000 , GetDate() ,1 ,NULL ,NULL ,0 ,1,6,1,2)
GO

INSERT INTO [dbo].[ProductMaster] VALUES(
 'Merino' ,'Merino' ,'NA' ,'105' ,'Merino', 'Merino' ,1 ,NULL ,NULL ,78 , GetDate() ,1 ,NULL ,NULL ,0 , 1, 2, 1, 2)
GO

Alter Table ProductMaster 
Add IsDefault bit Default 0;

Update Productmaster Set IsDefault = 0;

Update ProductMaster set MRP=1400 Where ProductID = 55;
Update ProductMaster set MRP=20700 Where ProductID = 138;
Update ProductMaster set MRP=70 Where ProductID = 64;
Update ProductMaster set MRP=3000 Where ProductID = 118;

Update ProductMaster set IsDefault=1 Where ProductID in (3, 49, 136, 55, 121, 64, 118, 138)

Alter Table ProductMaster 
Add Multiplier decimal(18,2) Default 1;

Alter Table ProductMaster 
Add Divisor decimal(18,2) Default 1;

Update CategoryMaster set CategoryName = 'Shutter Finish' Where CategoryCode = 103;
Update ProductMaster set Multiplier= 1;
Update ProductMaster set  Divisor = 1;
Update ProductMaster set Multiplier= 32 Where CategoryCode = 101;
Update ProductMaster set  Divisor = 6.2 Where CategoryCode = 101;
Update ProductMaster set  Divisor = 3.5 Where CategoryCode = 102;
Update ProductMaster set  Divisor = 20 Where CategoryCode = 103;
Update ProductMaster set  Divisor = 3 Where CategoryCode = 104;
Update ProductMaster set  Divisor = 13 Where CategoryCode = 105;
Update ProductMaster set  Divisor = 13 Where CategoryCode = 106;
Update ProductMaster set  Divisor = 3 Where CategoryCode = 107;
Update ProductMaster set  Mrp = 550 Where ProductID = 108;
INSERT INTo CategoryMaster Values('Locks', '108', 1)







