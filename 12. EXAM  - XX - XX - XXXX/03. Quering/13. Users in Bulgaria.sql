/*   CONDITIONS   

    Select all users that are located in Bulgaria. 
	Consider the latitude is in range [41.14;44.13] and longitude in range [22.21; 28.36]. 
	Sort the results by title in ascending order.

	Nickname	Title	Latitude	Longitude
	-----------------------------------------
    slittle1	Lotlux	42.09028	25.03239

*/

USE [TheNerdHerd];

SELECT u.Nickname, c.Title, l.Latitude, l.Longitude FROM Users AS u 
JOIN Locations AS l ON l.Id = u.LocationId
JOIN UsersChats AS uc ON uc.UserId = u.Id
JOIN Chats AS c ON c.Id = uc.ChatId
WHERE l.Latitude BETWEEN 41.13999 
  AND 44.12999 AND l.Longitude BETWEEN 22.20999 AND 28.35999
ORDER BY c.Title