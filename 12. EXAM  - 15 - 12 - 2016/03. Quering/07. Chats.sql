/*   CONDITIONS   

    Select all chats that that are active and their title length is less than 5
    or 3rd and 4th letters are equal to “tl”. Sort the results by title in descending order.

	Title	IsActive
	----------------
    Viva	0

*/

USE [TheNerdHerd];


SELECT Title, IsActive FROM Chats
WHERE (IsActive = 0 AND LEN(Title) < 5) OR Title LIKE '__tl%'
ORDER BY Title DESC;

SELECT