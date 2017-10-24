/*   CONDITIONS   



*/

USE ReportService

SELECT d.Name AS [Department Name], 
	CASE
		WHEN AVG(DATEDIFF(DAY, r.OpenDate, r.CloseDate)) IS NULL THEN 'no info'
		ELSE CAST(AVG(DATEDIFF(DAY, r.OpenDate, r.CloseDate)) AS varchar)
	END AS [Average Duration]
FROM Reports AS r
LEFT JOIN Categories AS c ON c.Id = r.CategoryId
JOIN Departments AS d ON d.Id = c.DepartmentId
GROUP BY d.Name
ORDER BY [Department Name]


