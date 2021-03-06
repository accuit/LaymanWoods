USE [LaymanWoods]
GO
/****** Object:  UserDefinedFunction [dbo].[EncryptStr]    Script Date: 21-Jun-20 12:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[EncryptStr](@DecryptedString VARCHAR(200))
Returns VARCHAR(400)
As
BEGIN
DECLARE @EncryptedString VARCHAR(400) 

--:: To Handle blank value
IF(@DecryptedString='')
Begin

	Select @EncryptedString=EncryptedValue
		FROM dbo.DictionaryEncryptDecrypt B WITH (NOLOCK)
	Where CharacterValue = ''

End

Else IF(@DecryptedString IS NOT NULL)
BEGIN

   /*Declare Initial Variable(s) and table(s)*/
   DECLARE @counter INT
   SET @counter=1
   
   DECLARE @EncDecTbl TABLE
   (
      ID INT IDENTITY,
      CharacterValue VARCHAR(5),
      EncryptedValue VARCHAR(5)
    )


   WHILE(@counter<=len(@DecryptedString))
   BEGIN
      --:: Insert characters list into table variable after spliting the string
      INSERT INTO @EncDecTbl (CharacterValue) VALUES (SUBSTRING(@DecryptedString,@counter,1))  
      SET @counter=@counter+1   
   END

   --:: Update encrypted set of characters  with respect to  plain character in table variable
   UPDATE A 
      SET A.EncryptedValue=B.EncryptedValue
   FROM @EncDecTbl A
   Inner Join dbo.DictionaryEncryptDecrypt B WITH (NOLOCK)
   ON A.CharacterValue COLLATE Latin1_General_CS_AS =B.CharacterValue   COLLATE Latin1_General_CS_AS      
   
   --:: Merge rows into a string
   SELECT @EncryptedString=
        (
         SELECT EncryptedValue
          FROM @EncDecTbl
           FOR XML PATH(''),type
       )
       .value('.','VARCHAR(400)')
       

END
   --:: reverse string
   Return REVERSE(@EncryptedString)
END
GO
