/*   CONDITIONS   

    Create a user defined procedure that receives an email and changes the password 
	with the newly provided one. 
	If the email doesn’t exist throw an exception with Severity = 16, State = 1 
	and message “The email does't exist!”. Call the procedure udp_ChangePassword.

      	Email	            Password
		----------------------------
        abarnes0@sogou.com	LOL77s

		exec udp_ChangePassword 'abarnes0@sogou.com','new_pass'

*/
USE [TheNerdHerd];
GO

CREATE PROCEDURE udp_ChangePassword(@Email VARCHAR(30), @NewPasswqrd VARCHAR(20)) AS
BEGIN
	IF(@Email NOT IN(SELECT Email FROM Credentials))
	BEGIN
		RAISERROR('The email does''t exist!', 16, 1);
		RETURN;
	END;

	UPDATE Credentials
	SET Password = @NewPasswqrd
	WHERE Email = @Email;
END;
GO

--exec udp_ChangePassword 'abarERVCSWEnes0@sogou.com','new_pass'