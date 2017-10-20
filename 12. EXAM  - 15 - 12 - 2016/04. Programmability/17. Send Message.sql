/*   CONDITIONS   

  Create a user defined procedure sends a message with a current date. 
  The procedure should receive UserId, ChatId and the Content of the message. 
  
  If there is no chat with that user throw an exception with Severity = 16, State = 1 
  and message “There is no chat with that user!”. Call the procedure udp_SendMessage.

    Parameters:
	?	UserId
	?	ChatId
	?	Content

  Content	SentOn	    ChatId	UserId
  ------------------------------------
  Awesome	2016-12-15	17	    19

*/

USE [TheNerdHerd];
GO

CREATE PROCEDURE udp_SendMessage(@UserId INT, @ChatId INT, @Content VARCHAR(200)) AS
BEGIN
	IF(@UserId NOT IN(SELECT UserId FROM (SELECT * FROM UsersChats WHERE ChatId = @ChatId) AS US))
	BEGIN
		RAISERROR('There is no chat with that user!', 16, 1);
		RETURN;
	END;

	INSERT INTO Messages(Content, SentOn, ChatId, UserId) 
	VALUES (@Content, GETDATE(), @ChatId, @UserId);
END;
GO

-- EXEC dbo.udp_SendMessage 19, 17, 'Awesome'