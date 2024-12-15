USE master





DELETE FROM [Invoices] WHERE ClientId = (
SELECT [Id] FROM Clients
WHERE [NumberVAT] LIKE 'IT%')

DELETE FROM ProductsClients WHERE ClientId = (
SELECT [Id] FROM Clients
WHERE [NumberVAT] LIKE 'IT%')

DELETE FROM Clients
WHERE [NumberVAT] LIKE 'IT%'

