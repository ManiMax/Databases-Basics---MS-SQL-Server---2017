USE Diablo;

-- 07 --

/* SOLUTION FROM: TRIGGERS AND TRANSACTION - EXERCISES - VIDEO 

1. User Stamat in Safflower game wants to buy some items. 
	He likes all items from Level 11 to 12 as well as all items from Level 19 to 21. 
	As it is a bulk operation you have to use transactions. 
2. A transaction is the operation of taking out the cash from the user in the current game
	 as well as adding up the items. 
3. Write transactions for each level range. If anything goes wrong turn back the changes inside of the transaction.
4. Extract all of Stamat’s item names in the given game sorted by name alphabetically
*/ 

DECLARE @USERID INT = (SELECT Id FROM Users WHERE Username = 'Stamat');
DECLARE @GAMEID INT = (SELECT Id FROM Games WHERE Name = 'Safflower');
DECLARE @USERGAMEID INT = (SELECT Id FROM UsersGames WHERE UserId = @USERID AND GameId = @GAMEID);
--SELECT @USERGAMEID


BEGIN TRY
	BEGIN TRANSACTION
	
		UPDATE UsersGames 
		SET Cash -= (SELECT SUM(Price) FROM Items WHERE MinLevel IN(11, 12)) 
		WHERE Id = @USERGAMEID;
	
		DECLARE @BALANCE DECIMAL(15, 4) = (SELECT Cash FROM UsersGames WHERE Id = @USERGAMEID);
	
		IF(@BALANCE < 0)
		BEGIN
			ROLLBACK;
			RETURN;
		END;
	
		INSERT INTO UserGameItems 
		SELECT Id, @USERGAMEID 
		FROM Items 
		WHERE MinLevel IN(11, 12);
	
	COMMIT;
END TRY
BEGIN CATCH
	ROLLBACK;
END CATCH;


BEGIN TRY
	BEGIN TRANSACTION
		UPDATE UsersGames 
		SET Cash -= (SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 19 AND 21) 
		WHERE Id = @USERGAMEID;

		SET @BALANCE =  (SELECT Cash FROM UsersGames WHERE Id = @USERGAMEID);

		IF(@BALANCE < 0)
		BEGIN
			ROLLBACK;
			RETURN;
		END;

		INSERT INTO UserGameItems 
		SELECT Id, @USERGAMEID 
		FROM Items 
		WHERE MinLevel BETWEEN 19 AND 21;
	COMMIT;
END TRY
BEGIN CATCH
	ROLLBACK;
END CATCH;

SELECT i.Name AS [Item Name] FROM Items AS i
JOIN UserGameItems AS ui ON ui.ItemId = i.Id
WHERE ui.UserGameId = @USERGAMEID
ORDER BY [Item Name];