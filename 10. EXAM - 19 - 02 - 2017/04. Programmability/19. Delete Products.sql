-- *** ----------------------------------------------------------------------------------

USE Bakery;
GO

-- *** ----------------------------------------------------------------------------------

CREATE TRIGGER tr_DeleteProducts ON Products 
INSTEAD OF DELETE AS
BEGIN

	DELETE FROM ProductsIngredients
	WHERE [ProductId] = (SELECT Id FROM deleted)

	DELETE FROM Feedbacks
	WHERE [ProductId] = (SELECT Id FROM deleted)

	DELETE FROM Products
	WHERE [Id] = (SELECT Id FROM deleted)

END;


-- *** ----------------------------------------------------------------------------------
