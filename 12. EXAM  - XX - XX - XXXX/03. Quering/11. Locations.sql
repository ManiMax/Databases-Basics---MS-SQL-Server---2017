/*   CONDITIONS   

     Select all users who don’t have a location.

     Id	  Nickname	Age
     1	  ahunta	63

*/

USE [TheNerdHerd];


SELECT Id, Nickname, Age FROM Users
WHERE Id NOT IN
(
  SELECT u.Id FROM Users AS u
  JOIN Locations AS l ON l.Id = u.LocationId
);
