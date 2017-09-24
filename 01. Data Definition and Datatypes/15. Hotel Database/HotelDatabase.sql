USE master

CREATE DATABASE Hotel

USE Hotel

--- TO INSERTING ---
--- Employees (Id, FirstName, LastName, Title, Notes) ---
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	FirstName NVARCHAR(200) NOT NULL,
	LastName NVARCHAR(200) NOT NULL,
	Title NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(255)
)

INSERT INTO Employees VALUES
	('Minka', 'Minkova', 'Mrs.', null),
	('Penka', 'Penkova', 'Mrs.', null),
	('Mara', 'Marova', 'Mrs.', null)

--- Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) ---
CREATE TABLE Customers 
(
	AccountNumber VARCHAR(120) NOT NULL,
	FirstName NVARCHAR(200) NOT NULL,
	LastName NVARCHAR(200) NOT NULL,
	PhoneNumber VARCHAR(150) NOT NULL,
	EmergencyName NVARCHAR(500),
	EmergencyNumber	VARCHAR(150),
	Notes NVARCHAR(2550)
)

INSERT INTO Customers VALUES
	('123456789001', 'Pesho', 'Peshov', '0888 123 456', null, null, null),
	('123456789002', 'Gosho', 'Goshov', '0888 123 457', 'Pesho Peshov', '0888 123 456', null),
	('123456789001', 'Kiro', 'Kirov', '0888 123 458', 'Gosho Goshov', '0888 123 457', 'regular client...')

--- RoomStatus (RoomStatus, Notes) ---
CREATE TABLE RoomStatus
(
	RoomStatus NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(2550)
)

INSERT INTO RoomStatus VALUES
	('FULL', null),
	('FULL', null),
	('EMPTY', null)

--- RoomTypes (RoomType, Notes) ---
CREATE TABLE RoomTypes 
(
	RoomType VARCHAR(100) NOT NULL,
	Notes NVARCHAR(2550)
)

INSERT INTO RoomTypes VALUES
	('Apartment', null),
	('Room', null),
	('Double Room', null)

--- BedTypes (BedType, Notes) ---
CREATE TABLE BedTypes 
(
	BedType VARCHAR(100) NOT NULL,
	Notes NVARCHAR(2550)
) 

INSERT INTO BedTypes VALUES
	('one bed', null),
	('double bed', null),
	('middle bed', null)

--- Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes) ---
CREATE TABLE Rooms 
(
	RoomNumber INT NOT NULL,
	RoomType VARCHAR(100) NOT NULL,
	BedType VARCHAR(100) NOT NULL,
	Rate INT,
	RoomStatus NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(2550)
)

INSERT INTO Rooms VALUES
	(1, 'Apartment', 'double bed', null, 1, null),
	(1, 'Room', 'bed', null, 1, null),
	(1, 'Room', 'middle bed', null, 0, null)


--- Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, ---
---           TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) ---
CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	EmployeedId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	PaymentDate DATE,
	AccountNumber VARCHAR(150) NOT NULL,
	FirstDateOccupied DATE,
	LastDateOccupied DATE,
	TotalDays INT,
	AmountCharged INT,
	TaxRate INT,
	TaxAmount INT,
	PaymentTotal INT,
	Notes NVARCHAR(255)
)

INSERT INTO Payments(EmployeedId, AccountNumber) VALUES
	(1, '1342 6342 4341'),
	(3, '1334 6342 46741'),
	(2, '7642 6512 4349')

--- Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) ---
CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeedId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATE,
	AccountNumber VARCHAR(150) NOT NULL,
	RoomNumber INT,
	RateAplied DECIMAL,
	PhoneCharge	INT,
	Notes NVARCHAR(2550)
)

INSERT INTO Occupancies(EmployeedId, AccountNumber) VALUES
	(1, '1342 6342 4341'),
	(3, '2017-09-31'),
	(2, '7642 6512 4349')
--- END OF INSERTION ---