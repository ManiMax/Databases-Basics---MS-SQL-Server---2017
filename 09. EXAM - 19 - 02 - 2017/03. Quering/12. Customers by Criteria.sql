-- *** ----------------------------------------------------------------------------------

USE Bakery;

-- *** ----------------------------------------------------------------------------------

SELECT cu.[FirstName], cu.[Age], cu.[PhoneNumber] 
FROM Customers AS cu
JOIN Countries as co ON co.[Id] = cu.[CountryId]
WHERE cu.[Age] >= 21 
	  AND (cu.[FirstName] LIKE '%an%' OR cu.[PhoneNumber] LIKE '%38')
	  AND co.[Name] NOT LIKE 'Greece'
ORDER BY cu.[FirstName], cu.[Age] DESC;

-- *** ----------------------------------------------------------------------------------
