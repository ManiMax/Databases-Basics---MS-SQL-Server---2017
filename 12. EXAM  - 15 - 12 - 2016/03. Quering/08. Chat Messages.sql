/*   CONDITIONS   

    Select all chats with messages sent before 26.03.2012 and chat title with last letter equal to “x”. 
	Sort by chat Id and message Id in ascending order.

	Id	Tittle	 Id
	---------------
    22	Quo Lux  48
*/
USE [TheNerdHerd];

SELECT c.Id, c.Title, m.Id FROM Chats AS c
JOIN Messages AS m ON m.ChatId = c.Id
WHERE m.SentOn < '2012-03-26' AND c.Title LIKE '%x'
ORDER BY c.Id, m.Id;