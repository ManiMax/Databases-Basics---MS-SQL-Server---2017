---============================================================================---
USE Diablo;
GO
---============================================================================---
----------------------------------------------------------------------------------
--- 13. *Cash in User Games Odd Rows ---
--SELECT * FROM UsersGames
CREATE FUNCTION ufn_CashInUsersGames(@Game VARCHAR(MAX)) 
RETURNS TABLE
RETURN SELECT SUM(Cash) AS [SumCash] 
	   FROM
	   (
	   		SELECT ug.Cash AS [Cash],
	   			   ROW_NUMBER() OVER(ORDER BY Cash DESC) AS RowNumber
	   		FROM UsersGames AS ug
	   		JOIN Games AS g ON g.Id = ug.GameId
	   		WHERE g.Name = @Game 
	   ) AS CashList
	   WHERE RowNumber % 2 = 1;
GO

---============================================================================---
