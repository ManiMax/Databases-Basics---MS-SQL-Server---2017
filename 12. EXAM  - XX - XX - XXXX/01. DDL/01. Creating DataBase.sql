--CREATE DATABASE [TheNerdHerd];

--USE [TheNerdHerd];

/*   Credentials:   

Column Name	     Data Type                          Constraints
------------------------------------------------------------------------------
Id	             Integer from 0  to 2,147,483,647	Unique table identificator
Email	         String up to 30 symbols	
Password	     String up to 20 symbols	


*/

CREATE TABLE Credentials
(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Email VARCHAR(30),
	Password VARCHAR(20)
);

/*   Locations:   

Column Name     Data Type                 Constraints
--------------------------------------------------------------------
Id	Integer     from 0 to 2,147,483,647	  Unique table identificator
Latitude	    Floating point number	
Longitude	    Floating point number	


*/

CREATE TABLE Locations
(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Latitude FLOAT,
	Longitude FLOAT
);


/*   Users:   

Column Name	   Data Type                        Constraints
---------------------------------------------------------------------------------------------------
Id	           Integer from 0 to 2,147,483,647	Unique table identificator, Identity
Nickname	   String up to 25 symbols	
Gender	       Character with 1 symbol	
Age	           Integer from 0 to 2,147,483,647	
Location_id	   Integer from  0 to 2,147,483,647	Relationship with locations
Credential_id  Integer from 0 to 2,147,483,647	Relationship with table credentials, Unique values


*/

CREATE TABLE Users
(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Nickname VARCHAR(25),
	Gender CHAR(1),
	Age INT,
	LocationId INT FOREIGN KEY REFERENCES Locations(Id),
	CredentialId INT FOREIGN KEY REFERENCES Credentials(Id) UNIQUE
);


/*   Chats:   

Column Name        Data Type                        Constraints
------------------------------------------------------------------------------
Id	              Integer from 0 to 2,147,483,647	Unique table identificator
Title	          String up to 32 symbols	
StartDate	      Date without time	
IsActive	      Bit	


*/

CREATE TABLE Chats
(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Title VARCHAR(32),
	StartDate DATE,
	IsActive BIT
);



/*   UsersChats: 

Column Name	Data Type	Constraints
-----------------------------------------------------------------------------------------------------
UserId	    Integer from 0 to 2,147,483,647	Unique table identificator, Relationship with table users
ChatId	    Integer from 0 to 2,147,483,647	Unique table identificator, Relationship with table chats


*/ 

CREATE TABLE UsersChats
(
	UserId INT FOREIGN KEY REFERENCES Users(Id),
	ChatId INT FOREIGN KEY REFERENCES Chats(Id),
	CONSTRAINT PK_UsersChats PRIMARY KEY (ChatId, UserId)
);



/*   Messages:   

Column Name	         Data Type                          Constraints
-------------------------------------------------------------------------------------
Id	                 Integer from 0 to 2,147,483,647	Unique table identificator
Content	             String up to 200 symbols	
SentOn	             Date without time	
ChatId	             Integer from 0 to 2,147,483,647	Relationship with table chats
UserId	             Integer from 0 to 2,147,483,647	Relationship with table users


*/

CREATE TABLE Messages
(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Content VARCHAR(200),
	SentOn DATE, 
	ChatId INT FOREIGN KEY REFERENCES Chats(Id), 
	UserId INT FOREIGN KEY REFERENCES Users(Id) 
)
