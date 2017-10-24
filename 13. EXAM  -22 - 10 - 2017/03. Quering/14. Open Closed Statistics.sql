/*   CONDITIONS   

	
Select all employees who have at least one assigned closed or open report through year 
2016 and their total sum. Open reports don’t have a CloseDate. 
Reports that have been opened before 2016 but were closed in 2016 are counted as closed only! 
Order by Name (ascending), and then by employee Id

Required columns:
?	Name - name - Full name consisting of FirstName and LastName and a space between them
?	Closed /Open reports number


*/

USE ReportService;

SELECT r.Name, r.[Closed Open Reports] FROM(
SELECT e.Id, CONCAT(e.FirstName, ' ', e.LastName) AS [Name],
       CONCAT(COUNT(OpenDate), '/', COUNT(CloseDate)) AS [Closed Open Reports]
FROM Employees AS e
JOIN Reports AS r ON r.EmployeeId = e.Id
GROUP BY e.Id, CONCAT(e.FirstName, ' ', e.LastName), r.OpenDate, r.CloseDate
HAVING (YEAR(r.OpenDate) = 2016 OR YEAR(r.CloseDate) = 2016)) AS r
ORDER BY [Name], Id