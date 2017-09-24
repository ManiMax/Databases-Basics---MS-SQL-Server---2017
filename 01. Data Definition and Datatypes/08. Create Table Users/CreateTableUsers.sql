--- TO INSERTION ---
CREATE TABLE Users
(
	Id BIGINT IDENTITY(1, 1) UNIQUE,
	Username VARCHAR(30) UNIQUE NOT NULL,
	Password VARCHAR(26) NOT NULL,
	ProfilPicture VARBINARY CHECK(DATALENGTH(ProfilPicture) <= 900 * 1024),
	LastLoginTime DATE,
	IsDeleted BIT NOT NULL,
	CONSTRAINT PK_Users PRIMARY KEY (Id)
)

INSERT INTO Users VALUES
	('pesho', 'pesho_123', null, null, 0),
	('gosho', 'gosho_123', null, null, 0),
	('ivan', 'ivan_123', null, null, 1),
	('minka', 'minka_123', null, null, 0),
	('penka', 'penka_123', null, null, 1)
--- END OF INSERTION ---

ALTER TABLE Users
	DROP CONSTRAINT PK_Users;

ALTER TABLE Users
	ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username);

ALTER TABLE Users
	ADD CONSTRAINT CHK_Users CHECK(DATALENGTH(Password) >= 5);

ALTER TABLE Users
	ADD CONSTRAINT DEF_Users DEFAULT GETDATE() FOR LastLoginTime;

ALTER TABLE Users
	DROP CONSTRAINT PK_Users;

ALTER TABLE Users
	ADD CONSTRAINT PK_Users PRIMARY KEY (Id);

ALTER TABLE Users
	ADD CONSTRAINT UNQ_Users UNIQUE (Username);