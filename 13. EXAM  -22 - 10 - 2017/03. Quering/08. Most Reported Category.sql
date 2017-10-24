/*   CONDITIONS   


	Select ALL categories and order them by the number of reports per category in 
	descending order 
	and then alphabetically by name.

	Required columns:
	?	CategoryName
	?	ReportsNumber

*/
USE ReportService;


SELECT c.Name AS [CategoryName], r.ReportsNumber
FROM Categories AS c
JOIN 
(
	SELECT r.CategoryId, COUNT(r.Id) AS [ReportsNumber]
	FROM Reports AS r 
	JOIN Categories AS c ON c.Id = r.CategoryId
	GROUP BY CategoryId
) AS r ON r.CategoryId = c.Id
ORDER BY ReportsNumber DESC, [CategoryName]



