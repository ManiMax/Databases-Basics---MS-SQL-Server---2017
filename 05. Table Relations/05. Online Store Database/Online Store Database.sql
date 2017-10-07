CREATE DATABASE [Online Store];
GO

USE [Online Store];
GO

CREATE TABLE Cities
(
    CityID INT IDENTITY(1, 1),
    Name VARCHAR(50) NOT NULL,
 
    CONSTRAINT PK_Cities
    PRIMARY KEY (CityID)
);
 
CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1, 1),
    Name VARCHAR(50) NOT NULL,
    Birthday DATE,
    CityID INT,
 
    CONSTRAINT PK_Costumers
    PRIMARY KEY (CustomerID),
 
    CONSTRAINT FK_Customers
    FOREIGN KEY (CityID)
    REFERENCES Cities(CityID)
);
 
CREATE TABLE Orders
(
    OrderID INT IDENTITY(1, 1),
    CustomerID INT NOT NULL,
 
    CONSTRAINT PK_Orders
    PRIMARY KEY (OrderID),
 
    CONSTRAINT FK_Orders
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);
 
CREATE TABLE ItemTypes
(
    ItemTypeID INT IDENTITY(1, 1),
    Name VARCHAR(50) NOT NULL,
 
    CONSTRAINT PK_ItemTypes
    PRIMARY KEY (ItemTypeID)
);
 
CREATE TABLE Items
(
    ItemID INT IDENTITY(1, 1),
    Name VARCHAR(50) NOT NULL,
    ItemTypeID INT NOT NULL,
 
    CONSTRAINT PK_Items
    PRIMARY KEY (ItemID),
 
    CONSTRAINT FK_Items
    FOREIGN KEY (ItemTypeID)
    REFERENCES ItemTypes(ItemTypeID)
);
 
CREATE TABLE OrderItems
(
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
 
    CONSTRAINT PK_OrderItems
    PRIMARY KEY (OrderID, ItemID),
 
    CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),
 
    CONSTRAINT FK_OrderItems_Items
    FOREIGN KEY (ItemID)
    REFERENCES Items(ItemID)
);