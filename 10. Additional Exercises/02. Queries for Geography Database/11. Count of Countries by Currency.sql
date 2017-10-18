/*
     *** CONDITIONS ***

	Find the number of countries for each currency. 
	Display three columns: currency code, currency description and number of countries. 
	Sort the results by number of countries (from highest to lowest)
	, then by currency description alphabetically. 
	Name the columns exactly like in the table below. 
	
*/

USE Geography;

 SELECT cu.CurrencyCode,
		cu.Description AS [Currency],
		COUNT(c.CountryCode) AS [NumberOfCountries] 
FROM Currencies AS cu
LEFT JOIN Countries AS c ON c.CurrencyCode = cu.CurrencyCode 
GROUP BY cu.CurrencyCode, cu.Description
ORDER BY [NumberOfCountries] DESC, [Currency]
