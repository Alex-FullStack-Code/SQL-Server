
------7
SELECT [Number], [Currency] FROM Invoices
ORDER BY [Amount] DESC , [DueDate] ASC

--------6
SELECT [p].Id,
p.[Name],
p.Price,
c.[Name]
FROM [Products]
AS [p]
JOIN [Categories]
AS [c]
ON [c].Id = [p].[CategoryId]
WHERE [c].[Name] IN ('ADR', 'Others')
ORDER BY [p].Price DESC

--------7
SELECT * FROM Products

SELECT c.Id,
       c.[Name],
	   CONCAT (a.StreetName, ' ' , a.StreetNumber, ', ', a.City, ', ', a.PostCode, ', ', co.[Name])
FROM Clients AS c
LEFT JOIN ProductsClients
AS p
ON c.Id = p.ClientId
JOIN [Addresses] 
AS a
ON c.AddressId = a.Id
JOIN [Countries] 
AS co
ON a.CountryId = co.Id
WHERE p.ProductId IS NULL
ORDER BY c.[Name] ASC

--------8





SELECT * FROM ProductsClients