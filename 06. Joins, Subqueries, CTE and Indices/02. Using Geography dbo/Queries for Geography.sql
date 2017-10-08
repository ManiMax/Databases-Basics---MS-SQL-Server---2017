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




