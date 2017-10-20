/*   CONDITIONS   

    Select all chats and the amount of messages they have. 
	Some messages may not have a chat. 
	Filter messages with id less than 90. 
	Select only the first 5 results sorted by TotalMessages in descending order 
	and chat id in ascending order.

	(Chat)Id	TotalMessages

*/

USE [TheNerdHerd];

SELECT TOP(5)
  c.Id, COUNT(m.Id) AS [TotalMessages] 
FROM Chats AS c
RIGHT JOIN Messages AS m ON m.ChatId = c.Id
WHERE m.Id <= 90
GROUP BY c.Id
ORDER BY [TotalMessages] DESC, Id;

