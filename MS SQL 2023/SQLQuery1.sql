SELECT [FirstName], [LastName], [Salary] FROM [Employees]
	WHERE [Salary] > 50000
	ORDER BY [Salary] DESC

SELECT TOP 5 [FirstName], [LastName] FROM Employees
	ORDER BY [Salary] DESC


SELECT [FirstName], [LastName] FROM Employees
	WHERE [DepartmentID] != 4

	SELECT * FROM [Employees]
	ORDER BY [Salary] DESC, [FirstName] ASC, [LastName] DESC, [MiddleName] ASC

SELECT * FROM [Employees]