-- *** ----------------------------------------------------------------------------------

USE Bakery;

-- *** ----------------------------------------------------------------------------------

SELECT CONCAT(c.[FirstName], ' ', c.[LastName]) AS [CustomerName],
	   c.[PhoneNumber],
	   c.Gender
FROM Customers AS c
LEFT JOIN 
(
	SELECT [CustomerId] 
	FROM Feedbacks
	GROUP BY [CustomerId]
) AS f ON f.[CustomerId] = c.[Id]
WHERE f.[CustomerId] IS NULL
ORDER BY c.[Id]

-- *** ----------------------------------------------------------------------------------
