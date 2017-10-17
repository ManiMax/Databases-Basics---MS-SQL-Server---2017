-- *** ----------------------------------------------------------------------------------

USE Bakery;
GO

-- *** ----------------------------------------------------------------------------------

CREATE VIEW v_UserWithCountries AS 
SELECT CONCAT(c.[FirstName], ' ', c.[LastName]) AS CustomerName,
	   c.[Age],
	   c.[Gender],
	   co.[Name] as CountryName 
FROM Customers AS c
JOIN Countries AS co ON co.[Id] = c.[CountryId]

--select * from dbo.v_UserWithCountries

-- *** ----------------------------------------------------------------------------------
