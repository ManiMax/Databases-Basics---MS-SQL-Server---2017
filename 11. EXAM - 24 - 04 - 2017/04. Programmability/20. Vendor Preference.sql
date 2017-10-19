/*
	List all mechanics and their preference for each vendor as a percentage of parts’ quantities 
	they ordered for their jobs. 

	Express the percentage as an integer value. 
	
	Order them by:
	 - mechanic’s full name (ascending), 
	 - number of parts from each vendor (descending),
	 - by vendor name (ascending).

	Required columns:
	 • Mechanic Full Name
	 • Vendor Name
	 • Parts ordered from vendor
	 • Preference for Vendor (percantage of parts out of all parts count ordered by the mechanic)

     Mechanic          Vendor                        Parts     Preference
     --------------------------------------------------------------------
     Gary Nunlee       Shenzhen Ltd.                 2         100%
     Jess Chaffins     Qingdao Technology            4         57%
     Jess Chaffins     Suzhou Precision Products     2         28%
     Jess Chaffins     Fenghua Import Export         1         14%
     ...               ...                           ...       ...
*/

WITH cte AS
(
	SELECT CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
			v.Name AS [Vendor],
			SUM(op.Quantity) AS [Parts],
			COUNT(p.PartId) AS [Count]
	FROM Jobs AS j
	LEFT JOIN Mechanics AS m ON m.MechanicId = j.MechanicId
	LEFT JOIN Orders AS o ON o.JobId = j.JobId
	LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
	LEFT JOIN Parts AS p ON p.PartId = op.PartId
	JOIN Vendors AS v ON v.VendorId = p.VendorId
	GROUP BY v.Name, CONCAT(m.FirstName, ' ', m.LastName)
)

 SELECT cte.Mechanic, cte.Vendor, cte.Parts,
		CONCAT(CAST(CAST(cte.Count AS DECIMAL(10, 2)) / c.Sum * 100 AS INT), '%') AS [Preference]
FROM cte AS cte
JOIN(SELECT Mechanic, SUM([Count]) AS [Sum] FROM cte GROUP BY Mechanic) 
	AS c ON c.Mechanic = cte.Mechanic
ORDER BY Mechanic, Parts DESC, Vendor
