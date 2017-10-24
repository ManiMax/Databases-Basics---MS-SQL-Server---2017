/*   CONDITIONS   

	Select all employees and show how many unique users each of them have served to.

	Required columns:
	?	Employee’s name - Full name consisting of FirstName and LastName with space between 
	?	User’s number

	Order by Users Number descending and then by Name ascending.


*/
USE ReportService;

SELECT DISTINCT 
  CONCAT(e.FirstName, ' ', e.LastName) AS [Name], 
  COUNT(r.UserId) AS [Users Number]
FROM Reports AS r
RIGHT JOIN Employees AS e ON e.Id = r.EmployeeId
GROUP BY CONCAT(e.FirstName, ' ', e.LastName)
ORDER BY [Users Number] DESC, [Name]