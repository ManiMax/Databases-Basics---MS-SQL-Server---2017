/*
   Create a user defined function (udf_GetCost) that receives a job’s ID 
 and returns the total cost of all parts that were ordered for it. Return 0 if there are no orders.
*/

USE [Washing Machine Service];
GO

CREATE FUNCTION udf_GetCost(@JobID INT) 
RETURNS DECIMAL(18, 2)
BEGIN
	RETURN (SELECT ISNULL(SUM(op.Quantity * p.Price), 0)  
			FROM Orders AS o
			JOIN OrderParts AS op ON op.OrderId = o.OrderId
			JOIN Parts AS p ON p.PartId = op.PartId
			WHERE o.JobId = @JobID);
END;
