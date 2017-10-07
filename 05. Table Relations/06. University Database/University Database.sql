CREATE DATABASE University;
GO

USE University;
GO

CREATE TABLE Majors
(
	MajorID INT IDENTITY(1, 1),
	Name VARCHAR(50) NOT NULL,

	CONSTRAINT PK_Majors
	PRIMARY KEY (MajorID)
);
GO

CREATE TABLE Students
(
	StudentID INT IDENTITY(1, 1),
	StudentNumber INT NOT NULL,
	StudentName VARCHAR(50) NOT NULL,
	MajorID INT NOT NULL,

	CONSTRAINT PK_Students
	PRIMARY KEY (StudentID),

	CONSTRAINT FK_Students
	FOREIGN KEY (MajorID)
	REFERENCES Majors(MajorID)
);
GO

CREATE TABLE Payments
(
	PaymentID INT IDENTITY(1, 1),
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(15, 2),
	StudentID INT NOT NULL,

	CONSTRAINT PK_Payments
	PRIMARY KEY (PaymentID),

	CONSTRAINT FK_Payments
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID)
);
GO

CREATE TABLE Subjects
(
	SubjectID INT IDENTITY(1, 1),
	SubjectName VARCHAR(50) NOT NULL,

	CONSTRAINT PK_Subjects
	PRIMARY KEY (SubjectID)
);
GO

CREATE TABLE Agenda
(
	StudentID INT NOT NULL,
	SubjectID INT NOT NULL,

	CONSTRAINT PK_Agenda
	PRIMARY KEY (StudentID, SubjectID),

	CONSTRAINT FK_Agenda_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID),

	CONSTRAINT FK_Agenda_Subjects
	FOREIGN KEY (SubjectID)
	REFERENCES Subjects(SubjectID)
);
GO