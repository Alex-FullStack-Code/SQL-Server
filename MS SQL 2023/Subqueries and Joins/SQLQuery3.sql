USE [Gringotts]
------------1
SELECT COUNT(*) FROM[WizzardDeposits]

------------2
SELECT TOP(1) 
         [MagicWandSize]
      AS [LongestMagicWand]
    FROM [WizzardDeposits]
ORDER BY [MagicWandSize] DESC



------------3
  SELECT [DepositGroup],
     MAX([MagicWandSize])
	 AS [LongestMagicWand]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

------------4
SELECT TOP (2) [DepositGroup]
          FROM [WizzardDeposits]
      GROUP BY [DepositGroup]
  ORDER BY AVG([MagicWandSize]) 

------------5
  SELECT [DepositGroup],
     SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]
       
------------6
  SELECT [DepositGroup],
     SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]

------------7
    SELECT [DepositGroup],
       SUM([DepositAmount])
        AS [TotalSum]
      FROM [WizzardDeposits]
     WHERE [MagicWandCreator] = 'Ollivander family'
  GROUP BY [DepositGroup]
HAVING Sum([DepositAmount]) < 150000
  ORDER BY [TotalSum] DESC

------------8
 SELECT  [DepositGroup],
         [MagicWandCreator],
     MIN([DepositCharge])
      AS [MIN]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator] ,[DepositGroup]

------------9
SELECT
	  [AgeGroup],
COUNT([AgeGroup]) 
   AS [WizardCount]
FROM
(
	SELECT
		CASE
			WHEN [Age] <= 10 THEN '[0-10]'
			WHEN [Age] > 10 AND [Age] <= 20 THEN '[11-20]'
			WHEN [Age] > 20 AND [Age] <= 30 THEN '[21-30]'
			WHEN [Age] > 30 AND [Age] <= 40 THEN '[31-40]'
			WHEN [Age] > 40 AND [Age] <= 50 THEN '[41-50]'
			WHEN [Age] > 50 AND [Age] <= 60 THEN '[51-60]'
			WHEN [Age] >= 61 THEN '[61+]'
		END 
		AS [AgeGroup]
	  FROM [WizzardDeposits]
) 
AS [a]
GROUP BY [AgeGroup]

------------11
  SELECT [DepositGroup],
		 [IsDepositExpired],
	 AVG([DepositInterest])
	  AS [AverageInterest]
	FROM [WizzardDeposits]
   WHERE [DepositStartDate] >'01-01-1985'
GROUP BY [DepositGroup], [IsDepositExpired]
ORDER BY [DepositGroup] DESC,
         [IsDepositExpired] ASC







SELECT * FROM [WizzardDeposits]