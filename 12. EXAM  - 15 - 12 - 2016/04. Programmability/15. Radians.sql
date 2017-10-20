/*   CONDITIONS   

   Create a user defined function that transforms degrees to radians. 
   The formula should multiply the degrees by Pi and then split by 180. 
   The return type must be float. Call the function udf_GetRadians.
    Parameters:
    ?	Degrees => RADIANS = (DEGREES * PI) / 180;


    Example:
    
       SELECT dbo.udf_GetRadians(22.12) AS Radians
    
    Radians
    0.386066830541146

*/


CREATE FUNCTION udf_GetRadians(@Radians FLOAT)
RETURNS FLOAT
BEGIN
	RETURN (@Radians * PI()) / 180;
END;
GO

SELECT dbo.udf_GetRadians(22.12) AS Radians;