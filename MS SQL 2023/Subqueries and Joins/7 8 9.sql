USE SoftUni
-------------------- 7
SELECT TOP (5)
			[e].[EmployeeID],
			[e].[FirstName],
			[p].[Name]
		 AS [ProjectName]
       FROM [EmployeesProjects]
         AS [ep]
       JOIN [Projects]
         AS [p]
         ON [p].[ProjectID] = [ep].[ProjectID]
       JOIN [Employees]
         AS [e]
         ON [e].[EmployeeID] = [ep].[EmployeeID]
      WHERE [p].[StartDate] > '2002-08-13' AND [p].[EndDate] IS NULL
   ORDER BY [e].[EmployeeID] ASC

-------------------- 8

  SELECT [e].[EmployeeID],
         [e].[FirstName],
           CASE 
               WHEN YEAR([p].[StartDate]) >= 2005 THEN NULL
               ELSE [p].[Name]
           END
    FROM [EmployeesProjects]
      AS [ep]
    JOIN [Projects]
      AS [p]
      ON [p].[ProjectID] = [ep].[ProjectID]
    JOIN [Employees]
      AS [e]
      ON [e].[EmployeeID] = [ep].[EmployeeID]
   WHERE [ep].[EmployeeID] = 24

-------------------- 9
   SELECT [e].[EmployeeID],
   	      [e].[FirstName],
   	      [e].[ManagerID],
   	      [m].[FirstName]
       AS [ManagerName]
     FROM [Employees]
       AS [e]
     JOIN [Employees] 
       AS [m]
       ON [e].[ManagerID] = [m].[EmployeeID]
    WHERE [e].[ManagerID] IN (3, 7)
 ORDER BY [e].[EmployeeID] ASC


 SELECT * FROM Employees
 WHERE [ManagerID] IN (3,7)

 SELECT * FROM Employees
 WHERE [EmployeeID] IN (3,7)