/*   CONDITIONS   


 Delete all reports who have a status “blocked”.
*/
USE ReportService;

DELETE Reports
WHERE StatusId = 4;