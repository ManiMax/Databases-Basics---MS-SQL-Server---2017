/*
	*** CONDITIONS ***

Find all items and information whether and what forbidden game types they have. 
Display item name, price, min level and forbidden game type. Display all items. 
Sort the results by game type in descending order, then by item name in ascending order. 
Submit your query statement as Prepare DB & run queries in Judge.

    OUTPUT => Item  |  Price  | MinLevel  |  Forbidden Game Type
*/


SELECT i.Name AS [Item]
      ,i.Price
	  ,i.MinLevel
	  ,gt.Name AS [Forbidden Game Type] 
FROM Items AS i
LEFT JOIN GameTypeForbiddenItems AS gtfi ON gtfi.ItemId = i.Id
LEFT JOIN GameTypes AS gt ON gt.Id = gtfi.GameTypeId
ORDER BY [Forbidden Game Type] DESC, [Item]


SELECT i.Name AS Item, i.Price, i.MinLevel, gt.Name AS [Forbidden Game Type]
FROM Items AS i -- all items
  LEFT JOIN GameTypeForbiddenItems AS fi ON fi.ItemId = i.Id
  LEFT JOIN GameTypes AS gt ON fi.GameTypeId = gt.Id
ORDER BY [Forbidden Game Type] DESC, Item