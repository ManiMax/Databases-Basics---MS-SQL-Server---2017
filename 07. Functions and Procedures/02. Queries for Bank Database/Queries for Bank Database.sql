---============================================================================---
USE Bank;
GO
---============================================================================---
----------------------------------------------------------------------------------
--- 09. Find Full Name ---
CREATE OR ALTER PROCEDURE usp_GetHoldersFullName AS
--CREATE PROCEDURE usp_GetHoldersFullName AS
BEGIN
	SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM AccountHolders
END;
GO

EXECUTE usp_GetHoldersFullName;
GO

----------------------------------------------------------------------------------
--- 10. People with Balance Higher Than ---
CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan(@GivenSum DECIMAL(18, 4)) AS
--CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@GivenSum DECIMAL(18, 4)) AS
BEGIN
	SELECT ah.FirstName AS [First Name], ah.LastName AS [Last Name]
	FROM Accounts AS a
	JOIN 
	(
		SELECT FirstName, LastName, Id 
		FROM AccountHolders
	) AS ah ON a.AccountHolderId = ah.Id
	GROUP BY ah.FirstName, ah.LastName
	HAVING @GivenSum < SUM(Balance)
END;
GO

EXECUTE usp_GetHoldersWithBalanceHigherThan 200000;
GO

----------------------------------------------------------------------------------
--- 11. Future Value Function ---
CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@Money MONEY, @Rate FLOAT, @Years INT)
--CREATE FUNCTION ufn_CalculateFutureValue(@Money MONEY, @Rate FLOAT, @Years INT)
RETURNS MONEY
BEGIN
	DECLARE @Result MONEY;
	SET @Result = @Money * POWER(1 + @Rate, @Years);
	RETURN @Result;
END;
GO

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)  AS QWER;
GO

----------------------------------------------------------------------------------
--- 12. Calculating Interest ---
--SELECT * FROM AccountHolders;

CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount(@ID INT, @Rate FLOAT) AS
--CREATE PROCEDURE usp_CalculateFutureValueForAccount(@ID INT, @Rate FLOAT) AS
BEGIN
	SELECT a.Id AS [Account Id],
		   ah.FirstName AS [First Name],
		   ah.LastName AS [Last Name], 
		   a.Balance AS [Current Balance],
		   dbo.ufn_CalculateFutureValue(a.Balance, @Rate, 5) AS [Balance in 5 years] 
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON a.AccountHolderId = ah.Id
	WHERE a.Id = @ID;
END;
GO

EXEC dbo.usp_CalculateFutureValueForAccount 1, 0.1;
GO
---============================================================================---


