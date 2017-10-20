/*   CONDITIONS   

    Select all messages that are sent after 12.05.2014 and contain the word “just”. 
	Sort the results by the message id in descending order.

	Content                   SentOn
	-------------------------------------
    odio cras mi pede         
	malesuada in imperdiet 
	et commodo vulputate 
	justo in				  2014-07-30
	-------------------------------------
	...						  ...
*/

USE [TheNerdHerd];

SELECT Content, SentOn 
FROM Messages 
WHERE SentOn > '2014-05-12' AND Content LIKE '%just%'
ORDER BY Id DESC;