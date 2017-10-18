/*

		CONDITIONS: 
	 Find all users in games with their items count and items price.
	 Display the username, game name, items count and items price. 
	 Display only user in games with items count more or equal to 10. 
	 Sort the results by items count in descending order then by price in descending order
	  and by username in ascending order. 
	 Submit your query statement as Prepare DB & run queries in Judge.

	 ------------------------- OUTPUT -------------------------
	 ----------------------------------------------------------
	 Username	    Game	           Items Count	Items Price
	 ----------------------------------------------------------
     skippingside	Rose Fire & Ice	    23	        11065.00
     countrydecay	Star of Bethlehem	18	        8039.00
     obliquepoof	Washington D.C.	    17	        5186.00
	 ...            ...                 ...         ...
	 ----------------------------------------------------------
*/

USE Diablo; 

SELECT u.Username,
	   g.Name AS [Game],
	   COUNT(i.Name) AS [Items Count],
	   ISNULL(SUM(i.Price), 0) AS [Items Price] 
FROM UsersGames AS ug 
JOIN Users AS u ON u.Id = ug.UserId
JOIN Games AS g ON g.Id = ug.GameId
JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
JOIN Items AS i ON i.Id = ugi.ItemId
GROUP BY u.Username, g.Name 
HAVING COUNT(i.Name) >= 10 
ORDER BY [Items Count] DESC, [Items Price] DESC, u.Username