USE SoftUni;
GO

--- 01. Employee Address ---
SELECT TOP(5) 
	e.EmployeeID, 
	e.JobTitle, 
	e.AddressID, 
	a.AddressText 
FROM Employees AS e
	JOIN Addresses AS a 
		ON e.AddressID = a.AddressID
ORDER BY e.AddressID;
GO

--- 02. Addresses with Towns ---
SELECT TOP(50)
	e.FirstName,
	e.LastName,
	t.Name AS Town,
	a.AddressText 
FROM Employees AS e
	JOIN Addresses AS a 
		ON e.AddressID = a.AddressID
	JOIN Towns AS t 
		ON t.TownID = a.TownID
ORDER BY 
	e.FirstName,
	e.LastName;
GO

--- 03. Sales Employees ---
SELECT
	e.EmployeeID,
	e.FirstName,
	e.LastName,
	d.Name AS DepartmentName
FROM Employees AS e
	JOIN Departments AS d
		ON e.DepartmentID = d.DepartmentID
WHERE d.Name LIKE 'Sales'
ORDER BY e.EmployeeID ASC;
GO

--- 04. Employee Departments ---
SELECT TOP(5)
	e.EmployeeID,
	e.FirstName,
	e.Salary,
	d.Name AS DepartmentName
FROM Employees AS e
	JOIN Departments AS d
		ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID ASC;
GO

--- 05. Employees Without Projects ---
SELECT TOP(3)
	e.EmployeeID,
	e.FirstName
FROM Employees AS e
	LEFT JOIN EmployeesProjects AS ep
		ON ep.EmployeeID = e.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID ASC;
GO

--- 06. Employees Hired After ---
SELECT 
	e.FirstName,
	e.LastName,
	e.HireDate,
	d.Name AS DeptName
FROM Employees AS e
	JOIN Departments AS d
		ON d.DepartmentID = e.DepartmentID
WHERE 
	e.HireDate >= '1/1/1999' 
	AND 
	(
	    d.Name = 'Finance'
		OR d.Name = 'Sales'
	)
ORDER BY e.HireDate ASC;
GO

--- 07. Employees With Project ---
SELECT TOP(5)
	e.EmployeeID,
	e.FirstName,
	p.Name AS ProjectName
FROM Employees AS e
	JOIN EmployeesProjects AS ep
		ON ep.EmployeeID = e.EmployeeID
	JOIN Projects AS p
		ON p.ProjectID = ep.ProjectID 
		AND p.EndDate IS NULL
WHERE p.StartDate > '2002-08-13 00:00:00'
ORDER BY e.EmployeeID ASC;
GO

--- 08. Employee 24 ---
SELECT 
	e.EmployeeID,
	e.FirstName,
	IIF(p.StartDate > '1/1/2005', NULL, p.Name) AS ProjectName
FROM Employees AS e
	JOIN EmployeesProjects AS ep
		ON ep.EmployeeID = e.EmployeeID
	JOIN Projects AS p
		ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24;
GO

--- 09. Employee Manager ---
SELECT 
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	m.FirstName
FROM Employees AS e
	JOIN Employees AS m
		ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN(3, 7)
ORDER BY e.EmployeeID ASC;
GO

--- 10. Employees Summary ---
  SELECT TOP(50)
         e.EmployeeID,
  	     e.FirstName + ' ' + e.LastName AS EmployeeName,
  	     m.FirstName + ' ' + m.LastName AS ManagerName,
		 d.Name AS DepartmentName
    FROM Employees AS e
    JOIN Employees AS m 
      ON e.ManagerID = m.EmployeeID
    JOIN Departments AS d
      ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID ASC;
GO

--- 11. Min Average Salary ---
  SELECT TOP 1 
  	     AVG(Salary) AS MinAverageSalary
    FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSalary;
GO


	