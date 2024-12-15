USE master

SELECT *  FROM [Invoices]
WHERE [IssueDate] BETWEEN '2022-11-1' AND '2022-11-30'

UPDATE Invoices SET DueDate = '2023-04-01' WHERE [IssueDate] BETWEEN '2022-11-1' AND '2022-11-30'
UPDATE Clients SET AddressId = 3 WHERE [Name] LIKE '%CO%'

