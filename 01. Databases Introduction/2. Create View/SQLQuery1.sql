------------------------------------------------------------------------------------------------
-- 4. Create a View: which displays the owner, type and balance of each account in our database.

CREATE VIEW v_ClientBalances AS 
SELECT 
	(FirstName + ' ' + LastName) AS [Name],
	(AccountType.AcountName) AS [Account Type],
	Balance
FROM Clients
JOIN Accounts ON Clients.ClientID = Accounts.AccountID
JOIN AccountType ON AccountType.TypeID = Accounts.AcountTypeID
