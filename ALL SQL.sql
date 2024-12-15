
-- is usible for .NET & .NET Core 1.1
-- prevent sql injection using parameterized query
-- https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlparametercollection.addwithvalue?view=dotnet-plat-ext-5.0

-- 2020 Using Parameters for SQL Server Queries and Stored Procedures 
-- https://www.mssqltips.com/sqlservertip/2981/using-parameters-for-sql-server-queries-and-stored-procedures/


-- Working With the SqlParameter Class in ADO.NET
-- https://www.c-sharpcorner.com/UploadFile/718fc8/working-with-sqlparameter-class-in-ado-net/


-- connect ADO.NET code to SQL Server Database and retrieve data?
-- https://www.infinetsoft.com/Post/How-to-connect-ADO-NET-code-to-SQL-Server-Database-and-retrieve-data/1172#.YFRRi9yxWUk


-- Command and Query Responsibility Segregation (CQRS) pattern
-- The Command and Query Responsibility Segregation (CQRS) pattern separates READ and UPDATE OPERATIONS 
-- for a Data Store. Implementing CQRS in your application can maximize its performance, scalability, and security. 
-- The flexibility created by migrating to CQRS allows a system to better evolve over time and prevents 
-- update commands from causing merge conflicts at the domain level.
-- https://docs.microsoft.com/en-us/azure/architecture/patterns/cqrs

-- ALL SQL https://www.tutorialspoint.com/sql/sql-data-types.htm
-- Data Definition & Data types
 
CREATE TABLE products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL 
);

use BikeStores;

SET IDENTITY_INSERT products ON;

INSERT INTO products(product_id, product_name, brand_id, category_id, model_year, list_price) 
VALUES(1,'Trek 820 - 2016',9,6,2016,379.99)

---------------------------------------------------------------------

EXEC sp_who

---------------------------------------------------------------------

USE TelerikAcademy
GO

DECLARE @table VARCHAR(50) = 'Projects'
DECLARE @query VARCHAR(50) = 'SELECT * FROM ' + @table;
EXEC(@query)

---------------------------------------------------------------------

USE TelerikAcademy

DECLARE @EmpID varchar(11), @LastName char(20)
SET @LastName = 'King'

SELECT @EmpID = EmployeeId 
 FROM  Employees
 WHERE LastName = @LastName
 
SELECT @EmpID AS EmployeeID 

---------------------------------------------------------------------

SELECT AVG(Salary) AS AvgSalary
FROM Employees

---------------------------------------------------------------------

SELECT DB_NAME() AS [Active Database]

---------------------------------------------------------------------

SELECT 
  DATEDIFF(Year, HireDate, GETDATE()) * Salary / 1000
  AS [Annual Bonus]
FROM Employees

---------------------------------------------------------------------

IF ((SELECT COUNT(*) FROM Employees) >= 100)
BEGIN
  PRINT 'Employees are at least 100'
END

---------------------------------------------------------------------

IF ((SELECT COUNT(*) FROM Employees) >= 100)
  BEGIN
    PRINT 'Employees are at least 100'
  END
ELSE
  BEGIN
    PRINT 'Employees are less than 100'
  END

---------------------------------------------------------------------

DECLARE @n int = 10

PRINT 'The numbers from 10 down to 1 are:'
WHILE (@n > 0)
  BEGIN
    PRINT @n
    SET @n = @n - 1
  END

  ---------------------------------------------------------------------

DECLARE @n int = 10
PRINT 'Calculating factoriel of ' + 
  CAST(@n as varchar) + ' ...'

DECLARE @factorial numeric(38) = 1
WHILE (@n > 1)
  BEGIN
    SET @factorial = @factorial * @n
    SET @n = @n - 1
  END

PRINT @factorial

---------------------------------------------------------------------

SELECT Salary, [Salary Level] =
  CASE
     WHEN Salary BETWEEN 0 and 9999 THEN 'Low'
     WHEN Salary BETWEEN 10000 and 30000 THEN 'Average'
     WHEN Salary > 30000 THEN 'High'
     ELSE 'Unknown'
  END
FROM Employees

---------------------------------------------------------------------

DECLARE @n tinyint
SET @n = 5
IF (@n BETWEEN 4 and 6)
 BEGIN
  WHILE (@n > 0)
   BEGIN
    SELECT @n AS 'Number',
	  CASE
        WHEN (@n % 2) = 1
          THEN 'EVEN'
        ELSE 'ODD'
       END AS 'Type'
    SET @n = @n - 1
   END
 END
ELSE
 PRINT 'NO ANALYSIS'
GO

---------------------------------------------------------------------

USE TelerikAcademy
GO

CREATE PROC usp_SelectSeniorEmployees
AS
  SELECT * 
   FROM Employees
   WHERE DATEDIFF(Year, HireDate, GETDATE()) > 5
GO

---------------------------------------------------------------------

EXEC usp_SelectSeniorEmployees

---------------------------------------------------------------------

ALTER PROC usp_SelectSeniorEmployees
AS
  SELECT FirstName, LastName, HireDate, 
    DATEDIFF(Year, HireDate, GETDATE()) as Years
  FROM Employees
  WHERE DATEDIFF(Year, HireDate, GETDATE()) > 5
  ORDER BY HireDate
GO

EXEC usp_SelectSeniorEmployees

---------------------------------------------------------------------

EXEC sp_depends 'usp_SelectSeniorEmployees'

---------------------------------------------------------------------

DROP PROC usp_SelectSeniorEmployees

---------------------------------------------------------------------

CREATE PROC usp_SelectEmployeesBySeniority(
  @minYearsAtWork int = 5)
AS
  SELECT FirstName, LastName, HireDate, 
    DATEDIFF(Year, HireDate, GETDATE()) as Years
  FROM Employees
  WHERE DATEDIFF(Year, HireDate, GETDATE()) >
    @minYearsAtWork
  ORDER BY HireDate
GO

EXEC usp_SelectEmployeesBySeniority 10

EXEC usp_SelectEmployeesBySeniority

---------------------------------------------------------------------

CREATE PROCEDURE dbo.usp_AddNumbers
   @firstNumber smallint,
   @secondNumber smallint,
   @result int OUTPUT
AS
   SET @result = @firstNumber + @secondNumber
GO

DECLARE @answer smallint
EXECUTE usp_AddNumbers 5, 6, @answer OUTPUT
SELECT 'The result is: ', @answer

---------------------------------------------------------------------

CREATE PROC usp_NewEmployee(
  @firstName nvarchar(50), @lastName nvarchar(50),
  @jobTitle nvarchar(50), @deptId int, @salary money)
AS
  INSERT INTO Employees(FirstName, LastName, 
    JobTitle, DepartmentID, HireDate, Salary)
  VALUES (@firstName, @lastName, @jobTitle, @deptId,
    GETDATE(), @salary)
  RETURN SCOPE_IDENTITY()
GO

DECLARE @newEmployeeId int
EXEC @newEmployeeId = usp_NewEmployee
  @firstName='Steve', @lastName='Jobs', @jobTitle='Trainee',
  @deptId=1, @salary=7500
  
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeId = @newEmployeeId

---------------------------------------------------------------------

CREATE TRIGGER tr_TownsUpdate ON Towns FOR UPDATE
AS
  IF (EXISTS(SELECT * FROM inserted WHERE Name IS NULL) OR
      EXISTS(SELECT * FROM inserted WHERE LEN(Name) = 0))
    BEGIN
      RAISERROR('Town name cannot be empty.', 16, 1)
      ROLLBACK TRAN
      RETURN
    END
GO

UPDATE Towns SET Name='Sofia' WHERE TownId=1

UPDATE Towns SET Name='' WHERE TownId=1

UPDATE Towns SET Name=''

UPDATE Towns SET Name=NULL

---------------------------------------------------------------------

CREATE TABLE Accounts(
  Username varchar(10) NOT NULL PRIMARY KEY,
  [Password] varchar(20) NOT NULL,
  Active CHAR NOT NULL DEFAULT 'Y' )
GO
  
CREATE VIEW V_Active_Accounts AS
  SELECT * FROM Accounts WHERE Active = 'Y'
GO  

CREATE TRIGGER tr_AccountsDelete ON Accounts INSTEAD OF DELETE
AS
  UPDATE a SET Active = 'N'
  FROM Accounts a JOIN DELETED d 
    ON d.Username = a.Username
  WHERE a.Active = 'Y'  
GO

INSERT INTO Accounts(Username, Password)
VALUES ('pesho', 'qwerty123')

INSERT INTO Accounts(Username, Password)
VALUES ('kiro', 'secret!')

SELECT * FROM V_Active_Accounts

DELETE FROM Accounts WHERE Username='kiro'

SELECT * FROM V_Active_Accounts

SELECT * FROM Accounts

---------------------------------------------------------------------

CREATE FUNCTION ufn_CalcBonus(@salary money)
  RETURNS money
AS
BEGIN
  IF (@salary < 10000)
    RETURN 1000
  ELSE IF (@salary BETWEEN 10000 and 30000)
    RETURN @salary / 20
  RETURN 3500
END
GO

SELECT Salary, dbo.ufn_CalcBonus(Salary) as Bonus
FROM Employees

---------------------------------------------------------------------

USE Northwind
GO

CREATE FUNCTION fn_CustomerNamesInRegion
  ( @regionParameter nvarchar(30) )
RETURNS TABLE
AS
RETURN (
  SELECT CustomerID, CompanyName
  FROM Northwind.dbo.Customers
  WHERE Region = @regionParameter
)
GO

SELECT * FROM fn_CustomerNamesInRegion(N'WA')

---------------------------------------------------------------------

CREATE FUNCTION fn_ListEmployees(@format nvarchar(5))
RETURNS @tbl_Employees TABLE
  (EmployeeID int PRIMARY KEY NOT NULL,
  [Employee Name] Nvarchar(61) NOT NULL)
AS
BEGIN
  IF @format = 'short'
    INSERT @tbl_Employees
    SELECT EmployeeID, LastName FROM Employees
  ELSE IF @format = 'long'
    INSERT @tbl_Employees SELECT EmployeeID,
    (FirstName + ' ' + LastName) FROM Employees
  RETURN
END
GO

SELECT * FROM fn_ListEmployees('short')

SELECT * FROM fn_ListEmployees('long')

---------------------------------------------------------------------

DECLARE empCursor CURSOR READ_ONLY FOR
  SELECT FirstName, LastName FROM Employees

OPEN empCursor
DECLARE @firstName char(50), @lastName char(50)
FETCH NEXT FROM empCursor INTO @firstName, @lastName

WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT @firstName + ' ' + @lastName
    FETCH NEXT FROM empCursor 
    INTO @firstName, @lastName
  END

CLOSE empCursor
DEALLOCATE empCursor
---------------------------------------------------------------------
/* SQL Server Identity
https://www.sqlservertutorial.net/sql-server-basics/sql-server-identity/

identity(1,1)
the first 1 means the starting value of ID and 
the second 1 means the increment value of ID. 
It will increment like 1,2,3,4.. 

If it was (5,2), then, 
it starts from 5 and increment by 2 like, 5,7,9,11,...

What is the difference 
between 
Identity & Auto-Increment command? 

Both performs the same operations but 
Identity is used in Sql-Server 
whereas 
Auto-Increment is used in MySql


*/
CREATE TABLE Student (
	StudentId INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL, 
	LASTNAME VARCHAR(50) NOT NULL, 
	EMAIL VARCHAR(50) NOT NULL, 
	PHONE VARCHAR(50) NOT NULL,
	Gender CHAR(1) NOT NULL
)

CREATE TABLE Course (
	StudentID INT,
	CourseID INT,
	PRIMARY KEY (StudentID, CourseID), 
)

CREATE TABLE StudentCourse (
	StudentID INT,
	CourseID INT,
	PRIMARY KEY (StudentID, CourseID),
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
)

---------------------------------------------------------------------
/* Clustered Index
   Learn Here:

 https://www.sqlservertutorial.net/sql-server-indexes/sql-server-clustered-indexes/

 A clustered index stores data rows in a sorted structure 
 based on its key values. Each table has only 1 clustered index 
 because data rows can be only sorted in 1 order. 
 A table that has a clustered index is called a clustered table.
 
 A clustered index, organizes data 
 using a special structured so-called B-tree (or balanced tree) 
 which enables searches, inserts, updates and deletes in 
 logarithmic amortized time. - амоортайзд тайм.

Клъстерирани индекси 
https://www.tutorialsteacher.com/sqlserver/indexes

CREATE CLUSTERED INDEX <index_name>
ON [schema.]<table_name>(column_name [asc|desc]);
 
CREATE CLUSTERED INDEX CIX_EmpDetails_EmpId
ON dbo.EmployeeDetails(EmployeeID)


Неклъстерирани индекси
https://www.tutorialsteacher.com/sqlserver/nonclustered-index

*/

CREATE NONCLUSTERED INDEX <index_name>
ON <table_name>(column)
 
CREATE NONCLUSTERED INDEX NCI_Employee_Email
ON dbo.Employee(Email);

 

ACID - Translate BG
https://www.databricks.com/glossary/acid-transactions
 
 

---------------------------------------------------------------------
-- # 1. List the teachers who have NULL for their department.
SELECT name
  FROM teacher
 WHERE dept IS NULL;

-- # 3. Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name
FROM teacher
LEFT OUTER JOIN dept
ON teacher.dept = dept.id;

-- # 4. Use a different JOIN so that all departments are listed.
SELECT teacher.name, dept.name
FROM teacher
RIGHT OUTER JOIN dept
ON teacher.dept = dept.id;

-- # 5. Use COALESCE to print the mobile number. Use the number '07986
-- #444 2266' there is no number given. Show teacher name and mobile
-- #number or '07986 444 2266'
SELECT name, COALESCE(mobile, '07986 444 2266')
  FROM teacher;

-- # 6. Use the COALESCE function and a LEFT JOIN to print the name and
-- #department name. Use the string 'None' where there is no
-- #department.
SELECT name, COALESCE(dept, 'None')
  FROM teacher;

-- # 7. Use COUNT to show the number of teachers and the number of
-- #mobile phones.
SELECT COUNT(name), COUNT(mobile)
  FROM teacher;

-- # 8. Use COUNT and GROUP BY dept.name to show each department and
-- #the number of staff. Use a RIGHT JOIN to ensure that the
-- #Engineering department is listed.
SELECT dept.name ,COUNT(teacher.name)
FROM teacher
RIGHT OUTER JOIN dept
ON teacher.dept = dept.id
GROUP BY dept.name;

-- #9: Use CASE to show the name of each teacher followed by 'Sci' if
-- #the the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT teacher.name, 
  CASE
  WHEN teacher.dept IN (1, 2)
  THEN 'Sci'
  ELSE 'Art'
  END
FROM teacher;

-- #10: Use CASE to show the name of each teacher followed by 'Sci' if
-- #the the teacher is in dept 1 or 2 show 'Art' if the dept is 3 and
-- #'None' otherwise.
SELECT teacher.name, 
  CASE
  WHEN teacher.dept IN (1, 2)
  THEN 'Sci'
  WHEN teacher.dept = 3
  THEN 'Art'
  ELSE 'None'
  END
FROM teacher;


---------------------------------------------------------------------
 
 
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE
         PRINT "We are at isolation level 4."
         COMMIT WORK
END TRANSACTION
PRINT "We are at isolation level 3"

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
GO
SELECT EmpID, EmpName, EmpSalary
FROM dbo.TestIsolationLevels
WHERE EmpID = 2900

---------------------------------------------------------------------



---------------------------------------------------------------------




































































































