/*   CONDITIONS   

    Delete all locations which doesn’t have user located there.

*/

USE [TheNerdHerd];

DELETE FROM Locations
WHERE Id NOT IN
(
  SELECT l.Id FROM Locations AS l
  LEFT JOIN Users AS u ON l.Id = u.LocationId
  WHERE u.Id IS NOT NULL
);
