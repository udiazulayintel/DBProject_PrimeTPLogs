
CREATE FUNCTION [dbo].[Telemetry_GetPartitionIdForTimestamp]
(
	@Timestamp DATETIME
)
RETURNS INT 
AS
BEGIN
	-- The retention days are hardcoded to 30 days
	RETURN  (DATEDIFF(day, '01-01-2023', CONVERT(date, @Timestamp)) % 30 + 1)
END

GO

