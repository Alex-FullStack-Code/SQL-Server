USE SoftUni
-------1
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS 
SELECT [FirstName], [LastName] FROM Employees
WHERE Salary > 35000

---------2
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18,4))
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary >= @number

---------3
CREATE PROCEDURE usp_GetTownsStartingWith(@string VARCHAR(20))
AS 
SELECT [Name] 
AS Towns 
FROM Towns
WHERE SUBSTRING([Name], 1, LEN(@string)) = @string

---------4

CREATE PROCEDURE usp_GetEmployeesFromTown(@townName VARCHAR(50))
AS
SELECT FirstName, LastName
FROM [Employees]
AS e
JOIN Addresses
AS a
ON a.AddressID = e.AddressID
JOIN Towns
AS t
ON t.TownID = a.TownID
WHERE t.[Name] = @townName

---------5
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @salaryLevel VARCHAR(10)

IF @salary < 30000
BEGIN 
   SET @salaryLevel = 'Low'
END

ELSE IF @salary between 30000 and 50000
BEGIN
	SET @salaryLevel = 'Average'
END

ELSE IF @salary > 50000
BEGIN	
		SET @salaryLevel = 'High'
END

RETURN @salaryLevel
END

---------6
CREATE PROCEDURE usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(10))
AS
BEGIN 
SELECT FirstName, LastName FROM Employees
WHERE [dbo].ufn_GetSalaryLevel(Salary) = @salaryLevel
END
 
---------7
 CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
ReTURNS BIT
 AS
 BEGIN
 

   
    DECLARE @charIndex INT = 1;
    WHILE @charIndex <= LEN(@word)
    BEGIN
        DECLARE @char NVARCHAR(1) = SUBSTRING(@word, @charIndex, 1);

        
        IF CHARINDEX(@char, @setOfLetters) = 0
        BEGIN
            RETuRN 0;
            BREAK;  
        END

        SET @charIndex  += 1;
    END

    RETURN 1;
 END