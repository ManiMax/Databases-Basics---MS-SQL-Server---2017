/* 
This problem assumes that the previous problem is completed successfully without errors.

 Submit all your query statements at once as Prepare DB & run queries in Judge.
 * Note when you insert the monasteries make sure to specify the country code by  
 the country name (aka use subquery).

------------------------------------------------
	1.Write and execute a SQL command that changes the country named "Myanmar" to its other name "Burma".

*/
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'


/*

	2. Add a new monastery holding the following information: Name="Hanga Abbey", Country="Tanzania".

	3.Add a new monastery holding the following information: Name="Myin-Tin-Daik", Country="Myanmar".

*/
INSERT INTO Monasteries(Name, CountryCode) VALUES
(
	'Hanga Abbey', (SELECT CountryCode FROM Countries WHERE CountryName = 'Tanzania')
)

INSERT INTO Monasteries(Name, CountryCode) VALUES
(
	'Myin-Tin-Daik', (SELECT CountryCode FROM Countries WHERE CountryName = 'Myanmar')
)

/* 
	4. Find the count of monasteries for each continent and not deleted country.
 Display the continent name, the country name and the count of monasteries. 
 Include also the countries with 0 monasteries. 
 Sort the results by monasteries count (from largest to lowest)
 , then by country name alphabetically. 
 Name the columns exactly like in the table below. 

  ContinentName	CountryName		MonasteriesCount
	Asia		Nepal			4
	Europe		Bulgaria		3
	Asia		Burma			2
	Europe		Greece			2

*/
SELECT [ContinentName], [CountryName], [MonasteriesCount]
FROM
(
	SELECT  ct.ContinentName AS [ContinentName],
			c.CountryName AS [CountryName],
			COUNT(m.Id)	AS [MonasteriesCount],
			c.IsDeleted	
	FROM  Countries AS c
	LEFT JOIN Monasteries AS m ON m.CountryCode = c.CountryCode
	LEFT JOIN Continents AS ct ON ct.ContinentCode = c.ContinentCode
	GROUP BY ct.ContinentName, c.CountryName, c.IsDeleted
)AS r 
WHERE r.IsDeleted = 0
ORDER BY [MonasteriesCount] DESC, [CountryName]

-- WORKING SOLUTION TOO
--
--SELECT  ct.ContinentName AS [ContinentName],
--		c.CountryName AS [CountryName],
--		COUNT(m.Id)	AS [MonasteriesCount]
--FROM  Countries AS c
--LEFT JOIN Monasteries AS m ON m.CountryCode = c.CountryCode
--LEFT JOIN Continents AS ct ON ct.ContinentCode = c.ContinentCode
--WHERE c.IsDeleted = 0
--GROUP BY ct.ContinentName, c.CountryName, c.IsDeleted
--ORDER BY [MonasteriesCount] DESC, [CountryName]

