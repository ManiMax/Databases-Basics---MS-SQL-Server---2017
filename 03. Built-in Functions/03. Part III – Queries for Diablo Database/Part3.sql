--- Part III – Queries for Diablo Database ---
USE Diablo
GO

--- 12. Games From 2011 and 2012 Year ---
SELECT TOP(50) Name, FORMAT(Start, 'yyyy-MM-dd') AS Start FROM Games
WHERE DATEPART(YEAR, Start) BETWEEN 2011 AND 2012 
ORDER BY Start, Name;
GO

--- 13. User Email Providers ---
SELECT Username, RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username;
GO

--- 14. Get Users with IPAddress Like Pattern ---
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username;
GO

--- 15. Show All Games with Duration ---
-- SELECT * FROM Games
SELECT G.Name AS [Game],
	   CASE 
	        WHEN DATEPART(HOUR, G.Start) >= 0 AND DATEPART(HOUR, G.Start) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, G.Start) >= 12 AND DATEPART(HOUR, G.Start) < 18 THEN 'Afternoon'
			WHEN DATEPART(HOUR, G.Start) >= 18 AND DATEPART(HOUR, G.Start) < 24 THEN 'Evening'
	   END AS [Part of the Day],
	   CASE 
	        WHEN G.Duration <= 3 THEN 'Extra Short'
			WHEN G.Duration BETWEEN 4 AND 6 THEN 'Short'
			WHEN G.Duration > 6 THEN 'Long'
			ELSE 'Extra Long'
	   END AS [Duration]
FROM Games AS G
ORDER BY [Game], [Duration], [Part of the Day];
GO
