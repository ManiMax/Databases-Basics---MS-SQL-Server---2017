USE SoftUni
GO

--- 01. Find Names of All Employees by First Name ---
SELECT FirstName, LastName FROM Employees WHERE FirstName LIKE 'SA%';
GO

--- 02. Find Names of All Employees by Last Name ---
SELECT FirstName, LastName FROM Employees WHERE LastName LIKE '%ei%';
GO

--- 03. Find First Names of All Employess ---
SELECT FirstName FROM Employees 
WHERE DepartmentID IN(3, 10) AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005;
GO

--- 04. Find All Employees Except Engineers ---
SELECT FirstName, LastName FROM Employees WHERE JobTitle NOT LIKE '%engineer%';
GO

--- 05. Find Towns with Name Length ---
SELECT [Name] FROM Towns WHERE DATALENGTH([Name]) IN (5, 6) ORDER BY [Name];
GO

--- 06. Find Towns Starting With ---
SELECT * FROM Towns 
WHERE [Name] LIKE 'M%' OR [Name] LIKE 'K%' OR [Name] LIKE 'B%' OR [Name] LIKE 'E%'
ORDER BY [Name]
GO

--- 07. Find Towns Not Starting With ---
SELECT * FROM Towns 
WHERE [Name] NOT LIKE'R%' AND 
      [Name] NOT LIKE 'B%' AND 
	  [Name] NOT LIKE 'D%'
ORDER BY [Name];
GO
-- || --
SELECT * FROM Towns WHERE [Name] NOT LIKE'[RBD]%' ORDER BY [Name];
GO

--- 08. Create View Employees Hired After ---
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000
GO

--- 09. Length of Last Name ---
SELECT FirstName, LastName FROM Employees
WHERE DATALENGTH(LastName) = 5;

