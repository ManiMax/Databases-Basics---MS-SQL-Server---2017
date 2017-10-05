USE SoftUni

--- 13. Departments Total Salaries ---
SELECT
	DepartmentID,
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--- 14. Employees Minimum Salaries ---
SELECT
	DepartmentID,
	MIN(Salary) AS MinimumSalary
FROM Employees
WHERE 
	DepartmentID IN( 2, 5, 7 ) AND
	DATEPART( YEAR, HireDate ) >= 2000
GROUP BY DepartmentID

--- 15. Employees Average Salaries ---
SELECT * 
INTO Employees_New
FROM Employees
WHERE Salary > 30000;

DELETE FROM Employees_New
WHERE ManagerID LIKE 42;

UPDATE Employees_New
SET Salary += 5000
WHERE DepartmentID LIKE 1;

SELECT 
	DepartmentID, 
	AVG(Salary) AS AverageSalary 
FROM Employees_New
GROUP BY DepartmentID;

--- 16. Employees Maximum Salaries ---
SELECT DepartmentID, MAX(Salary) AS MaxSalary 
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000;

--- 17. Employees Count Salaries ---
SELECT COUNT(*) AS [Count] 
FROM Employees 
WHERE ManagerID IS NULL

--- 18. 3rd Highest Salary ---
SELECT 
	DepartmentID, 
	Salary 
FROM
(
	SELECT 
		DepartmentID, 
		Salary,
		RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS [Rank] 
	FROM Employees
	GROUP BY 
		DepartmentID, 
		Salary
) AS RankedSalaries
WHERE Rank LIKE 3;

--- 19. Salary Challenge ---
SELECT TOP(10) 
	FirstName, 
	LastName, 
	DepartmentID 
FROM Employees AS emp1
WHERE Salary >  (
					SELECT AVG(Salary) FROM Employees AS emp2
					WHERE emp1.DepartmentID = emp2.DepartmentID
					GROUP BY DepartmentID
				)
ORDER BY DepartmentID



