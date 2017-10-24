/*   CONDITIONS   

	Select all categories which have reports with status “waiting” or “in progress” 
	and show their total number in the column “Reports Number”. 

	In the third column fill the main status type of  reports for the category 
	(e.g. 2 reports with status “waiting” and 3 reports with status “in progress” 
	result in value “in progress”). 
	
	If they are equal just fill in “equal”. 
	
	Order by category Name, then by Reports Number and then by Main Status.

	Category Name	     Reports Number	   Main Status
	Animal in Danger	 1				   in progress
	Art Events	         2				   equal
	Dangerous Building	 1				   waiting
*/

USE ReportService;

SELECT c.Name AS [Category Name], a.[Reports Number], a.[Main Status]
FROM
(
  SELECT 
    r.CategoryId, 
    COUNT(r.Id) AS [Reports Number],
    CASE 
      WHEN (SELECT COUNT(Id) FROM Reports
            WHERE CategoryId = r.CategoryId AND StatusId = 1) 
			> (SELECT COUNT(Id) FROM Reports
               WHERE CategoryId = r.CategoryId AND StatusId = 2) 
			THEN 'waiting'
	  WHEN (SELECT COUNT(Id) FROM Reports
            WHERE CategoryId = r.CategoryId AND StatusId = 1) 
			< (SELECT COUNT(Id) FROM Reports
               WHERE CategoryId = r.CategoryId AND StatusId = 2) 
			THEN 'in progress'
	  WHEN (SELECT COUNT(Id) FROM Reports
            WHERE CategoryId = r.CategoryId AND StatusId = 1) 
			= (SELECT COUNT(Id) FROM Reports
               WHERE CategoryId = r.CategoryId AND StatusId = 2) 
			THEN 'equal'
    END AS [Main Status]
  FROM Reports AS r
  WHERE r.StatusId IN(1, 2) 
  GROUP BY r.CategoryId
) AS a
JOIN Categories AS c ON c.Id = a.CategoryId
ORDER BY c.Name, a.[Reports Number], a.[Main Status];

