--SELECT * FROM PrimeTelemetry_LotInTestingSession

SELECT *
from PrimeTelemetry_LotInTestingSession

SELECT Count(*)
from PrimeTelemetry_TestingSessionLogEntry

SELECT	sum(row_count)
FROM	sys.dm_db_partition_stats
WHERE	OBJECT_NAME(object_id) LIKE 'PrimeTelemetry_TestingSessionLogEntry'


SELECT globalLoggerSessionId,count(*) as c, Max(TestOrderNumber) as MaxOrderNum
FROM PrimeLogs
GROUP BY globalLoggerSessionId
HAVING count(*) > 500000 AND count(*) <> Max(TestOrderNumber) 

SELECT PrimeTelemetry_LotInTestingSession.LotInTestingSessionId,
 Count(PrimeTelemetry_TestingSessionLogEntry.LogEntryId) AS [Records]
,MAX(PrimeTelemetry_TestingSessionLogEntry.TestOrderNumber) AS MaxOrderNum
from PrimeTelemetry_LotInTestingSession 
INNER JOIN PrimeTelemetry_TestingSessionLogEntry ON PrimeTelemetry_LotInTestingSession.LotInTestingSessionId = PrimeTelemetry_TestingSessionLogEntry.LotInTestingSessionId
GROUP BY PrimeTelemetry_LotInTestingSession.LotInTestingSessionId
HAVING Count(PrimeTelemetry_TestingSessionLogEntry.LogEntryId) > 500000 
AND Count(PrimeTelemetry_TestingSessionLogEntry.LogEntryId) <> MAX(PrimeTelemetry_TestingSessionLogEntry.TestOrderNumber) 


TRUNCATE TABLE [dbo].[PrimeLogs]
TRUNCATE TABLE [dbo].[PrimeTelemetry_Area]
TRUNCATE TABLE [dbo].[PrimeTelemetry_DutId]
TRUNCATE TABLE [dbo].[PrimeTelemetry_InstanceName]
TRUNCATE TABLE [dbo].[PrimeTelemetry_LoggingSession]
TRUNCATE TABLE [dbo].[PrimeTelemetry_LogLevel]
TRUNCATE TABLE [dbo].[PrimeTelemetry_LogOperation]
TRUNCATE TABLE [dbo].[PrimeTelemetry_LogType]
TRUNCATE TABLE [dbo].[PrimeTelemetry_LotInTestingSession]
TRUNCATE TABLE [dbo].[PrimeTelemetry_TestMethodName]
TRUNCATE TABLE [dbo].[PrimeTelemetry_TestingSessionLogEntry]
TRUNCATE TABLE [dbo].[PrimeTelemetry_TestingSessionLogEntry_Parameters]


WITH C1 AS
(
   
)
SELECT	Sum(SUM(row_count)) 
FROM	C1



