----------8
SELECT TOP(7) i.Number,
i.Amount,
c.[Name]
AS [Name]
FROM [Invoices]
AS [i]
JOIN [Clients]
AS [c]
ON c.Id = i.ClientId
WHERE (i.IssueDate < '2023-01-01' AND i.Currency = 'EUR') OR (i.Amount > 500 AND c.NumberVAT LIKE 'DE%')
ORDER BY i.Number ASC, i.Amount DESC

----------9

SELECT 
c.[Name] AS [Client],
MAX(p.Price) AS [Price],
c.NumberVAT AS [VAT Number]
FROM Clients
AS c
JOIN ProductsClients 
AS pc
ON c.Id = pc.ClientId
JOIN Products
AS p
ON p.Id = pc.ProductId
WHERE c.[Name] NOT LIKE ('%KG')
GROUP BY c.[Name], c.NumberVAT
ORDER BY MAX(p.Price) DESC

----------10




SELECT 
c.[Name]
AS [Client],
FLOOR(AVG(p.Price))
AS [Average Price]
FROM ProductsClients
AS pc
LEFT JOIN Clients 
AS c
ON pc.ClientId = c.Id
JOIN Products
AS p
ON p.Id = pc.ProductId
LEFT JOIN Vendors
AS v
ON v.Id = p.VendorId

WHERE v.[NumberVAT] LIKE '%FR%'
GROUP BY c.[Name]
ORDER BY AVG(p.Price) ASC, c.[Name] DESC