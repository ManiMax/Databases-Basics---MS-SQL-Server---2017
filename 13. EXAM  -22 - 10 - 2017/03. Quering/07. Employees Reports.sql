/*   CONDITIONS   

	Select only employees who have an assigned report and show all reports of each found employee. 
	Show the open date column in the format “yyyy-MM-dd”. 
	Order them by employee id (ascending) then by open date (ascending) 
	and then by report Id (again ascending).
	Required columns:
	?	FirstName
	?	LastName
	?	Description
	?	OpenDate


*/
USE ReportService;

SELECT FirstName, LastName, Description, FORMAT(OpenDate, 'yyyy-MM-dd') AS [OpenDate] 
FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId = e.Id
ORDER BY EmployeeId, OpenDate