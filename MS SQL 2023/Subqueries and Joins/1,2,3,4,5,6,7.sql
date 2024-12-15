USE [SoftUni]
---------------------1
SELECT TOP(5)  [e].[EmployeeID],
		[e].[JobTitle],
		[e].[AddressID],
		[a].[AddressText]
	FROM [Employees]
	AS [e]
	LEFT JOIN [Addresses]
	AS [a]
	ON [e].[AddressID] = [a].[AddressID]
	ORDER BY [e].[AddressID] ASC

--------------2

SELECT TOP(50) [e].[FirstName], 
       		   [e].[LastName],
       		   [t].[Name]
            AS [Towns],
       	       [a].[AddressText]
       	  FROM [Employees]
       	    AS [e]
          JOIN [Addresses]
       	    AS [a]
       	    ON [a].[AddressID] = [e].[AddressID]
          JOIN [Towns]
       	    AS [t]
       	    ON [t].[TownID] = [a].[TownID]
      ORDER BY [FirstName] ASC, [LastName]

----------------------- 3

  SELECT [e].[EmployeeID],
	     [e].[FirstName],
		 [e].[LastName],
		 [d].[Name]
	  AS [DepartmentName]
	FROM [Employees]
	  AS [e]
	JOIN [Departments]
	  AS [d]
	  ON [e].[DepartmentID] = [d].[DepartmentID]
   WHERE [d].[Name] = 'Sales'
ORDER BY [e].[EmployeeID] ASC

----------------------- 4
 SELECT TOP(5) 
            [e].[EmployeeID],
			[e].[FirstName],
			[e].[Salary],
			[d].[Name]
		 AS [DepartmentName]
       FROM [Employees]
         AS [e]
	   JOIN [Departments]
		 AS [d]
		 ON [e].DepartmentID = [d].[DepartmentID]
	  WHERE [e].[Salary] > 15000
   ORDER BY [e].[DepartmentID] ASC

----------------------- 5
SELECT TOP (3) 
			[e].[EmployeeID],
			[e].[FirstName]
	   FROM [Employees]
		 AS [e]
  LEFT JOIN [EmployeesProjects]
		 AS [ep]
	     ON [e].[EmployeeID] = [ep].[EmployeeID]
	  WHERE [ep].[ProjectID] IS NULL
   ORDER BY [e].[EmployeeID] ASC

----------------------- 6
    SELECT [e].[FirstName],
    	   [e].[LastName],
    	   [e].[HireDate],
    	   [d].[Name]
    	AS [DeptName]
      FROM [Employees]
        AS [e]
 LEFT JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
WHERE YEAR([e].HireDate) >1999-1-1 AND [d].[Name] IN ('Finance', 'Sales')
  ORDER BY [e].[HireDate] ASC

----------------------- 7
    SELECT * 
	FROM [Employees]