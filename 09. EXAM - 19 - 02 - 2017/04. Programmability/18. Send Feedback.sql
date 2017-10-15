-- *** ----------------------------------------------------------------------------------

USE Bakery;
GO

-- *** ----------------------------------------------------------------------------------

CREATE PROCEDURE usp_SendFeedback
				 (
					@CustomerId INT, 
					@ProductId INT, 
					@Rate DECIMAL(4, 2),
					@Description NVARCHAR(255)
				 ) AS
BEGIN
	BEGIN TRANSACTION
		INSERT INTO Feedbacks([ProductId], [CustomerId], [Rate], [Description]) 
		VALUES (@ProductId, @CustomerId, @Rate, @Description);
		
		DECLARE @COUNT INT = 
				(
					SELECT COUNT([Id]) 
					FROM Feedbacks
					WHERE [CustomerId] = @CustomerId
				);

		IF(@COUNT > 3)
			BEGIN
				ROLLBACK;
				RAISERROR('You are limited to only 3 feedbacks per product!', 16, 1);
			END;
		ELSE
			BEGIN
				COMMIT;
			END;
END;

-- *** ----------------------------------------------------------------------------------
