--Last generated identity column value
-- There are several ways in sql server, to retrieve the last identity value that is generated.
--The most common way is to use SCOPE_IDENTITY() built in function.
--SCOPE_IDENTITY() - returns the last identity value that is created in the same session and in the same scope.
--@@IDENTITY - returns the last identity value that is created in the same session and across any scope.
--IDENT_CURRENT('TableName') - returns the last identity value that is created for a specific table across any session and any scope.


CREATE TABLE TEST1 (ID int identity(1, 1), Value nvarchar(50));
CREATE TABLE TEST2 (ID int identity(1, 1), Value nvarchar(50))

Insert into TEST1 values('X')

SELECT SCOPE_IDENTITY();
SELECT @@IDENTITY
SELECT IDENT_CURRENT('TEST1')

Select * from TEST1
Select * from TEST2

Create Trigger testTrigger on Test1 for INSERT
As
Begin
	Insert into TEST2 values ('YYY');
End

--UNIQUE KEY CONSTRAINT
--We use UNIQUE constraint to enforce uniqueness of a column i.e the column shouldn't allow any duplicate values.

--difference between Primary key constraint and Unique key constraint
--1. A table can have only one primary key, but more than one unique key
--2. Primary key does not allow nulls, where as unique key allows one null

--To create the unique key using a query:
--Alter Table Table_Name
--Add Constraint Constraint_Name Unique(Column_Name)

ALTER TABLE tblPerson Add Constraint UQ_tblPerson_Email UNIQUE(Email);

-- Ways to Replacing NULL Values from database

Select Name, Email, ISNULL(GenderID, 3) from tblPerson

Select Name, Email, 
CASE 
WHEN GenderID IS NULL THEN 3 Else GenderID
END
from tblPerson

Select Name, Email, COALESCE(GenderID, 3) from tblPerson
