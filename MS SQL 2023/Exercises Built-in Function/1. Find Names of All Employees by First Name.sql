USE [SoftUni]
 
SELECT
	[DepartmentID],
	COUNT (*) AS [Cnt]
FROM [Employees] 
GROUP BY [DepartmentID] 
HAVING COUNT (*) > 8
ORDER BY COUNT (*) DESC


SELECT 
	[DepartmentID],
	AVG ([Salary])
FROM [Employees]
GROUP BY [DepartmentID]
HAVING AVG([Salary]) > 24000