/*
     CONDITIONS: Find all user in games with information about them. 
    Display the game name, game type, username, level, cash and character name. 
    Sort the result by level in descending order, 
    then by username and game in alphabetical order. 
    Submit your query statement as Prepare DB & run queries in Judge.
 
	---------------------------------- OUTPUT --------------------------------------
	Game	            Game Type	Username	    Level	Cash		Character
    Calla lily white 	Kinky	    obliquepoof  	99	    7527.00		Monk
    Dubai	            Funny	    rateweed	    99	    7499.00		Barbarian
    Stonehenge	        Kinky	    terrifymarzipan	99	    4825.00		Witch Doctor
    ...                 ...         ...             ...     ...         ...
	--------------------------------------------------------------------------------
*/

USE Diablo;

SELECT g.Name AS [Game],
       gt.Name AS [Game Type],
	   u.Username,
	   ug.Level,
	   ug.Cash,
	   c.Name AS [Character] 
FROM Games AS g
JOIN UsersGames AS ug ON ug.GameId = g.Id
JOIN GameTypes AS gt ON gt.Id = g.GameTypeId
JOIN Users AS u ON u.Id = ug.UserId
JOIN Characters AS c ON c.Id = ug.CharacterId
ORDER BY ug.Level DESC, u.Username, [Game]