/*
	*** CONDITIONS ***

Find all items with statistics larger than average. 
Display only items that have Mind, Luck and Speed greater than average Items mind, luck and speed. 
Sort the results by item names in alphabetical order. 
Submit your query statement as Prepare DB & run queries in Judge.

*/


SELECT i.Name, 
	   i.Price,
	   i.MinLevel,
	   s.Strength,
	   s.Defence,
	   s.Speed,
	   s.Luck,
	   s.Mind
FROM Items AS i
JOIN [Statistics] AS s ON s.Id = i.StatisticId
WHERE s.Speed > (SELECT AVG(Speed) FROM [Statistics]) AND
	  s.Luck > (SELECT AVG(Luck) FROM [Statistics]) AND
	  s.Mind > (SELECT AVG(Mind) FROM [Statistics])
ORDER BY i.Name
