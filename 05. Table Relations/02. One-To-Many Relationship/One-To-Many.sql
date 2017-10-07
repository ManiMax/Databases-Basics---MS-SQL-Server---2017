USE [TABLE_RELATIONS];
GO

CREATE TABLE Manufacturers
(
	ManufacturerID INT IDENTITY,
	Name VARCHAR(50) NOT NULL,
	EstablishedOn DATETIME NOT NULL,
	CONSTRAINT PK_Manufacturers PRIMARY KEY (ManufacturerID)
);
GO

CREATE TABLE Models
(
	ModelID INT IDENTITY(101, 1),
	Name VARCHAR(50) NOT NULL,
	ManufacturerID INT NOT NULL,

	CONSTRAINT PK_Models 
	PRIMARY KEY (ModelID),

	CONSTRAINT FK_Models_Manufacturers 
	FOREIGN KEY (ManufacturerID) 
	REFERENCES Manufacturers(ManufacturerID)
);
GO

INSERT INTO Manufacturers VALUES
('BMV', '07/03/1916'),
('Tesla', '01/01/2003'),
('Lada', '01/05/1966');
GO

INSERT INTO Manufacturers VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);
GO

