USE [LaymanWoods]
GO
/****** Object:  UserDefinedFunction [dbo].[DecryptStr]    Script Date: 21-Jun-20 12:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[DecryptStr](@EncyptedString VARCHAR(400))
Returns VARCHAR(200)
AS
BEGIN
/*Declare Initial Variable(s) and table(s)*/
DECLARE @DecyptedString VARCHAR(200)
DECLARE @EncDecTbl TABLE
(
   ID INT IDENTITY,
   CharacterValue VARCHAR(5),
   EncryptedValue VARCHAR(5)
)
IF(@EncyptedString IS NOT NULL AND @EncyptedString<>'')
BEGIN

   DECLARE @Counter INT
   DECLARE @Characterlength INT

   --:: Set length for character set as per dictionary
   SET @Characterlength=2 
   
   --:: reverse string
   SET @EncyptedString=REVERSE(@EncyptedString)
   SET @Counter=1

   --:: Insert set of characters list into table variable after spliting the string
   WHILE(@Counter<=LEN(@EncyptedString))
   BEGIN
      INSERT INTO @EncDecTbl (EncryptedValue) 
      VALUES (SUBSTRING(@EncyptedString,@Counter,@Characterlength))   
      SET @Counter=@Counter+@Characterlength   
   end

   --:: Update plain character with respect to encrypted set of characters in table variable
   UPDATE A 
     SET A.CharacterValue=B.CharacterValue
     FROM @EncDecTbl A
     Inner Join dbo.DictionaryEncryptDecrypt B with (nolock)
     ON A.EncryptedValue COLLATE Latin1_General_CS_AS =B.EncryptedValue COLLATE Latin1_General_CS_AS
    
    --:: Merge rows into a string
    SELECT @DecyptedString=
        (
         SELECT CharacterValue
          FROM @EncDecTbl
           FOR XML PATH(''),type
       )
       .value('.','VARCHAR(200)') 
END
  Return @DecyptedString
End
GO
