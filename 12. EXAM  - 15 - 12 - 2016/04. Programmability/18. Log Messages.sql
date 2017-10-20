/*   CONDITIONS   

     Create a trigger that logs any deleted message from table messages. 
	 Submit only your create trigger statement. 
	 The log table should be called MessageLogs 
	 and should have exactly the same structure as table Messages. 
	 The name of the trigger is not important.

*/
USE [TheNerdHerd];
GO

SELECT TOP(0) * INTO MessageLogs FROM Messages;
GO

CREATE TRIGGER tr_Logs ON Messages AFTER DELETE AS
BEGIN
	INSERT INTO MessageLogs(Id, Content, SentOn, ChatId, UserId) 
	SELECT Id, Content, SentOn, ChatId, UserId FROM deleted
END;
GO