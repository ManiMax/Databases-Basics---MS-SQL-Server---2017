/*   CONDITIONS   

	Select all unique usernames which:
	?	starts with a digit and have reported in a category with id equal to the digit
	OR
	?	ends with a digit and have reported in a category with id equal to the digit

	Required columns:
	?	Username
	Order them alphabetically.


*/

USE ReportService;

SELECT DISTINCT u.Username 
FROM Users AS u
JOIN Reports AS r ON r.UserId = u.Id
WHERE (LEFT(u.Username, 1) IN('0','1','2','3','4','5','6','7','8','9') 
       AND CAST(r.CategoryId AS Nvarchar(3)) = LEFT(u.Username, 1))
   OR (RIGHT(u.Username, 1) IN('0','1','2','3','4','5','6','7','8','9')
       AND CAST(r.CategoryId AS Nvarchar(3)) = RIGHT(u.Username, 1))
ORDER BY Username

