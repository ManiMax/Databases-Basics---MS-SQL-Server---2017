/*   CONDITIONS   



*/
USE ReportService;

INSERT INTO Employees(FirstName, LastName, Gender, Birthdate, DepartmentId)
VALUES  ('Marlo', 'O�Malley', 'M', '1985-09-21', 1),
		('Niki', 'Stanaghan', 'F', '1969-11-26', 4),
		('Ayrton', 'Senna', 'M', '1960-03-21', 9),
		('Ronnie', 'Peterson', 'M', '1944-02-14', 9),
		('Giovanna', 'Amati', 'F', '1959-07-20', 5)

INSERT INTO Reports(CategoryId, StatusId, OpenDate, CloseDate, Description, UserId, EmployeeId)
VALUES  (1, 1, '04/13/2017', NULL, 'Stuck Road on Str.133', 6, 2),
		(6, 3, '09/05/2015', '12/06/2015', 'Charity trail running', 3, 5),
		(14, 2, '09/07/2015', NULL, 'Falling bricks on Str.58', 5, 2),
		(4, 3, '07/03/2017', '07/06/2017', 'Cut off streetlight on Str.11', 1, 1)
