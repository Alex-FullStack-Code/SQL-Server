Go
USE [SoftUni]
--Problem 02
SELECT * FROM [Departments]


--Problem 03
SELECT [Name] FROM [Departments]

--Problem 04
SELECT [FirstName], [LastName], [Salary] FROM [Employees]

--Problem 05
SELECT [FirstName], [MiddleName], [LastName] FROM [Employees]

--Problem 06
SELECT CONCAT ([FirstName], '.', [LastName] , '@' , 'softuni.bg')
	AS [Full Email Address]
	FROM [Employees]

--Problem 07
SELECT DISTINCT [Salary] FROM [Employees]

--Problem 08
SELECT *  FROM [Employees]
	WHERE [JobTitle] = 'Sales Representative'

--Problem 09
SELECT [FirstName], [LastName], [JobTitle]  FROM [Employees]
	WHERE [Salary] >= 20000 AND [Salary] <= 30000

--Problem 10
SELECT CONCAT ( [FirstName], ' ', [MiddleName], ' ', [LastName])
	AS [Full Name]
	FROM [Employees]
	WHERE [Salary] = 25000 OR [Salary] = 14000 OR [Salary] = 12500 OR [Salary] = 23600

--Problem 11
SELECT [FirstName], [LastName] FROM [Employees]
	WHERE [ManagerID] IS NULL

--Problem 12
SELECT [FirstName], [LastName], [Salary] FROM [Employees]
	WHERE [Salary] > 50000
	ORDER BY [Salary] DESC

--Problem 13
SELECT TOP 5 [FirstName], [LastName] FROM Employees
	ORDER BY [Salary] DESC

--Problem 14
SELECT [FirstName], [LastName] FROM Employees
	WHERE [DepartmentID] != 4

--Problem 15
	SELECT * FROM [Employees]
	ORDER BY [Salary] DESC, [FirstName] ASC, [LastName] DESC, [MiddleName] ASC

SELECT * FROM [Employees]

