--Create and altering a Database
Create Database NitinDB

--Renaming the database
--There are two methods using alter command or using a stored procedure

--Alter Command
Alter Database NitinDB Modify Name = MyDB

--sp_renameDB stored procedure
sp_renameDB 'MyDB', 'NitinDB'

--Deleting a Database
--Database should not be in use.
Drop Database NitinDB

--Switch Database to Single_User mode OR Multi_User
Alter Database NitinDB Set MULTI_USER WITH Rollback Immediate
Alter Database NitinDB Set SINGLE_USER WITH Rollback Immediate

--With Rollback Immediate option, will rollback all incomplete transactions and close the connection to the database.
--System Databases cannot be dropped.

--Creating Tables
Use [NitinDB]
Go

--tblPerson
Create Table tblPerson(
ID int Not Null Primary Key,
Name nvarchar(50) Not Null,
Email nvarchar(50) Not Null,
GenderID int
)

--tblGender
Create Table tblGender(
ID int Not Null Primary Key,
Gender nvarchar(50) Not Null
)

--Adding Foreign Key
Alter Table tblPerson add constraint tblPerson_GenderID_FK
Foreign Key (GenderId) references tblGender(ID)

--Foreign Keys are used to enforce database Integrity.
--A Foreign key in one table points to a Primary Key in another table.
--It prevents invalid data form being inserted into the foreign key column.
--The values that you enter into the foreign key column, has to be one of the values contained in the table it points to.

--Insert Query
Insert into tblPerson(ID, Name, Email) values(7,  'Gaurav', 'gaurav@gamil.com')

--Default Constraint

--Altering an existing column to add default column
Alter Table tblPerson 
add constraint tblPerson_GenderID_Default 
Default 3 for GenderID

--Adding new column, with default va;ue, to an existing table
--Alter table tblPerson
--add {Column_Name} {Data_type} {Null | Not Null}
--Constraint {Constraint_Name} Default {Default_value}

--Dropping a Constraint
Alter table tblPerson Drop Constraint tblPerson_GenderID_Default

--Cascading referntial integrity
--Cascading referential integrity constraint allows to define the actions Microsoft SQL Server should take when a user attempts to delete or update a key to which an existing foreign keys points.
--However, you have the following options when setting up Cascading referential integrity constraint
--1. No Action: This is the default behaviour. 
--				No Action specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows in other tables, an error is raised and the DELETE or UPDATE is rolled back.
--2. Cascade: Specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows in other tables, all rows containing those foreign keys are also deleted or updated.
--3. Set NULL: Specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows in other tables, all rows containing those foreign keys are set to NULL.
--Set Default: Specifies that if an attempt is made to delete or update a row with a key referenced by foreign keys in existing rows in other tables, all rows containing those foreign keys are set to default values.

delete from tblGender where ID = 2

select * from tblGender
select * from tblPerson

--Check Constraint
--CHECK constraint is used to limit the range of the values, that can be entered for a column.
--If the BOOLEAN_EXPRESSION returns true, then the CHECK constraint allows the value, otherwise it doesn't. Since, AGE is a nullable column, it's possible to pass null for this column, when inserting a row.
--When you pass NULL for the AGE column, the boolean expression evaluates to UNKNOWN, and allows the value.
ALTER TABLE tblPerson 
ADD CONSTRAINT CK_tblPerson_Age 
CHECK (Age > 0 AND Age <150)

--Drop a Constraint
ALTER TABLE tblPerson 
DROP CONSTRAINT CK_tblPerson_Age

--Adding Column to an existing table
Alter Table tblPerson add Age int

--Identity Column
--If a column is marked as an identity column, then the values for this column are automatically generated, when you insert a new row into the table. 
-- if you mark a column as an Identity column, you dont have to explicitly supply a value for that column when you insert a new row.
--The value is automatically calculated and provided by SQL server. So, to insert a row into tblPerson table, just provide value for Name column.


INSERT INTO tblNewPerson values('Nitin'),('Suraj'),('Ankit');

--An explicit value for the identity column in table 'tblPerson' can only be specified when a column list is used and IDENTITY_INSERT is ON. 
SET IDENTITY_INSERT tblNewPerson ON
SET IDENTITY_INSERT tblNewPerson OFF
Truncate table tblNewPerson

INSERT INTO tblNewPerson values('Amit');
Select * from tblNewPerson

--Reset the identity column
DBCC CHECKIDENT(tblNewPerson, RESEED, 1)

Insert into TEST1 values('X')




