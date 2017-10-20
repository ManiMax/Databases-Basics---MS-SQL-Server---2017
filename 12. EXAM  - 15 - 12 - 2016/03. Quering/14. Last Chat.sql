/*   CONDITIONS   

     Select the first message (if there is any) of the last chat.

*/

USE [TheNerdHerd];

SELECT TOP(1) WITH TIES c.Title, m.Content 
FROM Chats AS c 
LEFT JOIN Messages AS m ON m.ChatId = c.Id
ORDER BY c.StartDate DESC, m.SentOn;
