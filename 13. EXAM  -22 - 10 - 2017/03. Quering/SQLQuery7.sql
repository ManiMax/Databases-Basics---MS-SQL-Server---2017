/*   CONDITIONS   



*/

USE ReportService;

SELECT * FROM Departments
GO


CREATE TRIGGER udt_StatusChange ON Reports INSTEAD OF UPDATE AS 
BEGIN
	UPDATE Reports
	SET StatusId = 3
	WHERE StatusId IN(SELECT StatusId FROM deleted)
END

