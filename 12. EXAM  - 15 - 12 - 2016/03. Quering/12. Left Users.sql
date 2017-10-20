/*   CONDITIONS   

    Select all messages sent from users who have left the chat (they are not in the chat anymore). 
	Filter data only for chat with id 17. Sort by message Id in descending order.

	Id	ChatId	UserId
	 
		OR m.UserId IS NULL
*/

USE [TheNerdHerd];

SELECT m.Id, m.ChatId, m.UserId FROM Messages AS m
WHERE m.ChatId = 17 
  AND (m.UserId NOT IN(SELECT UserId FROM UsersChats WHERE ChatId = m.ChatId) OR m.UserId IS NULL)
ORDER BY m.Id DESC