CREATE TABLE People
(
	Id INT IDENTITY(1,1) UNIQUE,
	Name NVARCHAR(200) NOT NULL,
	Picture VARBINARY CHECK(DATALENGTH(Picture) <= 900 * 1024),
	Height DECIMAL(10, 2),
	Weight DECIMAL(10, 2),
	Gender VARCHAR(1) NOT NULL CHECK(Gender ='m' OR Gender ='f'),
	Birthdate DATE DEFAULT GETDATE() NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
	VALUES ('Pesho', null, 180, 82, 'f', '1980-01-02', 'Student')

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
	VALUES ('Gosho', null, 181.399, 83.3, 'm', '1981-02-03', 'Student')

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
	VALUES ('Ivan', null, 182.4, 84.4556 , 'f', '1982-03-04', 'Student')

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
	VALUES ('Minka', null, 164.5, 45, 'm', '1983-04-05', 'Student')

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
	VALUES ('Penka', null, 165, 56.1984, 'f', '1984-05-06', 'Student')