/*
     *** CONDITIONS ***

Find all peaks along with their mountain, country and continent. 
When a mountain belongs to multiple countries, display them all. 
Sort the results by peak name alphabetically, then by country name alphabetically. 
Submit your query statement as Prepare DB & run queries in Judge.

*/

USE Geography;

SELECT  p.PeakName,
		m.MountainRange AS [Mountain],
		cou.CountryName,
		con.ContinentName		 
FROM Peaks AS p
JOIN Mountains AS m ON m.Id = p.MountainId
JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
JOIN Countries AS cou ON cou.CountryCode = mc.CountryCode
JOIN Continents AS con ON con.ContinentCode = cou.ContinentCode
ORDER BY p.PeakName, cou.CountryName
