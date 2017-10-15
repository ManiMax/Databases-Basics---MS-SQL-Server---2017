-- *** ----------------------------------------------------------------------------------

USE Bakery;

-- *** ----------------------------------------------------------------------------------

SELECT d.[Name] AS [DistributorName],
	   i.[Name] AS [IngredientName],
	   p.[Name] AS [ProductName] ,
	   AVG(f.[Rate]) AS [AveregeRate]
FROM ProductsIngredients AS p1
JOIN Products AS p ON p.[Id] = p1.[ProductId]
JOIN Ingredients AS i ON i.Id = p1.[IngredientId]
JOIN Distributors AS d ON d.[Id] = i.[DistributorId]
JOIN Feedbacks AS f ON f.[ProductId] = p.[Id]
GROUP BY d.[Name], i.[Name], p.[Name]
HAVING AVG(f.[Rate]) BETWEEN 5 AND 8
ORDER BY d.[Name], i.[Name], p.[Name]

-- *** ----------------------------------------------------------------------------------
