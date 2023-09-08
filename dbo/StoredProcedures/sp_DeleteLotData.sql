-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>

-- EXEC sp_DeleteLotData 'Y394882UDI'
-- =============================================
CREATE PROCEDURE sp_DeleteLotData
(
	@Lot Varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @LotInTestingSessionId INT
	SELECT @LotInTestingSessionId = LotInTestingSessionId FROM [dbo].[PrimeTelemetry_LotInTestingSession]
	WHERE Lot = @Lot

	DELETE FROM [PrimeTelemetry_LotInTestingSession]
	WHERE LotInTestingSessionId = @LotInTestingSessionId

    DELETE FROM [dbo].[PrimeTelemetry_Area]
	WHERE [AreaId] 
		IN (SELECT DISTINCT [AreaId] 
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)


	DELETE FROM [dbo].[PrimeTelemetry_DutId]
	WHERE [SessionDutId]
		IN (SELECT DISTINCT [WithinSessionDutId]
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)

	DELETE FROM [dbo].[PrimeTelemetry_InstanceName]
	WHERE [InstanceNameId]
		IN (SELECT DISTINCT [InstanceNameId]
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)


	DELETE FROM [dbo].[PrimeTelemetry_LoggingSession]
	WHERE [LoggerSessionId]
		IN (SELECT DISTINCT [LoggerSessionId]
			FROM [dbo].[PrimeTelemetry_LotInTestingSession]
			WHERE LotInTestingSessionId = @LotInTestingSessionId)

	DELETE FROM  [dbo].[PrimeTelemetry_LogLevel]
	WHERE [LogLevelId]
		IN (SELECT DISTINCT [LogLevelId]
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)

	DELETE FROM  [dbo].[PrimeTelemetry_LogOperation]
	WHERE [LogOperationId]
		IN (SELECT DISTINCT [LogOperationId]
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)

	DELETE FROM   [dbo].[PrimeTelemetry_LogType]
	WHERE [LogTypeId]
		IN (SELECT DISTINCT [LogTypeId]
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)

	DELETE FROM   [dbo].[PrimeTelemetry_TestMethodName]
	WHERE [TestMethodNameId]
		IN (SELECT DISTINCT [TestMethodNameId]
			FROM [dbo].[Telemetry_TestingSessionLogEntry]  
			WHERE LotInTestingSessionId = @LotInTestingSessionId)

	DELETE T1
	FROM [dbo].[PrimeTelemetry_TestingSessionLogEntry_Parameters] AS T1
	INNER JOIN [dbo].[PrimeTelemetry_TestingSessionLogEntry] AS T2
	ON T1.[LogEntryId] = T2.[LogEntryId]
	WHERE T2.[LotInTestingSessionId] = @LotInTestingSessionId;

	DELETE FROM [dbo].[PrimeTelemetry_TestingSessionLogEntry]
	WHERE [LotInTestingSessionId] = @LotInTestingSessionId
	

END

GO

