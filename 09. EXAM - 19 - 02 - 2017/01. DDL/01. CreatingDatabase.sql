-- 0 ------------------------------------------------------------------------------------

CREATE DATABASE Bakery;

USE Bakery;

-- 1 ------------------------------------------------------------------------------------

CREATE TABLE Products
	   (
		  [Id] INT IDENTITY,
		  [Name] NVARCHAR(25) UNIQUE,
		  [Description] NVARCHAR(250),
		  [Recipe] NVARCHAR(MAX),
		  [Price] MONEY,

		  CONSTRAINT PK_Products_Id 
		  PRIMARY KEY([Id]),

		  CONSTRAINT CHK_Products_Id_Price 
		  CHECK([Price] > 0)
	   );

-- 2 ------------------------------------------------------------------------------------

CREATE TABLE Countries
	   (
		  [Id] INT IDENTITY,
		  [Name] NVARCHAR(50) UNIQUE,

		  CONSTRAINT PK_Countries_Id 
		  PRIMARY KEY([Id])
	   );

-- 3 ------------------------------------------------------------------------------------

CREATE TABLE Distributors
	   (
		  [Id] INT IDENTITY,
		  [Name] NVARCHAR(25) UNIQUE,
		  [AddressText] NVARCHAR(30),
		  [Summary] NVARCHAR(200),
		  [CountryId] INT,

		  CONSTRAINT PK_Distributors_Id 
		  PRIMARY KEY([Id]),

		  CONSTRAINT FK_Distributors_CountryId
		  FOREIGN KEY([CountryId])
		  REFERENCES Countries([Id])
	   );

-- 4 ------------------------------------------------------------------------------------

CREATE TABLE Ingredients
	   (
		  [Id] INT IDENTITY,
		  [Name] NVARCHAR(30),
		  [Description] NVARCHAR(200),
		  [OriginCountryId] INT,
		  [DistributorId] INT,

		  CONSTRAINT PK_Ingredients_Id 
		  PRIMARY KEY([Id]),

		  CONSTRAINT FK_Ingredients_OriginCountryId
		  FOREIGN KEY([OriginCountryId])
		  REFERENCES Countries([Id]),

		  CONSTRAINT FK_Ingredients_DistributorId
		  FOREIGN KEY([DistributorId])
		  REFERENCES Distributors([Id])
	   );

-- 5 ------------------------------------------------------------------------------------

CREATE TABLE ProductsIngredients
	   (
		  [ProductId] INT,
		  [IngredientId] INT,

		  CONSTRAINT PK_ProductsIngredients
		  PRIMARY KEY([ProductId], [IngredientId]),

		  CONSTRAINT FK_ProductsIngredients_ProductId
		  FOREIGN KEY([ProductId])
		  REFERENCES Products([Id]),

		  CONSTRAINT FK_ProductsIngredients_IngredientId
		  FOREIGN KEY([IngredientId])
		  REFERENCES Ingredients([Id])
	   );

-- 6 ------------------------------------------------------------------------------------

CREATE TABLE Customers
	   (
		  [Id] INT IDENTITY,
		  [FirstName] NVARCHAR(25),
		  [LastName] NVARCHAR(25),
		  [Gender] CHAR(1),
		  [Age] INT,
		  [PhoneNumber] CHAR(10),
		  [CountryId] INT,

		  CONSTRAINT PK_Customers_Id 
		  PRIMARY KEY([Id]),

		  CONSTRAINT CHK_Customers_Gender
		  CHECK([Gender] IN('M', 'F')),

		  CONSTRAINT CHK_Customers_PhoneNumber
		  CHECK(LEN([PhoneNumber]) = 10),

		  CONSTRAINT FK_Customers_CountryId
		  FOREIGN KEY([CountryId])
		  REFERENCES Countries([Id])
	   );

-- 7 ------------------------------------------------------------------------------------

CREATE TABLE Feedbacks
	   (
		  [Id] INT IDENTITY,
		  [Description] NVARCHAR(255),
		  [Rate] DECIMAL(4, 2),
		  [ProductId] INT,
		  [CustomerId] INT

		  CONSTRAINT PK_Feedbacks_Id 
		  PRIMARY KEY([Id]),

		  CONSTRAINT CHK_Feedbacks_Rate
		  CHECK([Rate] BETWEEN 0 AND 10),

		  CONSTRAINT FK_Feedbacks_ProductId
		  FOREIGN KEY([ProductId])
		  REFERENCES Products([Id]),

		  CONSTRAINT FK_Feedbacks_CustomerId
		  FOREIGN KEY([CustomerId])
		  REFERENCES Customers([Id])
	   );

-- *** ----------------------------------------------------------------------------------
