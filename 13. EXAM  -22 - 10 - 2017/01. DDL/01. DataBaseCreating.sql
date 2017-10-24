CREATE DATABASE ReportService;
GO
	
USE [ReportService];
GO

/*    USERS    

	Id	Integer from 0 to 2,147,483,647	Unique table identificator, Identity
    Username	String up to 30 symbols, Unicode	NULL is not allowed, Unique values only
    Password	String up to 50 symbols, Unicode	NULL is not allowed
    Name	String up to 50 symbols, Unicode	
    Gender	Character with exactly 1 symbol	Could be: 'M' or 'F'
    BirthDate	DateTime	
    Age	Integer from 0 to 2,147,483,647	
    Email	String up to 50 symbols, Unicode	NULL is not allowed

*/
CREATE TABLE Users
(
	Id INT PRIMARY KEY IDENTITY,
	Username NVARCHAR(30) UNIQUE NOT NULL,
	Password NVARCHAR(50) NOT NULL,
	Name NVARCHAR(50),
	Gender CHAR(1) CHECK(Gender IN('M', 'F')),
	BirthDate DATE,
	Age INT,
	Email NVARCHAR(50) NOT NULL
);


/*   DEPARTMENTS    
	Column Name	Data Type	Constraints
	Id	Integer from 0 to 2,147,483,647	Unique table identificator, Identity
	Name	String up to 50 symbols, Unicode	NULL is not allowed
*/
CREATE TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL
);



/*
	Column Name	Data Type	Constraints
	Id	Integer from 0 to 2,147,483,647	Unique table identificator, Identity
	Name	String up to 50 symbols	NULL is not allowed
	DepartmentId	Integer from 0 to 2,147,483,647	Relationship with table Departments
*/

CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
);



/*
	Column Name	Data Type	Constraints
	Id	Integer from 0 to 2,147,483,647	Unique table identificator, Identity
	FirstName	String up to 25 symbols, Unicode	
	LastName	String up to 25 symbols, Unicode	
	Gender	Character with exactly 1 symbol	Could be: 'M' or 'F'
	BirthDate	DateTime	
	Age	Integer from 0 to 2,147,483,647	
	DepartmentId	Integer from 0 to 2,147,483,647	NULL is not allowed, Relationship with table Departments
		
*/

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Gender CHAR(1) CHECK(Gender IN('M', 'F')),
	BirthDate DATE,
	Age INT,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL
);


/*
	Column Name	Data Type	Constraints
	Id	Integer from 0 to 2,147,483,647	Unique table identificator, Identity
	Label	String up to 30 symbols	NULL is not allowed
*/
CREATE TABLE Status
(
	Id INT PRIMARY KEY IDENTITY,
	Label VARCHAR(30) NOT NULL
);


/*
	Id	Integer from 0 to 2,147,483,647	Unique table identificator, Identity
	CategoryId	Integer from 0 to 2,147,483,647	NULL is not allowed, Relationship with table Categories
	StatusId	Integer from 0 to 2,147,483,647	NULL is not allowed, Relationship with table Status
	OpenDate	DateTime	NULL is not allowed
	CloseDate	DateTime	
	Description	String up to 200 symbols	
	UserId	Integer from 0 to 2,147,483,647	NULL is not allowed, Relationship with table Users
	EmployeeId	Integer from 0 to 2,147,483,647	Relationship with table Employees

*/

CREATE TABLE Reports
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	StatusId INT FOREIGN KEY REFERENCES Status(Id) NOT NULL,
	OpenDate DATE NOT NULL,
	CloseDate DATE,
	Description VARCHAR(200),
	UserId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL,
	EmployeeId  INT FOREIGN KEY REFERENCES Employees(Id)
);