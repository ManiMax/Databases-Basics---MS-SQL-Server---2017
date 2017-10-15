-- *** ----------------------------------------------------------------------------------

USE Bakery;

-- *** ----------------------------------------------------------------------------------
SELECT cs.[CountryName], cs.[DistributorName] 
FROM
(
	SELECT c.[Name] AS [CountryName],
	   d.[Name] AS [DistributorName], 
	   COUNT(i.[Id]) AS [IngredientsCount],
	   RANK() OVER
			  (
				PARTITION BY c.[Name] ORDER BY COUNT(i.[Id]) DESC
			  ) AS [DistributorRank]
	FROM Distributors AS d
	LEFT JOIN Countries AS c ON c.[Id] = d.[Id]
	LEFT JOIN Ingredients AS i ON i.[DistributorId] = d.[Id]
	GROUP BY d.[Name], c.[Name]
) AS cs
WHERE cs.[DistributorRank] = 1
ORDER BY cs.[CountryName], cs.[DistributorName];



SELECT CountryName, DistributorName
FROM (
  SELECT 
    co.Name AS CountryName, d.Name AS DistributorName, 
    COUNT(i.Id) AS IngredientsCount,
    DENSE_RANK() OVER (PARTITION BY co.Name ORDER BY COUNT(i.Id) DESC) AS DistributorRank 
  FROM Countries AS co
  JOIN Distributors AS d ON d.CountryId = co.Id
  JOIN Ingredients AS i ON i.DistributorId = d.Id
  GROUP BY d.Name, co.Name
) AS CountryDistributorStats
WHERE DistributorRank = 1
ORDER BY CountryName, DistributorName;

-- *** ----------------------------------------------------------------------------------
