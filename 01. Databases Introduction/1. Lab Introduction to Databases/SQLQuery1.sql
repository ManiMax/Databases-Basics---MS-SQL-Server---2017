-------------------------------------------------------------------------------------
-- 1. Create a new database named Bank using the MS SQL Server Management Studio GUI.

CREATE DATABASE Bank 
COLLATE Cyrillic_General_100_CI_AS;

------------------------------------------------------------------------------
-- 2.1 Using an SQL query, create table Clients with the following properties:
-- * Id – unique number for every client (auto-incremented, primary key).
-- * FirstName – the name of the user, which will be no more than 50 Unicode characters (Cannot be null).
-- * LastName – has the same properties as FirstName.

USE Bank

CREATE TABLE Clients 
(
	ClientID INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL 
) 


-------------------------------------
-- 2.2 Create table AccountType with:
-- * Id – unique number for every type. (Auto incremented, primary key).
-- * Name – the name of the account type, no longer than 50 Unicode characters (Cannot be null).

CREATE TABLE AccountType 
(
	AcountTypeID INT PRIMARY KEY IDENTITY,
	AcountName NVARCHAR(50) NOT NULL
)


----------------------------------
-- 2.3 Create table Accounts with:
-- * Id - unique number for every user. (Auto incremented, primary key).
-- * AccountTypeId – references the AccountTypes table (foreign key).
-- * Balance – decimal data type with up to 15 digits including 2 after the decimal point 
-- and a default value of 0 (Not null).
-- * ClientId – references the Clients table (foreign key).

CREATE TABLE Accounts
(
	AccountID INT PRIMARY KEY IDENTITY,
	ClientID INT FOREIGN KEY REFERENCES Clients(ClientID),
	TypeID INT FOREIGN KEY REFERENCES AccountType(AcountTypeID),
	Balance DECIMAL(15,2) DEFAULT(0) NOT NULL
)


---------------------------------------
-- 3. Insert Sample Data into Database.

INSERT INTO Clients(FirstName, LastName) VALUES
	( '????', 'Ivanov' ),
	( '????', 'Petrov' ),
	( '????', 'Iliev' ),
	( '????', 'Ivanova' )

INSERT INTO AccountType(AcountName) VALUES
	( 'Checking' ),
	( 'Savings' )

INSERT INTO Accounts(ClientID, TypeID, Balance) VALUES
	( 1, 1, 175 ),
	( 2, 1, 275.56 ),
	( 3, 1, 138.01 ),
	( 4, 1, 40.30 ),
	( 4, 2, 375.50 )
