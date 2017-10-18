/*
	*** CONDITIONS ***

 For each continent, display the total area and total population of all its countries.
 Sort the results by population from highest to lowest. 
 Submit your query statement as Prepare DB & run queries in Judge.

*/

USE Geography;

 SELECT cn.ContinentName,
		SUM(CAST(cu.AreaInSqKm AS DECIMAL)) AS [CountriesArea],
		SUM(CAST(cu.Population AS BIGINT)) AS [CountriesPopulation] 
FROM Countries AS cu
JOIN Continents AS cn ON cn.ContinentCode = cu.ContinentCode
GROUP BY cn.ContinentName
ORDER BY [CountriesPopulation] DESC