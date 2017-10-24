/*   CONDITIONS   

Find all reports that don’t have an assigned employee. 
Order the results by open date in ascending order, then by description (ascending).
Required columns:
?	Description
?	OpenDate


*/

USE ReportService;

SELECT Description, OpenDate FROM Reports
WHERE EmployeeId IS NULL
ORDER BY OpenDate, Description