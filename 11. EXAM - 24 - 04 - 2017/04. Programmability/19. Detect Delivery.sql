/*
   Create a trigger that detects when an order’s delivery status is changed from False to True 
   which adds the quantities of all ordered parts to their stock quantity value (Qty).

*/

--USE [Washing Machine Service];

CREATE TRIGGER tr_Delivered ON Orders AFTER UPDATE AS
BEGIN
	IF((SELECT Delivered FROM deleted) = 0 AND (SELECT Delivered FROM inserted) = 1)
	BEGIN 
		UPDATE Parts 
		SET StockQty += op.Quantity 
		FROM  inserted AS i
		JOIN OrderParts AS op ON op.OrderId = i.OrderId
		WHERE i.OrderId = op.OrderId
	END;
END;

--UPDATE Orders
--SET Delivered = 1
--WHERE OrderId = 21
--
--SELECT StockQty FROM Parts
--WHERE PartId = 11