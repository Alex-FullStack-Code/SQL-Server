USE [Geography]



-----------------------------12
  SELECT [mc].[CountryCode],
         [m].[MountainRange],
	     [p].[PeakName],
	     [p].[Elevation]
    FROM [Mountains]
      AS [m]
	JOIN [Peaks]
	  AS [p]
	  ON [p].[MountainId] = [m].[Id]
    JOIN [MountainsCountries]
	  AS [mc]
	  ON [m].[Id] = [mc].[MountainId]
   WHERE [p].[Elevation] > 2835 AND [mc].[CountryCode] = 'BG'
ORDER BY [p].[Elevation] DESC



SELECT * FROM MountainsCountries

-----------------------------13
  SELECT [CountryCode],
   COUNT([MountainId])
   	  AS [MountaintRange]
    FROM [MountainsCountries]
   WHERE [CountryCode] IN (
					    	SELECT [CountryCode] FROM [Countries]
					    	WHERE [CountryName] IN ('Bulgaria', 'United States', 'Russia')
					       )
GROUP BY [CountryCode]
						
						



SELECT [CountryCode] FROM [Countries]
WHERE [CountryName] IN ('Bulgaria', 'United States', 'Russia')

-----------------------------14


SELECT TOP(5) [c].[CountryName],
			  [r].[RiverName]
         FROM [Countries]
	       AS [c]
	LEFT JOIN [CountriesRivers]
		   AS [cr]
		   ON [c].[CountryCode] = [cr].[CountryCode]
    LEFT JOIN [Rivers]
		   AS [r]
		   ON [cr].[RiverId] = [r].[Id]
		WHERE [c].[ContinentCode] = 'AF'
	 ORDER BY [c].[CountryName] ASC

-----------------------------16
SELECT COUNT(*) 
	 FROM [Countries]
		AS[c]
LEFT JOIN [MountainsCountries]
	   AS [mc]
	   ON [c].[CountryCode] = [mc].[CountryCode]
	WHERE [mc].[CountryCode] IS NULL

-----------------------------17
SELECT *
FROM [Countries]
AS [c]

