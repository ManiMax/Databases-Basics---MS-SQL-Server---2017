/*   CONDITIONS   

	Do you remember ASL?  It stands for Age, Sex(gender), Location. 
	You have to insert couple of message based on table Users. 

	?	Content – it should be concatenation of age, gender, latitude and longitude split by dash. 
	    Use a concatenating function.
	?	SentOn – should be the current date
	?	ChatId – 
	?	If the user is female multiply the age by 2 and then take the square root 
	?	if it is a male divide the age by 18 and take it the power of 3
	?	when you find the id round it up
	?	UserId – take the UserId from the table
	?	You should insert data for users with id between 10 and 20 inclusively

*/
USE TheNerdHerd;

INSERT INTO Messages(Content, ChatId, UserId, SentOn)
SELECT  
  CONCAT(u.Age, '-', u.Gender, '-', l.Latitude, '-', l.Longitude),
  CASE
    WHEN u.Gender = 'F' THEN CEILING(SQRT(u.Age * 2))
	WHEN u.Gender = 'M' THEN CEILING(POWER(u.Age / 18, 3))
  END,
  u.Id,
  GETDATE()-- or using '2016-12-15'
FROM Users AS u
JOIN Locations AS l ON l.Id = u.LocationId
WHERE u.Id BETWEEN 10 AND 20;
