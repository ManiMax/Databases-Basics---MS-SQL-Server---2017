/*   CONDITIONS   

   Create a trigger that will help you to delete a user. 
   Submit the create trigger statement only.

*/
USE [TheNerdHerd];
GO

CREATE TRIGGER tr_DeleteUser ON Users INSTEAD OF DELETE AS
BEGIN
	 UPDATE Users
	 SET CredentialId = NULL
	 WHERE Id IN (SELECT Id FROM deleted)

	 DELETE FROM Credentials
	 WHERE Credentials.Id IN (SELECT CredentialId FROM deleted)
	
	 DELETE UsersChats
	 WHERE UserId IN (SELECT Id FROM deleted)

	 UPDATE Messages
	 SET UserId = NULL
	 WHERE UserId IN (SELECT Id FROM deleted)

	 DELETE FROM Users
	 WHERE Id IN (SELECT Id FROM deleted)
END;
GO