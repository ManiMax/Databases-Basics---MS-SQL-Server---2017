-- *** ----------------------------------------------------------------------------------

USE Bakery;

-- *** ----------------------------------------------------------------------------------

SELECT TOP(1) WITH TIES
		co.[Name] AS [CountryName],
	    AVG(f.[Rate])  AS [FeedbackRate]
FROM Feedbacks AS f
LEFT JOIN Customers AS cu ON cu.[Id] = f.[CustomerId]
LEFT JOIN Countries AS co ON co.[Id] = cu.[CountryId]
GROUP BY co.[Name]
ORDER BY AVG(f.[Rate]) DESC


-- *** ----------------------------------------------------------------------------------
