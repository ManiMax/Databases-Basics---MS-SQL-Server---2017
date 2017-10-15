-- ExampleQuery
-- MyQuery
-- EQ -> MQ
-- #1 -> #2
CREATE TABLE Countries (
Id INT IDENTITY,
Name NVARCHAR(50) UNIQUE,
CONSTRAINT PK_Countries PRIMARY KEY (Id)
)

-- #2 -> #6
CREATE TABLE Customers (
Id INT IDENTITY,
FirstName NVARCHAR(25),
LastName NVARCHAR(25),
Gender CHAR(1) CHECK (Gender = 'M' OR Gender = 'F'),
Age INT,
PhoneNumber CHAR(10),
CountryId INT,
CONSTRAINT PK_Customers PRIMARY KEY (Id), 
CONSTRAINT FK_Customers_Countries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

-- #3 -> #1
CREATE TABLE Products (
Id INT IDENTITY,
Name NVARCHAR(25) UNIQUE,
Description NVARCHAR(250),
Recipe NVARCHAR(MAX),
Price MONEY CHECK (Price >= 0),
CONSTRAINT PK_Products PRIMARY KEY (Id)
)

-- #4 -> #7
CREATE TABLE Feedbacks (
Id INT IDENTITY,
Description NVARCHAR(255),
Rate DECIMAL(10, 2) CHECK (Rate BETWEEN 0 AND 10),
ProductId INT,
CustomerId INT,
CONSTRAINT PK_Feedbacks PRIMARY KEY (Id),
CONSTRAINT FK_Feedbacks_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),
CONSTRAINT FK_Feedbacks_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
)

-- #5 -> #3
CREATE TABLE Distributors (
Id INT IDENTITY,
Name NVARCHAR(25) UNIQUE,
AddressText NVARCHAR(30),
Summary NVARCHAR(200),
CountryId INT,
CONSTRAINT PK_Distributors PRIMARY KEY (Id),
CONSTRAINT FK_Distributors_Countries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

-- #6 -> #4
CREATE TABLE Ingredients (
Id INT IDENTITY,
Name NVARCHAR(30),
Description NVARCHAR(200),
OriginCountryId INT,
DistributorId INT,
CONSTRAINT PK_Ingredients PRIMARY KEY (Id),
CONSTRAINT FK_Ingredients_Countries FOREIGN KEY (OriginCountryId) REFERENCES Countries(Id),
CONSTRAINT FK_Ingredients_Distributors FOREIGN KEY (DistributorId) REFERENCES Distributors(Id)
)

-- #7 -> #5
CREATE TABLE ProductsIngredients (
ProductId INT,
IngredientId INT,
CONSTRAINT PK_ProductsIngredients PRIMARY KEY (IngredientId, ProductId),
CONSTRAINT FK_Pr FOREIGN KEY (ProductId) REFERENCES Products(Id),
CONSTRAINT FK_Ingr FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id)
)