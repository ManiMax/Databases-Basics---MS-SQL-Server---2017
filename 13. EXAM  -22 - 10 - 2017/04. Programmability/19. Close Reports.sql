/*   CONDITIONS   

 WHERE CloseDate IS NOT NULL

*/
USE ReportService;
GO

CREATE TRIGGER tr ON Reports FOR UPDATE AS
BEGIN
  UPDATE Reports
  SET StatusId = 3
  WHERE Id IN(SELECT d.Id FROM deleted AS d
			  JOIN inserted AS i ON i.Id = d.Id
              WHERE d.CloseDate IS NULL AND i.CloseDate IS NOT NULL)
END;
GO