/*   CONDITIONS   

	Select all categories in which users have submitted a report on their birthday. 
	Order them by name alphabetically.
Required columns:
?	Category Name


*/

USE ReportService;

SELECT c.Name AS [Category Name] FROM Reports AS r
LEFT JOIN Users AS u ON u.BirthDate = r.OpenDate
RIGHT JOIN Categories AS c ON c.Id = r.CategoryId
WHERE r.OpenDate = u.BirthDate OR r.OpenDate IS NULL
ORDER BY [Category Name]



SELECT DISTINCT c.Name AS  [Category Name]
FROM Categories AS c
JOIN
(
  SELECT CategoryId FROM Reports AS r
  JOIN Users AS u ON u.Id = r.UserId
  WHERE DAY(u.BirthDate) = DAY(r.OpenDate)
    AND MONTH(u.BirthDate) = MONTH(r.OpenDate)
) AS a ON a.CategoryId = c.Id
ORDER BY [Category Name]