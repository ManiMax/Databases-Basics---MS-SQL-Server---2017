------------------------------------------------------------------------------------------------
-- 4. Create a View: which displays the owner, type and balance of each account in our database.

CREATE VIEW v_ClientBalances AS 
SELECT 
	(FirstName + ' ' + LastName) AS [Name],
	(AccountType.AcountName) AS [Account Type],
	Balance
FROM dbo.Clients

JOIN Accounts ON Clients.ClientID = Accounts.ClientID
JOIN AccountTypes ON AccountTypes.Id = Accounts.AccountTypeId
