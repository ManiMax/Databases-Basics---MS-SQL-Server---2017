-----------------------------------------------------------------------------------------

USE Bank;

-----------------------------------------------------------------------------------------
-- 01. Create Table Logs 
CREATE TABLE Logs
(
	LogId INT IDENTITY, 
	AccountId INT,
	OldSum MONEY,
	NewSum MONEY,
);
GO

SELECT * FROM Accounts
GO

CREATE TRIGGER tr_OnAccountChanges 
ON Accounts FOR UPDATE AS
BEGIN

	DECLARE @OldBalance MONEY = (SELECT Balance FROM deleted);
	DECLARE @NewBalance MONEY = (SELECT Balance FROM inserted);

	IF(@OldBalance <> @NewBalance)
	BEGIN
		DECLARE @ID INT = (SELECT Id FROM inserted);

		INSERT INTO Logs(AccountId, OldSum, NewSum) 
		VALUES(@ID, @OldBalance, @NewBalance);
	END;

END;


-----------------------------------------------------------------------------------------
--02. Create Table Emails
CREATE TABLE NotificationEmails
(
	Id INT IDENTITY, 
	Recipient NVARCHAR(MAX), 
	Subject NVARCHAR(MAX), 
	Body NVARCHAR(MAX)
);
GO

CREATE TRIGGER tr_Message 
ON Logs FOR INSERT AS
BEGIN
	
	DECLARE @ID INT = (SELECT AccountId FROM inserted);
	DECLARE @DATENOW VARCHAR(20) = CONVERT(VARCHAR(20),GETDATE(),100);
	DECLARE @OLDSUM MONEY = (SELECT OldSum FROM inserted);
	DECLARE @NEWSUM MONEY = (SELECT NewSum FROM inserted);

	INSERT INTO NotificationEmails(Recipient, Subject, Body)
	VALUES
	(
		@ID,
		CONCAT('Balance change for account: ', @ID),
		CONCAT('On ', @DATENOW, ' your balance was changed from ', @OLDSUM, ' to ', @NEWSUM, '.')
	);
END;
GO

-----------------------------------------------------------------------------------------
-- 03. Deposit Money

-- SELECT * FROM Accounts;

CREATE PROCEDURE usp_DepositMoney(@AccountId INT, @MoneyAmount DECIMAL(18, 4)) AS
BEGIN TRANSACTION
BEGIN
	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId;

	IF(@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK;
		RAISERROR('Invalid account!', 16, 1);
		RETURN;
	END;
	
	COMMIT;
END;
GO

-----------------------------------------------------------------------------------------
-- 04. Withdraw Money Procedure 

CREATE PROCEDURE usp_WithdrawMoney(@AccountId INT, @MoneyAmount DECIMAL(18, 4)) AS
BEGIN TRANSACTION
BEGIN
	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE Id = @AccountId;

	IF(@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK;
		RAISERROR('Invalid account!', 16, 1);
		RETURN;
	END;
	
	COMMIT;
END;
GO

-----------------------------------------------------------------------------------------
-- 05. Money Transfer

CREATE PROCEDURE usp_TransferMoney
	(@SenderId INT, @ReceiverId INT, @Amount DECIMAL(18, 4)) AS
BEGIN TRANSACTION
BEGIN
	
	IF(@Amount <= 0)
	BEGIN
		ROLLBACK;
		RAISERROR('Invalid Operation!', 16, 2);
		RETURN;
	END;

	EXEC usp_WithdrawMoney @SenderId, @Amount;
	EXEC usp_DepositMoney @ReceiverId, @Amount;
	COMMIT;

END;

-----------------------------------------------------------------------------------------
