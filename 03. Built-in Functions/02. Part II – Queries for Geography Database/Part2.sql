--- Part II – Queries for Geography Database ---
USE Geography
GO

--- 10. Countries Holding 'A' --- 
SELECT CountryName, IsoCode FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode
GO

--- 11. Mix of Peak and River Names ---
SELECT P.PeakName, R.RiverName, 
	   LOWER(CONCAT(P.PeakName, RIGHT(R.RiverName, LEN(R.RiverName) - 1))) AS Mix 
FROM Peaks AS P, Rivers AS R 
WHERE RIGHT(P.PeakName, 1) = LEFT(R.RiverName, 1)
ORDER BY Mix
GO
 