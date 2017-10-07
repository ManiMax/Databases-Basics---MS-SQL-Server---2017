CREATE TABLE Teachers
(
	[ID] INT IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL, 
	[ManagerID] INT,

	CONSTRAINT [PK_Teachers] 
	PRIMARY KEY ([ID]),

	CONSTRAINT [FK_Teachers]
	FOREIGN KEY (ManagerID) 
	REFERENCES Teachers([ID])
);
GO

INSERT INTO Teachers VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);
GO