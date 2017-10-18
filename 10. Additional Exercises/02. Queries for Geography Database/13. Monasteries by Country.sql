/*
	*** CONDITIONS ***

	1. Create a table Monasteries(Id, Name, CountryCode). Use auto-increment for the primary key.
 Create a foreign key between the tables Monasteries and Countries.
 Execute the following SQL script (it should pass without any errors):	

*/

USE Geography;

--BEGIN TRANSACTION
-- 1. 0 --
CREATE TABLE Monasteries
(
	Id INT IDENTITY,
	Name NVARCHAR(100),
	CountryCode CHAR(2),

	CONSTRAINT PK_MONASTERIES
	PRIMARY KEY(Id),

	CONSTRAINT FK_MONASTERIES_COUNTRIES
	FOREIGN KEY(CountryCode)
	REFERENCES Countries(CountryCode)
);


-- 1. 1 --
INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR');

--ROLLBACK;