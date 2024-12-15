USE [SoftUni]

---- Problem 1
SELECT [FirstName],
		[LastName]
	FROM [Employees]
	WHERE [FirstName] LIKE 'SA%'

---- Problem 2
SELECT [FirstName],
		[LastName]
	FROM [Employees]
	WHERE [LastName] LIKE '%ei%'

---- Problem 3
SELECT [FirstName]
	FROM [Employees]
	WHERE [DepartmentID] IN (3,10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005

---- Problem 4
SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE [JobTitle] NOT LIKE '%engineer%'

---- Problem 5
SELECT [Name] 
	FROM [Towns]
	WHERE LEN([Name]) IN (5,6)
	ORDER BY [Name] ASC

---- Problem 6
----Method 1
SELECT [TownID], [Name]
	FROM [Towns]
	WHERE LEFT([Name], 1) IN  ('K', 'M', 'B', 'E')
	ORDER BY [Name]
----Method 2
	SELECT [TownID], [Name]
	FROM [Towns]
	WHERE [Name] LIKE  '[MKBE]%'
	ORDER BY [Name]

---- Problem 7
----Method 1
SELECT [TownID], [Name] 
	FROM [Towns]
	WHERE [Name] NOT LIKE '[RBD]%'
	ORDER BY [Name]

	
---- Problem 8
CREATE VIEW  [V_EmployeesHiredAfter2000]
	AS SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE DATEPART(YEAR, [HireDate]) > 2000

---- Problem 9
SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE LEN([LastName]) = 5

---- Problem 10
SELECT [EmployeeID],
	   [FirstName],
	   [LastName],
	   [Salary],
	   DENSE_RANK() OVER(PARTITION BY [Salary]  ORDER BY [EmployeeID]) 
	   AS [RANK]
  FROM [Employees]
  WHERE [Salary] BETWEEN 10000 AND 50000
  ORDER BY [Salary] DESC

---- Problem 11
SELECT * 
	FROM 
	(	
	SELECT [EmployeeID],
	   [FirstName],
	   [LastName],
	   [Salary],
	   DENSE_RANK() OVER(PARTITION BY [Salary]  ORDER BY [EmployeeID]) 
	   AS [RANK]
  FROM [Employees]
  WHERE [Salary] BETWEEN 10000 AND 50000
	) AS [RankingSubquery]
	WHERE [Rank] = 2
	ORDER BY [Salary] DESC



	USE [Geography]

	GO
---- Problem 12
	SELECT [CountryName]
		AS [Country Name], 
		   [ISOCode]
		AS [ISO Code]
	  FROM [Countries]
	 WHERE [CountryName] LIKE '%a%a%a%'
	ORDER BY [ISO Code]

---- Problem 13

SELECT [p].[PeakName],
       [r].[RiverName],
	   LOWER(CONCAT(SUBSTRING([p].[PeakName], 1, LEN([p].[PeakName]) - 1),[r].[RiverName]))
	   AS[Mix]
  FROM [Peaks]
    AS [p],
	   [Rivers]
	AS [r]
	WHERE RIGHT(LOWER([p].[PeakName]), 1) = LEFT(LOWER([r]. [RiverName]),1)
	ORDER BY [Mix]

---- Problem 14
	USE [Diablo]

	SELECT TOP(50)
		   [Name], 
    FORMAT([Start], 'yyyy-MM-dd') AS [Start]
      FROM [Games]
	 WHERE YEAR([Start]) IN (2011, 2012)
	 ORDER BY [Start], [Name]

---- Problem 15
SELECT [Username],
	   SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])- CHARINDEX('@', [Email]))
	   AS [Email Provider]
	   FROM [Users]
	   ORDER BY [Email Provider], [Username] 

---- Problem 16
SELECT [Username],[IpAddress]
	   FROM [Users]
	   WHERE [IpAddress] LIKE '___.1%.%.___'
	   ORDER BY [Username]
