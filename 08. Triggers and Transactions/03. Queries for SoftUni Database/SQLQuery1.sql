------------
USE SoftUni;
GO
------------

---------------------------------------------------------------------
-- 08. Employees with Three Projects

CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT) AS
BEGIN TRANSACTION
BEGIN
	DECLARE @PROJECTSCOUNT INT = (
									SELECT COUNT(*) 
								    FROM EmployeesProjects 
								    WHERE @emloyeeId = EmployeeID
								 );
	IF(@PROJECTSCOUNT < 3)
	BEGIN
		INSERT INTO EmployeesProjects VALUES (@emloyeeId, @projectID)
		COMMIT;
	END;
	ELSE
	BEGIN
		ROLLBACK;
		RAISERROR('The employee has too many projects!', 16, 1);
	END;
END;
GO

---------------------------------------------------------------------

---------------------------------------------------------------------
-- 09. Delete Employees

CREATE TABLE Deleted_Employees
(
	EmployeeId INT PRIMARY KEY, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	MiddleName NVARCHAR(50), 
	JobTitle NVARCHAR(90),
    DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentId), 
	Salary DECIMAL(15, 4)
);

CREATE TRIGGER tr_FiredEmploees ON Employees FOR DELETE AS
BEGIN
	INSERT INTO Deleted_Employees
				(
					FirstName,
					LastName,
					MiddleName,
					JobTitle,
					DepartmentId,
					Salary  
				) 
				SELECT FirstName,
					   LastName,
					   MiddleName,
					   JobTitle,
					   DepartmentID,
					   Salary  
				FROM deleted
END;

---------------------------------------------------------------------