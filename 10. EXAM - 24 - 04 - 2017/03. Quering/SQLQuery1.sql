-----------------------------------------------------------------------------------------
USE [Washing Machine Service];
-----------------------------------------------------------------------------------------

-- 05. Clients by Name ------------------------------------------------------------------
SELECT FirstName, LastName, Phone FROM Clients 
ORDER BY LastName, ClientId;
-----------------------------------------------------------------------------------------

-- 06. Job Status -----------------------------------------------------------------------
SELECT Status, IssueDate FROM Jobs
WHERE Status <> 'Finished'
ORDER BY IssueDate, JobId;
-----------------------------------------------------------------------------------------

-- 07. Mechanic Assignments -------------------------------------------------------------
SELECT CONCAT(m.FirstName, ' ', m.LastName) AS Mechanic,
	   j.Status,
	   j.IssueDate 
FROM Mechanics AS m 
JOIN Jobs AS j ON j.MechanicId = m.MechanicId
ORDER BY j.MechanicId, j.IssueDate, j.JobId;
-----------------------------------------------------------------------------------------

-- 08. Current Clients ------------------------------------------------------------------
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS [Client],
	   DATEDIFF(DAY, j.IssueDate, '24 April 2017') AS [Days going],
	   j.Status
FROM Jobs AS j
JOIN Clients AS c ON c.ClientId = j.ClientId
WHERE j.Status <> 'Finished'
ORDER BY [Days going] DESC, j.ClientId;
-----------------------------------------------------------------------------------------


-- 09. Mechanic Performance -------------------------------------------------------------
SELECT r.[Mechanic], r.[Average Days] 
FROM
(
	SELECT m.MechanicId,
		   CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
		   AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate))[Average Days] 
	FROM Mechanics AS m
	JOIN Jobs AS j ON j.MechanicId = m.MechanicId
	GROUP BY m.MechanicId, CONCAT(m.FirstName, ' ', m.LastName)
) AS r
ORDER BY r.MechanicId;
-----------------------------------------------------------------------------------------


-- 10. Hard Earners ---------------------------------------------------------------------
SELECT TOP(3) CONCAT(m.FirstName, ' ', m.LastName) AS Mechanic,
	   r.Jobs 
FROM Mechanics AS m
JOIN
(
	SELECT MechanicId,
		   Status,
	       COUNT(JobId) AS [Jobs] 
	FROM Jobs 
	GROUP BY MechanicId, Status
	HAVING Status <> 'Finished' AND COUNT(JobId) > 1
) AS r ON r.MechanicId = m.MechanicId
ORDER BY r.MechanicId DESC;
-----------------------------------------------------------------------------------------


-- 11. Available Mechanics --------------------------------------------------------------
SELECT CONCAT(FirstName, ' ', LastName) AS Available 
FROM Mechanics 
WHERE MechanicId NOT IN(
							SELECT DISTINCT MechanicId FROM Jobs
							WHERE (Status = 'Pending' 
								  OR Status = 'In Progress')
								  AND MechanicId IS NOT NULL
						) 
ORDER BY MechanicId;
-----------------------------------------------------------------------------------------


-- 12. Parts Cost -----------------------------------------------------------------------
SELECT ISNULL(SUM(p.Price * op.Quantity), 0) FROM Parts AS p
JOIN OrderParts AS op ON op.PartId = p.PartId
JOIN Orders AS o ON o.OrderId = op.OrderId
WHERE DATEDIFF(WEEK, o.IssueDate, ' 24 April 2017') <= 3;
-----------------------------------------------------------------------------------------


-- 13. Past Expenses --------------------------------------------------------------------
SELECT j.JobId, ISNULL(Total, 0) AS Total FROM Jobs AS j
LEFT JOIN 
(
	SELECT o.JobId, SUM(p.Price) AS Total
	FROM Orders AS o
	JOIN
	(
		SELECT op.OrderId, ISNULL(SUM(p.Price * op.Quantity), 0) AS Price FROM Parts AS p
		JOIN OrderParts AS op ON op.PartId = p.PartId
		GROUP BY op.OrderId
	) AS p ON p.OrderId = o.OrderId
	GROUP BY o.JobId
) AS r ON r.JobId = j.JobId 
WHERE Status = 'Finished'
ORDER BY Total DESC, JobId;

-----------------------------------------------------------------------------------------


-- 14. Model Repair Time ----------------------------------------------------------------
SELECT ModelId, 
	   Name, 
	   CONCAT([Average Service Time], ' days') 
		   AS [Average Service Time]
FROM
(
	SELECT m.ModelId, m.Name, AVG(j.Diff) AS [Average Service Time]
	FROM Models AS m 
	JOIN
	(
		SELECT TOP 1000 DATEDIFF(DAY, IssueDate, FinishDate) AS Diff, * 
		FROM Jobs
	) AS j ON j.ModelId = m.ModelId
	GROUP BY m.ModelId, m.Name
) AS RESULT
ORDER BY RESULT.[Average Service Time];
-----------------------------------------------------------------------------------------



-- 15. Faultiest Model ------------------------------------------------------------------
SELECT TOP(1) WITH TIES
	   ms.Name AS [Model],
	   m.Times AS [Times Serviced],
	   ISNULL(SUM(s.Sum), 0) AS [Parts Total] 
FROM Jobs AS j
JOIN Orders AS o ON o.JobId = j.JobId
JOIN
(
	SELECT  ModelId, COUNT(JobId) AS Times 
	FROM Jobs
	GROUP BY ModelId
) AS m ON m.ModelId = j.ModelId
JOIN
(
	SELECT op.OrderId, ISNULL(SUM(p.Price * op.Quantity), 0) AS Sum 
	FROM OrderParts AS op
	JOIN Parts AS p ON p.PartId = op.PartId
	GROUP BY op.OrderId
) AS s ON s.OrderId = o.OrderId
JOIN Models AS ms ON ms.ModelId = m.ModelId
GROUP BY ms.Name, m.Times
ORDER BY m.Times DESC


SELECT TOP 1 WITH TIES
       m.Name,
       COUNT(*) AS [Times Serviced],
       (SELECT ISNULL(SUM(p.Price * op.Quantity), 0) FROM Jobs AS j
        JOIN Orders AS o ON o.JobId = j.JobId
        JOIN OrderParts AS op ON op.OrderId = o.OrderId
        JOIN Parts AS p ON p.PartId = op.PartId
        WHERE j.ModelId = m.ModelId) AS [Parts Total]
  FROM Models AS m
JOIN Jobs AS j ON j.ModelId = m.ModelId
GROUP BY m.ModelId, m.Name
ORDER BY [Times Serviced] DESC
-----------------------------------------------------------------------------------------


-- 16. Missing Parts --------------------------------------------------------------------

-----------------------------------------------------------------------------------------
