USE Geography;
GO

--- 12. Highest Peaks in Bulgaria ---
  SELECT mc.CountryCode,
         m.MountainRange,
	     p.PeakName,
	     p.Elevation 
    FROM MountainsCountries AS mc
    JOIN Mountains AS m ON m.Id = mc.MountainId
    JOIN Peaks AS p ON p.MountainId = m.Id
   WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC;
GO

--- 13. Count Mountain Ranges ---
  SELECT mc.CountryCode,
         COUNT(mc.MountainId) AS [MountainRanges]
    FROM MountainsCountries AS mc
   WHERE mc.CountryCode IN('BG','RU','US')
GROUP BY mc.CountryCode;
GO

--- 14. Countries With or Without Rivers ---
SELECT TOP(5) 
	c.CountryName, 
	r.RiverName 
FROM CountriesRivers AS cr
	RIGHT OUTER JOIN Countries AS c 
		ON c.CountryCode = cr.CountryCode
	LEFT OUTER JOIN Rivers AS r 
		ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName;
GO

--- 15. *Continents and Currencies ---
--- Find all continents and their most used currency. 
--- Filter any currency that is used in only one country.
--- Sort your results by ContinentCode.
SELECT ContinentCode, CurrencyCode, CurrencyUsage FROM
(
	SELECT ContinentCode, CurrencyCode, CurrencyUsage,
	RANK() OVER(PARTITION BY(ContinentCode) ORDER BY CurrencyUsage DESC) AS Ranking
	FROM
	(
		SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS CurrencyUsage 
	    FROM Countries
		GROUP BY CurrencyCode, ContinentCode
		HAVING COUNT(CurrencyCode) > 1
	) AS Currencies
) AS Result
WHERE Ranking = 1 /*AND CurrencyUsage > 1*/;
GO


--- 16. Countries Without any Mountains ---
SELECT COUNT(CountryCode) FROM Countries
WHERE CountryCode NOT IN
(
	SELECT CountryCode FROM MountainsCountries
);
GO

--- 17. Highest Peak and Longest River by Country ---
SELECT TOP(5) 
	   CountryName, 
	   [HighestPeakElevation], 
	   [LongestRiverLength] 
  FROM Countries AS c
  JOIN
  (
  	SELECT p.CountryCode, 
  	 	   p.Elevation AS [HighestPeakElevation], 
  	 	   r.Length AS [LongestRiverLength] 
  	 FROM 
  	 (
  	 	SELECT mc.CountryCode, 
  	 		   p.Elevation ,
  	 		   RANK() 
  	 		   OVER
  	 		   (
  	 		   		PARTITION BY(mc.CountryCode) 
  	 		   		ORDER BY p.Elevation DESC
  	 		   ) AS HighestPeakElevation
  	 	  FROM Peaks AS p
  	           JOIN MountainsCountries AS mc 
  	 	    ON mc.MountainId = p.MountainId
  	 ) AS p
  	 JOIN
  	 (
  	 	SELECT cr.CountryCode,
  	 		   r.Length,
  	 		   RANK() 
  	 		   OVER
  	 		   (
  	 		   		PARTITION BY(cr.CountryCode)
  	 		   		ORDER BY r.Length DESC
  	 		   ) AS LongestRiverLength
  	 	  FROM CountriesRivers AS cr
  	 		   JOIN Rivers AS r
  	 		   ON r.Id = cr.RiverId
  	 ) AS r ON r.CountryCode = p.CountryCode
  	 WHERE p.HighestPeakElevation = 1 AND r.LongestRiverLength = 1
  ) AS cr ON cr.CountryCode = c.CountryCode
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, CountryName;
GO

--- 18. *Highest Peak Name and Elevation by Country ---
SELECT TOP(5)
	   [Country],
	   IIF([Highest Peak Name] IS NULL, '(no highest peak)', [Highest Peak Name]),
	   IIF(MAX([Highest Peak Elevation]) IS NULL, '0', MAX([Highest Peak Elevation])),
	   IIF([Mountain] IS NULL, '(no mountain)', [Mountain])
FROM
(
	SELECT c.CountryName AS [Country],
		   p.PeakName AS [Highest Peak Name],
		   p.Elevation AS [Highest Peak Elevation],
		   m.MountainRange AS [Mountain] 
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
	LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
) AS r
GROUP BY [Country], [Highest Peak Name], [Mountain]
ORDER BY [Country], [Highest Peak Name];
GO