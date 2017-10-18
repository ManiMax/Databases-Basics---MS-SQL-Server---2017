--/*
--	*** CONDITIONS ***

--	1. Create a table Monasteries(Id, Name, CountryCode). Use auto-increment for the primary key.
-- Create a foreign key between the tables Monasteries and Countries.
-- Execute the following SQL script (it should pass without any errors):	

--*/

--USE Geography;

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


--/*
--    2. Write a SQL command to add a new Boolean column IsDeleted in the Countries table 
--(defaults to false). Note that there is no "Boolean" type in SQL server, so you should use 
--an alternative and make sure you set the default value properly.

--    3. Write and execute a SQL command to mark as deleted all countries that have more than 3 rivers.

--    4. Write a query to display all monasteries along with their countries sorted by monastery name. 
--Skip all deleted countries and their monasteries.


--*/

--/*
--SELECT * FROM Countries

--ALTER TABLE Countries
--ADD IsDeleted BIT DEFAULT(0) NOT NULL
--*/

UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN 
(SELECT SELECTED.CountryCode FROM (SELECT c.CountryCode, COUNT(cr.RiverId) AS [RiverCount]
FROM Countries AS c
JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
GROUP BY c.CountryCode
HAVING COUNT(cr.RiverId) > 3) AS SELECTED);


SELECT m.Name AS [Monasterie]
	 , c.CountryName AS [Country]
FROM Countries AS c
JOIN Monasteries AS m ON m.CountryCode = c.CountryCode 
WHERE c.IsDeleted = 0
ORDER BY [Monasterie];