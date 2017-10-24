/*   CONDITIONS   

	Create a user defined function with the name udf_GetReportsCount(@employeeId, @statusId) 
	that receives an employee’s Id and a status Id returns the sum of the reports he is 
	assigned to with the given status.


*/
USE ReportService;
GO

CREATE FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT)
RETURNS INT AS
BEGIN
	RETURN (SELECT COUNT(Id) FROM Reports 
	  WHERE @employeeId = EmployeeId AND @statusId = StatusId)
END;