-- *** ----------------------------------------------------------------------------------

USE Bakery;

-- *** ----------------------------------------------------------------------------------

SELECT TOP(10) 
		p.[Name], 
		p.[Description], 
		j.[AverageRate], j
		.[FeedbacksAmount] 
FROM Products AS p
LEFT JOIN 
(
	SELECT [ProductId], 
	   AVG([Rate]) AS [AverageRate], 
	   COUNT([Id]) AS [FeedbacksAmount]
	FROM Feedbacks
	GROUP BY [ProductId]
) AS j ON j.ProductId = p.Id
ORDER BY j.[AverageRate] DESC, j.[FeedbacksAmount] DESC;



-- *** ----------------------------------------------------------------------------------
