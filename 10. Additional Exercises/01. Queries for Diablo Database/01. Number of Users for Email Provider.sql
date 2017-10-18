/* 
            CONDITION
 1. Number of Users for Email Provider:
Find number of users for email provider from the largest to smallest, 
then by Email Provider in ascending order.
 
------------- Output: ------------------
----------------------------------------
|    Email Provider  | Number Of Users |
|--------------------------------------|
| yahoo.com	         | 14			   |
| dps.centrin.net.id | 5			   |
| softuni.bg	 	 | 5			   |
| indosat.net.id	 | 4			   |
| ...	             | ...			   |
----------------------------------------

            SOLUTION:
*/

USE Diablo;
GO

SELECT RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider],
		COUNT(Id) AS [Number Of Users]
FROM Users
GROUP BY RIGHT(Email, LEN(Email) - CHARINDEX('@', Email))
ORDER BY [Number Of Users] DESC, [Email Provider]