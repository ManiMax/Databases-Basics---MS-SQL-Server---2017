/*   CONDITIONS   

    Select all users with emails ending with “co.uk”. Sort by email in ascending order.

	Nickname	Email                   Password
	----------------------------------------------
    vburkek     mperkinst@amazon.co.uk	lCFO0hSeRt

*/

USE [TheNerdHerd];

SELECT u.Nickname, c.Email, c.Password FROM Users AS u
JOIN Credentials AS c ON c.Id = u.CredentialId
WHERE c.Email LIKE '%co.uk' 
ORDER BY c.Email