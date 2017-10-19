-----------------------------------------------------------------------------------------
CREATE DATABASE [Washing Machine Service];

USE [Washing Machine Service];
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Models
(
	ModelId INT IDENTITY, 
	Name VARCHAR(50) UNIQUE,

	CONSTRAINT pk_models
	PRIMARY KEY(ModelId)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Clients
(
	ClientId INT IDENTITY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Phone CHAR(12),

	CONSTRAINT pk_clients
	PRIMARY KEY(ClientId),

	CONSTRAINT chk_phone 
	CHECK(LEN(Phone) = 12)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Mechanics
(
	MechanicId INT IDENTITY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Address VARCHAR(255),

	CONSTRAINT pk_mechanics
	PRIMARY KEY(MechanicId)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Jobs
(
	JobId INT IDENTITY,
	ModelId INT, 
	Status VARCHAR(11) DEFAULT('Pending'),
	ClientId INT,
	MechanicId INT,
	IssueDate DATE,
	FinishDate DATE,

	CONSTRAINT pk_jobs
	PRIMARY KEY(JobId),

	CONSTRAINT fk_jobs_models 
	FOREIGN KEY(ModelId)
	REFERENCES Models(ModelId),

	CONSTRAINT chk_status
	CHECK(Status IN('Pending', 'In Progress', 'Finished')),

	CONSTRAINT fk_jobs_clients
	FOREIGN KEY(ClientId)
	REFERENCES Clients(ClientId),

	CONSTRAINT fk_jobs_mechanics
	FOREIGN KEY(MechanicId)
	REFERENCES Mechanics(MechanicId)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Vendors
(
	VendorId INT IDENTITY, 
	Name VARCHAR(50) UNIQUE,

	CONSTRAINT pk_vendors
	PRIMARY KEY(VendorId)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Parts
(
	PartId INT IDENTITY, 
	SerialNumber VARCHAR(50) UNIQUE,
	Description VARCHAR(255),
	Price DECIMAL(6, 2), 
	VendorId INT, 
	StockQty INT DEFAULT(0),

	CONSTRAINT pk_parts
	PRIMARY KEY(PartId),

	CONSTRAINT chk_price
	CHECK(Price > 0),

	CONSTRAINT fk_parts_vendors
	FOREIGN KEY(VendorId)
	REFERENCES Vendors(VendorId),

	CONSTRAINT chk_stockqty
	CHECK(StockQty >= 0)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE Orders
(
	OrderId INT IDENTITY, 
	JobId INT, 
	IssueDate DATE,
	Delivered BIT DEFAULT(0),

	CONSTRAINT pk_orders
	PRIMARY KEY(OrderId),

	CONSTRAINT fk_orders_jobs
	FOREIGN KEY(JobId)
	REFERENCES Jobs(JobId)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE OrderParts
(
	OrderId INT,
	PartId INT,
	Quantity INT DEFAULT(1),

	CONSTRAINT pk_orderparts
	PRIMARY KEY(OrderId, PartId),

	CONSTRAINT fk_orderparts_orders
	FOREIGN KEY(OrderId)
	REFERENCES Orders(OrderId),

	CONSTRAINT fk_orderparts_parts
	FOREIGN KEY(PartId)
	REFERENCES Parts(PartId),

	CONSTRAINT chk_quantyity
	CHECK(Quantity >= 1)
);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
CREATE TABLE PartsNeeded
(
	JobId INT,
	PartId INT,
	Quantity INT DEFAULT(1),

	CONSTRAINT pk_partsneeded
	PRIMARY KEY(JobId, PartId),

	CONSTRAINT fk_partsneeded_jobs
	FOREIGN KEY(JobId)
	REFERENCES Jobs(JobId),

	CONSTRAINT fk_partsneeded_parts
	FOREIGN KEY(PartId)
	REFERENCES Parts(PartId),

	CONSTRAINT chk_quantity
	CHECK(Quantity >= 1)
);
-----------------------------------------------------------------------------------------
