-- *** ----------------------------------------------------------------------------------

USE Bakery;
GO

-- *** ----------------------------------------------------------------------------------

CREATE FUNCTION udf_GetRating(@ProductName NVARCHAR(25))
RETURNS NVARCHAR(10)
BEGIN
	DECLARE @RESULT NVARCHAR(10);
    DECLARE @RATE DECIMAL(10, 2) =
		   (
				SELECT 
					AVG(f.[Rate])
				FROM Feedbacks AS f
				JOIN Products AS p ON p.[Id] = f.ProductId 
				GROUP BY p.[Name]
				HAVING p.[Name] = @ProductName
			)

	IF(@RATE < 5)
		SET @RESULT = 'Bad';
	ELSE IF(@RATE BETWEEN 5 AND 8)
		SET @RESULT = 'Average';
	ELSE IF(@RATE > 8)
		SET @RESULT = 'Good';
	ELSE IF(@RATE IS NULL)
		SET @RESULT = 'No rating';

	RETURN @RESULT;
END;

-- *** ----------------------------------------------------------------------------------
