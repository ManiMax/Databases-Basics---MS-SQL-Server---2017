/*
     *** CONDITIONS ***

	For each country in the database
       , display the number of rivers passing through that country 
       and the total length of these rivers. 
	When a country does not have any river
       , display 0 as rivers count and as total length. 
	Sort the results by rivers count (from largest to smallest)
       , then by total length (from largest to smallest), then by country alphabetically. 
	Submit your query statement as Prepare DB & run queries in Judge.


*/

USE Geography;

SELECT c.CountryName,
		cn.ContinentName,
		ISNULL(COUNT(r.Id), 0) AS [RiversCount],
		ISNULL(SUM(r.Length), 0) AS [TotalLength]
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Continents AS cn ON cn.ContinentCode = c.ContinentCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
GROUP BY c.CountryName, cn.ContinentName
ORDER BY RiversCount DESC, TotalLength DESC, c.CountryName
