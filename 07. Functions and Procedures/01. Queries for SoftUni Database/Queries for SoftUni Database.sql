---============================================================================---
USE SoftUni;
GO
---============================================================================---
----------------------------------------------------------------------------------
--- 01. Employees with Salary Above 35000 ---
CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000 AS
--CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000 AS 
SELECT FirstName, LastName FROM Employees
WHERE Salary > 35000;
GO
--EXEC dbo.usp_GetEmployeesSalaryAbove35000;


----------------------------------------------------------------------------------
--- 02. Employees with Salary Above Number
CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Salary DECIMAL(18,4)) AS
--CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Salary DECIMAL(18,4)) AS
SELECT FirstName, LastName FROM Employees
WHERE Salary >= @Salary;
GO
--EXEC dbo.usp_GetEmployeesSalaryAbove35000


----------------------------------------------------------------------------------
--- 03. Town Names Starting With ---
CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith (@CheckString VARCHAR(10)) AS
--CREATE PROCEDURE usp_GetTownsStartingWith (@CheckString VARCHAR(10)) AS 
SELECT Name FROM Towns
WHERE Name LIKE @CheckString + '%';
GO
--EXEC dbo.usp_GetTownsStartingWith 'RED';


----------------------------------------------------------------------------------
--- 04. Employees from Town ---
CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown  (@Town VARCHAR(50)) AS
--CREATE PROCEDURE usp_GetEmployeesFromTown  (@Town VARCHAR(50)) AS
SELECT FirstName, LastName FROM Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
JOIN Towns AS t ON t.TownID = a.TownID
WHERE t.Name = @Town;
GO
--EXEC dbo.usp_GetEmployeesFromTown 'Sofia';


----------------------------------------------------------------------------------
--- 05. Salary Level Function ---
CREATE OR ALTER FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18,4))
--CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
BEGIN 
	DECLARE @SalaryLevel VARCHAR(10) = 'Low';
		IF (@salary BETWEEN 30000 AND 50000)
		   SET @Salarylevel = 'Average';
		ELSE IF (@salary > 50000) 
			SET @SalaryLevel = 'High';
	RETURN @SalaryLevel;
END
GO
--SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) FROM Employees


----------------------------------------------------------------------------------
--- 06. Employees by Salary Level ---
CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel (@SalaryLevel VARCHAR(10)) AS
--CREATE PROCEDURE usp_EmployeesBySalaryLevel (@SalaryLevel VARCHAR(10)) AS
SELECT FirstName, LastName FROM Employees
WHERE  dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel;
GO
--EXEC usp_EmployeesBySalaryLevel 'high';


----------------------------------------------------------------------------------
---07. Define Function ---
CREATE OR ALTER FUNCTION ufn_IsWordComprised
						 (
							 @setOfLetters VARCHAR(max), 
							 @word VARCHAR(max)
						 )
--CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(max), @word VARCHAR(max))
RETURNS BIT
AS
BEGIN
  DECLARE @currentIndex INT = 1;
  DECLARE @currentChar CHAR;

  WHILE(@currentIndex <= LEN(@word))
  BEGIN

    SET @currentChar = SUBSTRING(@word, @currentIndex, 1);
    IF(CHARINDEX(@currentChar, @setOfLetters) = 0)
      RETURN 'false';
    SET @currentIndex += 1;
  END
  RETURN 'true';
END
GO


----------------------------------------------------------------------------------
--- 08. Delete Employees and Departments --- 57:00 from the video ---
CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)  AS
--CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)  AS
BEGIN
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN
					(
					SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId
					);

	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL;
    
	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN
					(
					SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId
					);

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN
					(
					SELECT EmployeeID FROM Employees
					WHERE DepartmentID = @departmentId
					);

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId; 
	
	DELETE FROM Departments
	WHERE DepartmentID = @departmentId;

	SELECT COUNT(*) FROM Departments WHERE DepartmentID = @departmentId
END;
GO
---============================================================================---