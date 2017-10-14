--======================================================================================--
-- 01. DDL - Starts with creating of dbo.Bakery ------------------------------------------
CREATE DATABASE Bakery;

--------------------------------------- 0 ------------------------------------------------
--USE Bakery;

--------------------------------------- 1 ------------------------------------------------
CREATE TABLE Countries
(
	[Id] INT IDENTITY(1, 1) UNIQUE,
	[Name] NVARCHAR(25) UNIQUE,

	CONSTRAINT PK_Countries 
	PRIMARY KEY([Id])
);

		/*SET IDENTITY_INSERT Countries ON 		
		INSERT INTO Countries([Id], [Name]) 
		VALUES (5, 'Country5')
		SET IDENTITY_INSERT Countries OFF*/
		
		/*DROP TABLE Countries;*/

		/*TRUNCATE TABLE Countries;*/
		
		/*SELECT * FROM Countries;*/

--------------------------------------- 2 ------------------------------------------------
CREATE TABLE Customers
(
	[Id] INT IDENTITY(1, 1) UNIQUE,
	[FirstName] NVARCHAR(25),
	[LastName] NVARCHAR(25),
	[Gender] CHAR(1),
	[Age] INT,
	[PhoneNumber] VARCHAR(10),
	[CountryId] INT,

	CONSTRAINT PK_Customers
	PRIMARY KEY([Id]),

	CONSTRAINT CHK_Customers 
	CHECK([Gender] IN ('M', 'F')),

	CONSTRAINT FK_Customers_Countries
	FOREIGN KEY([CountryId])
	REFERENCES Countries([Id])
);

		/*SET IDENTITY_INSERT Customers ON 		
		INSERT INTO Customers
					(
						[Id], 
						[FirstName], 
						[LastName], 
						[Gender], 
						[Age],
						[PhoneNumber],
						[CountryId]
					) 
		VALUES (1, 'FirstName1', 'LastName1', 'M', 32, '0123456789', 5),
			   (2, 'FirstName2', 'LastName1', 'F', 32, '0123456789', 5)
		SET IDENTITY_INSERT Customers OFF*/
		
		/*DROP TABLE Customers;*/

		/*TRUNCATE TABLE Customers;*/
		
		/*SELECT * FROM Customers;*/

--------------------------------------- 3 ------------------------------------------------
CREATE TABLE Distributors
(
	[Id] INT IDENTITY(1, 1) UNIQUE,
	[Name] NVARCHAR(25),
	[AddressText] NVARCHAR(30),
	[Summary] NVARCHAR(200),
	[CountryId] INT ,

	CONSTRAINT PK_Distributors
	PRIMARY KEY([Id]),

	CONSTRAINT UNQ_Name UNIQUE([Name]),

	CONSTRAINT FK_Distributors 
	FOREIGN KEY([CountryId])
    REFERENCES Countries([Id])
);

		/*SET IDENTITY_INSERT Distributors ON 		
		INSERT INTO Distributors([Id], [Name], [AddressText], [Summary], [CountryId]) 
		VALUES (2, 'Name2', 'AddressText2', 'Summary2', 5)
		SET IDENTITY_INSERT Distributors OFF*/
		
		/*DROP TABLE Distributors;*/

		/*TRUNCATE TABLE Distributors;*/
		
		/*SELECT * FROM Distributors;*/

--------------------------------------- 4 ------------------------------------------------
CREATE TABLE Products 
(
	[Id] INT IDENTITY(1, 1) UNIQUE,
	[Name] NVARCHAR(25),
	[Description] NVARCHAR(250),
	[Recipe] NVARCHAR(MAX),
	[Price] DECIMAL(19, 5)

	CONSTRAINT PK_Products 
	PRIMARY KEY([Id])
);

		/*SET IDENTITY_INSERT Products ON 		
		INSERT INTO Products([Id], [Name], [Description], [Recipe], [Price]) 
		VALUES (2, 'ProbeName', 'ProbeDescription', 'ProbeRecipe', 13)
		SET IDENTITY_INSERT Products OFF*/
		
		/*DROP TABLE Products;*/

		/*TRUNCATE TABLE Products;*/
		
		/*SELECT * FROM Products;*/

--------------------------------------- 5 ------------------------------------------------
CREATE TABLE Feedbacks
(
	[Id] INT UNIQUE IDENTITY,
	[Description] NVARCHAR(255),
	[Rate] NUMERIC(4, 2),
	[ProductId] INT,
	[CustomerId] INT,

	CONSTRAINT PK_Feedback 
	PRIMARY KEY([Id]),

	CONSTRAINT CHK_Feedback 
	CHECK([Rate] BETWEEN 0 AND 10),

	CONSTRAINT FK_Feedbacks_Products 
	FOREIGN KEY([ProductId])
	REFERENCES Products([Id]),

	CONSTRAINT FK_Feedbacks_Customers 
	FOREIGN KEY([CustomerId])
	REFERENCES Customers([Id])
);

		/*SET IDENTITY_INSERT Feedbacks ON 		
		INSERT INTO Feedbacks
					(
						[Id], 
						[Description], 
						[Rate], 
						[ProductId], 
						[CustomerId]
					) 
		VALUES (1, 'Description1', 1, 2, 2)
		SET IDENTITY_INSERT Feedbacks OFF*/
		
		/*DROP TABLE Feedbacks;*/

		/*TRUNCATE TABLE Feedbacks;*/
		
		/*SELECT * FROM Feedbacks;*/

--------------------------------------- 6 ------------------------------------------------
CREATE TABLE Ingredients
(
	[Id] INT IDENTITY(1, 1) UNIQUE,
	[Name] NVARCHAR(30),
	[Description] NVARCHAR(200),
	[OriginCountryId] INT,
	[DistributorId] INT,

	CONSTRAINT PK_Ingredients 
	PRIMARY KEY([Id]),

	CONSTRAINT FK_Ingredients_Countries 
	FOREIGN KEY([OriginCountryId])
	REFERENCES Countries([Id]),

	CONSTRAINT FK_Ingredients_Distributors 
	FOREIGN KEY([DistributorId])
	REFERENCES Distributors([Id])
);

		/*SET IDENTITY_INSERT Ingredients ON 		
		INSERT INTO Ingredients
					(
						[Id], 
						[Name], 
						[Description], 
						[OriginCountryId], 
						[DistributorId]
					) 
		VALUES (1, 'Name1', 'Description1', 5, 2)
		SET IDENTITY_INSERT Ingredients OFF*/
		
		/*DROP TABLE Ingredients;*/

		/*TRUNCATE TABLE Ingredients;*/
		
		/*SELECT * FROM Ingredients;*/

--------------------------------------- 7 ------------------------------------------------
CREATE TABLE ProductsIngredients
(
	[ProductId] INT,
	[IngredientId] INT,

	CONSTRAINT UQ_ProductsIngredients 
	UNIQUE([ProductId], [IngredientId]),

	CONSTRAINT FK_ProductsIngredients_Products
	FOREIGN KEY([ProductId])
	REFERENCES Products([Id]),

	CONSTRAINT FK_ProductsIngredients_Ingredients
	FOREIGN KEY([IngredientId])
	REFERENCES Ingredients([Id])
);

		/*INSERT INTO ProductsIngredients([ProductId], [IngredientId]) 
		  VALUES (2, 1)*/
		
		/*DROP TABLE ProductsIngredients;*/

		/*TRUNCATE TABLE ProductsIngredients;*/
		
		/*SELECT * FROM ProductsIngredients;*/

--======================================================================================--