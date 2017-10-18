/*
	*** CONDITIONS ***

Find all peaks along with their mountain 
sorted by elevation (from the highest to the lowest), then by peak name alphabetically. 
Display the peak name, mountain range name and elevation. 
Submit your query statement as Prepare DB & run queries in Judge.

*/

USE Geography;

SELECT  p.PeakName,
		m.MountainRange AS [Mountain],
		p.Elevation		 
FROM Peaks AS p
LEFT JOIN Mountains AS m ON m.Id = p.MountainId
ORDER BY p.Elevation DESC, p.PeakName