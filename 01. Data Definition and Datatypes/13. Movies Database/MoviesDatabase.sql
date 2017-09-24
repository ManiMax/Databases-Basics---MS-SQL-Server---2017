USE master

CREATE DATABASE Movies

USE Movies

--- TO INSERTING ---
CREATE TABLE Directors
(
	Id INT IDENTITY(1, 1) NOT NULL,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX),
	CONSTRAINT PK_Directors PRIMARY KEY (Id)
)

INSERT INTO Directors VALUES
	('Steven Spielberg', 'Undoubtedly one of the most influential film personalities in the history of film'),
	('Quentin Tarantino', 'FIVE of his films are included in the Top 250 Movie List with Pulp Fiction being the most popular at #4!'),
	('Jerry Bruckheimer', 'PiratesoftheCaribbean - Dead Men Tell No Tales.'),
	('Peter Jackson', 'This New Zealand-born movie buff started small with the low-budget Bad Taste and worked his way up to the epic Lord of the Rings'),
	('Martin Scorsese', 'No one captures alienated men on the edge the way he''s done in Taxi Driver, Raging Bull, and The Departed')

CREATE TABLE Genres
(
	Id INT IDENTITY(1, 1) NOT NULL,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX),
	CONSTRAINT PK_Genres PRIMARY KEY (Id)
)

INSERT INTO Genres VALUES
	('Triller', null),
	('Crime', null),
	('Comedy', null),
	('Adventure', null),
	('Action', null)

CREATE TABLE Categories
(
	Id INT IDENTITY(1, 1) NOT NULL,
	CategorieName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX),
	CONSTRAINT PK_Categories PRIMARY KEY (Id)
)

INSERT INTO Categories VALUES
	('Films by country', null),
	('Films by date', null),
	('Films by director', null),
	('Films by genre?', null),
	('Films by language?', null)

CREATE TABLE Movies
(
	Id INT IDENTITY(1, 1) NOT NULL,
	Title NVARCHAR(200) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear DATE DEFAULT GETDATE(),
	Length DECIMAL(20,2) DEFAULT(0),
	GenreId INT NOT NULL,
	CategorieId INT NOT NULL,
	Rating INT DEFAULT(0),
	Notes NVARCHAR(MAX),
	CONSTRAINT PK_Movies PRIMARY KEY (Id),
	CONSTRAINT FK_Director FOREIGN KEY (DirectorId) REFERENCES Directors(Id),
	CONSTRAINT FK_Genre FOREIGN KEY (GenreId) REFERENCES Genres(Id),
	CONSTRAINT FK_Categorie FOREIGN KEY (CategorieId) REFERENCES Categories(Id)
)

INSERT INTO Movies(Title, DirectorId, GenreId, CategorieId, Notes) VALUES
	('First movie', 1, 2, 3, null),
	('Second movie', 2, 3, 4, null),
	('Third movie', 3, 4, 5, null),
	('Fourt movie', 4, 5, 1, null),
	('Fift movie', 5, 1, 2, null)
--- END OF INSERTION ---