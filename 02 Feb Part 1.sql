--COALESCE() Function

Create table tblEmployee (ID int, FirstName nvarchar(50), MiddleName nvarchar(50), LastName nvarchar(50));
Select * from tblEmployee

Select COALESCE(FirstName, MiddleName, LastName, 'Unknown') As Employee_Name from tblEmployee

--UNION
SELECT CustomerName as Name, ContactName, Address, City, PostalCode, Country FROM [Customers]
UNION
SELECT SupplierName, ContactName, Address, City, PostalCode, Country FROM [Suppliers]
ORDER BY ContactName

--UNION ALL
SELECT CustomerName as Name, ContactName, Address, City, PostalCode, Country FROM [Customers]
UNION ALL
SELECT SupplierName, ContactName, Address, City, PostalCode, Country FROM [Suppliers]
ORDER BY ContactName

--PROCEDURES

--Create Procedure
CREATE PROC uspSelect_tblPerson
as
Begin
	SELECT * FROM tblPerson
End


--Alter Procedure

ALTER PROC uspSelect_tblPerson
@GenderId int
as
Begin
	SELECT * FROM tblPerson where GenderID = @GenderId
End

--Executing Procedure with Parameters

uspSelect_tblPerson 1

--Passing NULL Values to the Parameter AND Encrypting the Stored Procedure

ALTER PROC uspSelect_tblPerson_tblGender
@status int NULL
WITH ENCRYPTION
as
Begin
	IF @status IS NULL
		SELECT * FROM tblPerson
	Else
		SELECT * FROM tblGender
End

--Executing Procedure with Null Values

uspSelect_tblPerson_tblGender NULL

DROP PROC uspSelect_tblPerson

--To see the text of Stored Procedure
--sp_helptext is Syste Stored Procedure

sp_helptext uspSelect_tblPerson_tblGender

--Procedure with output Parameters

CREATE PROC uspCount
@GenderID int,
@count int output
as
BEGIN
	Select @count = Count(ID) from tblPerson where GenderID = @GenderID
END

--Executon & Printing output

DECLARE @myCount int
EXECUTE uspCount 1, @myCount OUTPUT
--Print @myCount

--Experiment

EXECUTE uspCount @myCount, @myCount OUTPUT
Print @myCount

--Return Values

Create PROC uspCount2
@GenderID int
as
BEGIN
	RETURN (Select Count(ID) from tblPerson where GenderID = @GenderID)
END

Declare @TotalCount int
EXECUTE @TotalCount = uspCount2 1
Print @TotalCount

Create PROC uspCount3
@ID int
as
BEGIN
	RETURN (Select Name from tblPerson where ID = @ID)
END

-- Can't return a string value only integer value can be returned
Declare @Name nvarchar(50)
EXECUTE @Name = uspCount3 1
Print @Name


Create PROC uspCount4
@ID int,
@Name nvarchar(50) out
as
BEGIN
	Select @Name = Name from tblPerson where ID = @ID
END

-- String can be sent as output parameter
Declare @Name nvarchar(50)
EXECUTE uspCount4 1, @Name out
Print 'Name : ' + @Name

--String Functions
Select ASCII('A')

Select CHAR(65)

Declare @start int
Set @start = 65
while(@start <=90)
BEGIN
	Print CHAR(@start)
	Set @start = @start + 1
END


--LEFT(Character_Expression, Integer_Expression) - Returns the specified number of characters from the left hand side of the given character expression.

Select LEFT('ABCDE', 3)
--Output: ABC

--RIGHT(Character_Expression, Integer_Expression) - Returns the specified number of characters from the right hand side of the given character expression.

Select RIGHT('ABCDE', 3)
--Output: CDE

--CHARINDEX('Expression_To_Find', 'Expression_To_Search', 'Start_Location') - Returns the starting position of the specified expression in a character string. Start_Location parameter is optional.

--Example: In this example, we get the starting position of '@' character in the email string 'sara@aaa.com'. 
Select CHARINDEX('@','sara@aaa.com',1)
--Output: 5

--SUBSTRING('Expression', 'Start', 'Length') - As the name, suggests, this function returns substring (part of the string), from the given expression. You specify the starting location using the 'start' parameter and the number of characters in the substring using 'Length' parameter. All the 3 parameters are mandatory.

--Example: Display just the domain part of the given email 'John@bbb.com'.
Select SUBSTRING('John@bbb.com',6, 7)
--Output: bbb.com

--REPLICATE(String_To_Be_Replicated, Number_Of_Times_To_Replicate) - Repeats the given string, for the specified number of times.

SELECT REPLICATE('Pragim', 3)
--Output: Pragim Pragim Pragim

Select Name, SUBSTRING(Email, 1, 2) + REPLICATE('*',5) + 
SUBSTRING(Email, CHARINDEX('@',Email), LEN(Email) - CHARINDEX('@',Email)+1) as Email
from tblPerson

--SPACE(Number_Of_Spaces) - Returns number of spaces, specified by the Number_Of_Spaces argument.

--Example: The SPACE(5) function, inserts 5 spaces between FirstName and LastName
Select FirstName + SPACE(5) + LastName as FullName
From tblEmployee

--PATINDEX('%Pattern%', Expression)
--Returns the starting position of the first occurrence of a pattern in a specified expression. It takes two arguments, the pattern to be searched and the expression. PATINDEX() is simial to CHARINDEX(). With CHARINDEX() we cannot use wildcards, where as PATINDEX() provides this capability. If the specified pattern is not found, PATINDEX() returns ZERO.

--Example: 
Select Email, PATINDEX('%@gmail.com', Email) as FirstOccurence 
from tblPerson
Where PATINDEX('%@gmail.com', Email) > 0

--REPLACE(String_Expression, Pattern , Replacement_Value)
--Replaces all occurrences of a specified string value with another string value.

--Example: All .COM strings are replaced with .NET
Select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from  tblPerson

--STUFF(Original_Expression, Start, Length, Replacement_expression)
--STUFF() function inserts Replacement_expression, at the start position specified, along with removing the charactes specified using Length parameter.

--Example:
Select Name, Email, STUFF(Email, 2, 3, '*****') as StuffedEmail
From tblPerson

--DATE FUNCTIONS

CREATE TABLE [tblDateTime]
(
 [c_time] [time](7) NULL,
 [c_date] [date] NULL,
 [c_smalldatetime] [smalldatetime] NULL,
 [c_datetime] [datetime] NULL,
 [c_datetime2] [datetime2](7) NULL,
 [c_datetimeoffset] [datetimeoffset](7) NULL
)

INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

Select * from tblDateTime

UPDATE tblDateTime SET c_datetimeoffset = '2023-02-02 17:13:17.4833333 +01:00'
WHERE c_datetimeoffset = '2023-02-02 17:13:17.4833333 +00:00'

--System DATETIME Functions

SELECT GETDATE() as Date, 'GETDATE()' as FunctionName
SELECT CURRENT_TIMESTAMP as Date, 'CURRENT_TIMESTAMP' as FunctionName
SELECT SYSDATETIME() as Date, 'SYSDATETIME()' as FunctionName
SELECT SYSDATETIMEOFFSET() as Date, 'SYSDATETIMEOFFSET()' as FunctionName
SELECT GETUTCDATE() as Date, 'GETUTCDATE()' as FunctionName
SELECT SYSUTCDATETIME() as Date, 'SYSUTCDATETIME()' as FunctionName

Select Month('01/31/2012')
Select DATENAME(Day, '2012-09-30 12:43:46.837') -- Returns 30
Select DATENAME(WEEKDAY, '2012-09-30 12:43:46.837') -- Returns Sunday
Select DATENAME(MONTH, '2012-09-30 12:43:46.837') -- Returns September
Select DATEPART(MM, '2012-09-30 12:43:46.837') -- Returns 09
Select DATEPART(WEEK, '2012-09-30 12:43:46.837') -- Returns 40
Select DATEPART(WEEKDAY, '2012-09-30 12:43:46.837') -- Returns 01
Select DATEPART(DAYOFYEAR, '2012-09-30 12:43:46.837') -- Returns 274