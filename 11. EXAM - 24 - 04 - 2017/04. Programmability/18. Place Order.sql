/*  CONDITIONS   

   Your task is to create a user defined procedure (usp_PlaceOrder) which accepts:
   job ID, part serial number and quantity and creates an order with the specified parameters.
  
   If an order already exists for the given job that and the order is not issued 
   (order’s issue date is NULL), add the new product to it. 

   If the part is already listed in the order, add the quantity to the existing one.

   When a new order is created, set it’s IssueDate to NULL.

   Limitations:
   • An order cannot be placed for a job that is Finished; 
     error message ID 50011 "This job is not active!"
   • The quantity cannot be zero or negative; 
     error message ID 50012 "Part quantity must be more than zero!"
   • The job with given ID must exist in the database; 
     error message ID 50013 "Job not found!"
   • The part with given serial number must exist in the database ID 50014 "Part not found!"

   If any of the requirements aren’t met, rollback any changes to the database you’ve made and 
   throw an exception with the appropriate message and state 1.

   Parameters:
   • JobId
   • Part Serial Number
   • Quantity
*/

--USE [Washing Machine Service];
--GO

CREATE PROCEDURE usp_PlaceOrder(@JobID INT, @PartSerialNumber VARCHAR(50), @Quantity INT) AS
BEGIN
	IF((SELECT Status FROM Jobs WHERE JobId = @JobID) = 'Finished')
	BEGIN
		RAISERROR('This job is not active!', 16, 1);
		RETURN;
	END
	
	IF(@Quantity < 0)
	BEGIN
		RAISERROR('Part quantity must be more than zero!', 16, 1);
		RETURN;
	END;	

	IF(@JobID NOT IN(SELECT JobId FROM Jobs)) 
	BEGIN 
		RAISERROR('Job not found!', 16, 1);
		RETURN;
	END;
	 
	IF(@PartSerialNumber NOT IN(SELECT SerialNumber FROM Parts))
	BEGIN 
		RAISERROR('Part not found!', 16, 1);
		RETURN;
	END;

	DECLARE @PartID INT = (SELECT PartId FROM Parts WHERE SerialNumber = @PartSerialNumber);
	DECLARE @OrderID INT = (
		SELECT o.OrderId FROM Orders AS o
		JOIN OrderParts AS op ON op.OrderId = o.OrderId
		JOIN Parts AS p ON p.PartId = op.PartId
		WHERE o.JobId = @JobID AND p.PartId = @PartID AND o.IssueDate IS NULL);

	IF(@OrderID IS NULL)
	BEGIN
		INSERT INTO Orders(JobId, IssueDate)
		VALUES (@JobID, NULL)

		INSERT INTO OrderParts(OrderId, PartId, Quantity)
		VALUES (IDENT_CURRENT('Orders'), @PartID, @Quantity )
	END
	ELSE
	BEGIN
		IF(@PartID NOT IN(SELECT PartId FROM OrderParts WHERE OrderId = @OrderID))
		BEGIN
			INSERT INTO OrderParts(OrderId, PartId, Quantity)
			VALUES (@OrderID, @PartID, @Quantity )
		END;
		ELSE
		BEGIN
			UPDATE OrderParts
			SET Quantity += @Quantity
			WHERE OrderId = @OrderID AND PartId = @PartID
		END;
	END;
END;
