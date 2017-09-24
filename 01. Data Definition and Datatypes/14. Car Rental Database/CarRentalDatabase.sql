USE master

CREATE DATABASE CarRental

USE CarRental

--- TO INSERTING ---
CREATE TABLE Categories
(
	[Id] INT CONSTRAINT [PK_Categories_Id] PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[CategoryName] VARCHAR(20) CONSTRAINT [DFT_Categories_CategoryName] DEFAULT ('Other') NOT NULL,
	[DailyRate] DECIMAL(5, 2) CONSTRAINT [DFT_Categories_DailyRate] DEFAULT (0) NOT NULL,
	[WeeklyRate] DECIMAL(5, 2) CONSTRAINT [DFT_Categories_WeeklyRate] DEFAULT (0) NOT NULL,
	[MonthlyRate] DECIMAL(5, 2) CONSTRAINT [DFT_Categories_MonthlyRate] DEFAULT (0) NOT NULL,
	[WeekendRate] DECIMAL(5, 2) CONSTRAINT [DFT_Categories_WeekendRate] DEFAULT (0) NOT NULL
)

INSERT INTO Categories VALUES
	('Small Class Cars', 9.80, 60, 230, 15),
	('Middle Class Cars', 12.50, 60, 230, 15),
	('Big Class Cars', 15, 60, 230, 15)

CREATE TABLE Cars
(
	[Id] INT CONSTRAINT [PK_Cars_Id] PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[PlateNumber] VARCHAR(10) CONSTRAINT [CHK_Cars_PlateNumber] CHECK(DATALENGTH([PlateNumber]) = 10) NOT NULL,
	[Manufacturer] VARCHAR(30) NOT NULL,
	[Model] VARCHAR(30) NOT NULL,
	[CarYear] DATE NOT NULL,
	[CategoryId] INT CONSTRAINT [FK_Cars_CategoryId] FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	[Doors] INT NOT NULL,
	[Picture] VARBINARY CONSTRAINT [CHK_Cars_Picture] CHECK(DATALENGTH(Picture) <= (1024 * 5) * 1024),
	[Condition] NVARCHAR(25),
	[Available] BIT NOT NULL
)

INSERT INTO Cars VALUES
	('BT 0001 TB', 'Opel', 'Corsa', '2015-01-01', 1, 3, null, 'Perfect', 1),
	('BT 0002 TB', 'Opel', 'Vectra', '2016-01-01', 2, 5, null, 'Good', 1),
	('BT 0003 TB', 'Opel', 'Mocca', '2015-01-01', 3, 5, null, 'Perfect', 0)

CREATE TABLE Employees
(
	[Id] INT CONSTRAINT [PK_Employees_Id] PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[FirstName] VARCHAR(50) NOT NULL,
	[LastName] VARCHAR(50) NOT NULL,
	[Title] VARCHAR(10) NOT NULL,
	[Notes] NVARCHAR(255) 
) 

INSERT INTO Employees VALUES 
	('Pesho', 'Peshov', 'Mr.', null),
	('Minka', 'Minkova', 'Mrs.', null),
	('Tosho', 'Toshov', 'Mr.', null)

CREATE TABLE Customers
(
	[Id] INT CONSTRAINT [PK_Costumers_Id] PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[DriverLicenceNumber] INT NOT NULL,
	[FullName] NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(255) NOT NULL,
	[City] NVARCHAR(50) NOT NULL,
	[ZIPCode] INT NOT NULL,
	[Notes] NVARCHAR(255)
)

INSERT INTO Customers VALUES
	(123456789, 'Ivan Ivanov', 'Nikola Gabrovski N42', 'Veliko Tarnovo', 5000, null),
	(123456788, 'Kiril Kirilov', 'Nikola Gabrovski N43', 'Veliko Tarnovo', 5000, null),
	(123456787, 'Stoyan Stoyanov', 'Nikola Gabrovski N44', 'Veliko Tarnovo', 5000, null)

CREATE TABLE RentalOrders
(
	[Id] INT CONSTRAINT [PK_RentalOrders_Id] PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[EmployeeId] INT CONSTRAINT [FK_RentalOrders_EmployeeId] FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	[CostumerId] INT CONSTRAINT [FK_RentalOrders_CostumerId] FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	[CarId] INT CONSTRAINT [FK_RentalOrders_CarId] FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	[TankLevel] INT NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT,
	[TotalKilometrage] INT,
	[StartDate] DATE CONSTRAINT [DFT_RentalOrders_StartDate] DEFAULT GETDATE() NOT NULL,
	[EndDate] DATE,
	[TotalDays] INT,
	[RateApplied] DECIMAL,
	[TaxRate] DECIMAL,
	[OrderStatus] BIT NOT NULL,
	[Notes] NVARCHAR(255)
)

INSERT INTO RentalOrders VALUES
	(1, 2, 3, 100, 40000, null, null, '2017-09-24', null, null, null, null, 0, null),
	(2, 3, 1, 50, 50000, null, null, '2017-09-23', null, null, null, null, 0, null),
	(3, 1, 2, 75, 20000, null, null, '2017-09-22', null, null, null, null, 0, null)
--- END OF INSERTION ---
