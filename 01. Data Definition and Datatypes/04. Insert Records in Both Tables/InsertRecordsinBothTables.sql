CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions
(
	Id INT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Age INT,
	CONSTRAINT PK_Minions PRIMARY KEY (Id) 
)

CREATE TABLE Towns
(
	Id INT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Towns PRIMARY KEY (Id)
)

ALTER TABLE Minions
	ADD TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL;
	
--- TO INSERTION ---
INSERT INTO Towns(Id, Name) 
	VALUES (1, 'Sofia')

INSERT INTO Towns(Id, Name) 
	VALUES (2, 'Plovdiv')

INSERT INTO Towns(Id, Name) 
	VALUES (3, 'Varna') 

INSERT INTO Minions(Id, Name, Age, TownID)
	VALUES (1, 'Kevin', 22, 1)

INSERT INTO Minions(Id, Name, Age, TownID)
	VALUES (2, 'Bob', 15, 3)

INSERT INTO Minions(Id, Name, Age, TownID)
	VALUES (3, 'Steward', Null, 2)
--- END OF INSERTION ---

TRUNCATE TABLE Minions;

DROP TABLE Minions;

DROP TABLE Towns;