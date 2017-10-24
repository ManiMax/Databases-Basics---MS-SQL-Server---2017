/*   CONDITIONS   

	Create a user defined stored procedure with the name 
	usp_AssignEmployeeToReport(@employeeId, @reportId) that receives an employee’s Id
	 and a report’s Id and assigns the employee to the report only 
	 if the department of the employee and the department of the report’s category 
	 are the same. 
	 If the assigning is not successful rollback any changes and throw an exception 
	 with message: “Employee doesn't belong to the appropriate department!”. 

*/
USE ReportService;
GO

CREATE PROCEDURE usp_AssignEmployeeToReport(@employeeId INT, @reportId INT) AS
BEGIN
  IF()
END;
GO


SELECT * FROM Reports