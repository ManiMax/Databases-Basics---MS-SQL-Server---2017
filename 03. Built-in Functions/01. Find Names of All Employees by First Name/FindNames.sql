--- Part I – Queries for SoftUni Database ---
USE SoftUni

--- 01. Find Names of All Employees by First Name ---
SELECT FirstName, LastName FROM Employees WHERE FirstName LIKE 'SA%'

--- 02. Find Names of All Employees by Last Name