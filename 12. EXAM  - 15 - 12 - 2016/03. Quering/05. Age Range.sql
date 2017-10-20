/*   CONDITIONS   

    Select all users that are aged between 22 and 37 inclusively. 

	Nickname	Gender	Age
	-----------------------
    sbell0      F       23

*/

USE [TheNerdHerd];

SELECT Nickname, Gender, Age FROM Users WHERE Age BETWEEN 22 AND 37;